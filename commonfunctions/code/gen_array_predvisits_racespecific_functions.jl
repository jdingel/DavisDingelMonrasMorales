## Author: Kevin Dano
## Date: April 2018
## Purpose: Create predicted visits array
## Packages required: DataFrames
## Julia version: 0.6.2

######################
# Functions
#####################

######################
# Generate identifiers
######################

function gen_userid(data,list_identifiers)

  df_sub = by(data,list_identifiers,df->DataFrame(userid_num = 1))
  df_sub[:userid_num]=cumsum(df_sub[:userid_num])

  data =  join(data,df_sub,on=list_identifiers,kind=:left)

  return data
end

function gen_venueid(Data,list_identifiers)

  df_sub = by(data,list_identifiers,df->DataFrame(randomvenueid = 1))
  df_sub[:randomvenueid]=cumsum(df_sub[:randomvenueid])

  Data =  join(Data,df_sub,on=list_identifiers,kind=:left)

  return Data
end

function gen_randomvenueid(data)

  temp = groupby(data,[:userid_num])
  temp2 = map(i->gen_venueid(temp[i][1:end]),collect(1:length(temp)))
  temp3 = append_list_df(temp2)

  return temp3
end

function gen_venueid(df)

  df[:randomvenueid] = collect(1:nrow(df))

  return df
end

############################
# Generate dummy variables
############################

function gen_dummy(df,var,prefix_dummy)

  values = sort(unique(df[Symbol(var)]))

  for i in values
    df[Symbol(string(prefix_dummy,i))] = (df[Symbol(var)].==i)
  end

  return df
end

function gen_dummy_cuisine(df,var,prefix_dummy)

  values = sort(unique(df[Symbol(var)]))

  for (index,val) in enumerate(values)
    df[Symbol(string(prefix_dummy,index))] = (df[Symbol(var)].==val)
  end

  return df
end

######################################
# Create array for predicted visits
######################################

#Final specification
function covariates_racespecific_dropalot(df;cuisinetype_midaggregate::Int = 0,nest_id::Int=0,keep_time_levels::Int=0,cars::Int=1)

  #Variables describing the trip
  keep_cols_string = ["tripnumber"; "userid_num"; "venue_num"]

  if nest_id == 1
    keep_cols_string = [keep_cols_string;"nest1";"nest2"]
  end

  #Informative info
  keep_cols_string = [keep_cols_string;covariates_startingby(df,"geoid11_[a-z]{4}\$")]

  if keep_time_levels == 0
    #Spatial frictions X1
    keep_cols_string = [keep_cols_string;[covariates_startingby(df,"time_.+_home_log\$");covariates_startingby(df,"time_.+_work_log\$");covariates_startingby(df,"time_.+_path_log\$")]]
  elseif keep_time_levels == 1
    keep_cols_string = [keep_cols_string;["time_public_home"; "time_public_work"; "time_car_home"; "time_car_work";"time_public_home_work";"time_car_home_work"]]
  end

  #Social frictions: X2
  keep_cols_string = [keep_cols_string;["eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"]]
  keep_cols_string = [keep_cols_string;["asian_percent";"black_percent"; "hispanic_percent"; "other_percent"]]
  #User-restaurant interactions: Z2
  keep_cols_string = [keep_cols_string;[covariates_startingby(df,"d_price_+._income\$");"avgrating_income"]]
  #Income differences
  keep_cols_string = [keep_cols_string;["median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"]]
  #Basic restaurant characteristics: Z1
  keep_cols_string = [keep_cols_string;[covariates_startingby(df,"d_price_[0-9]\$");"avgrating";covariates_startingby(df,"d_cuisine_[0-9]\$")]]
  #Robberies from NYPD microdf, area dummies/FEs
  keep_cols_string = [keep_cols_string;["robberies_0711_perres";covariates_startingby(df,"d_area_dummy_.+")]]
  #Optional restaurant characteristics used in robustness checks
  keep_cols_string = [keep_cols_string;["reviews_log";"chain"]]

  if cars == 1
    keep_cols_string = [keep_cols_string;["vehicle_avail_hhshare_diff"]]
  end

  if cuisinetype_midaggregate == 1
    d_cuisine_m_vars = covariates_startingby(df,"d_cuisine_m_*")
    keep_cols_string = [keep_cols_string;d_cuisine_m_vars]
  end

  keep_cols = map(i->Symbol(i),keep_cols_string)

  df = df[:,keep_cols]

  return df

end

#Creates additonal covariates of interest
function prepcovariates_racespecific(df;cuisinetype_midaggregate::Int = 0,nest_id::Int = 0,keep_time_levels::Int=0,cars::Int=1)

  #Transform variables
  df[:time_public_path]=max.(0,0.5.*(df[:time_public_home] + df[:time_public_work] - df[:time_public_home_work]))
  df[:time_car_path] = max.(0,0.5.*(df[:time_car_home] + df[:time_car_work] - df[:time_car_home_work]))

  #log of travel time in minutes [ln(t+1)]
  for i in ["time_public_home"; "time_public_work"; "time_public_path"; "time_car_home"; "time_car_work"; "time_car_path"]
    df[Symbol(string(i,"_log"))] = log.(df[Symbol(i)]+1)
  end

  df[:median_income_log] = log.(df[:median_household_income]*10000)

  #Generate dummies
  #price
  df = gen_dummy(df,"price","d_price_")
  #area
  df = gen_dummy(df,"area_dummy_assignment","d_area_dummy_")
  #cuisinetype aggregate
  df = gen_dummy_cuisine(df,"cuisinetype_aggregate","d_cuisine_")

  #Omitted categories: price of $, Bronx, "no_category" of cuisine, white plurality (dropped below)
  delete!(df,[:d_price_1;:d_area_dummy_1;:d_cuisine_8])

  if cuisinetype_midaggregate == 1
    df = gen_dummy_cuisine(df,"cuisinetype_midaggregate","d_cuisine_m_")
    delete!(df,:d_cuisine_m_36) #Omitted category: "no category of cuisine for the more detailed version
  end

  #Generate demographic interaction terms
  #EDD * SSI
  df[:eucl_demo_distance_ssi] = df[:eucl_demo_distance].*df[:spectralsegregationindex]

  #Generate tract-level bilateral relations
  df[:hisp_percent] = df[:hispanic_percent]
  df[:other_percent] = max.(0,1 - df[:asian_percent] - df[:black_percent] - df[:hispanic_percent]- df[:white_percent]) #Percent of tract population that is other

  #Generate income-price, income-rating, female-price, female-rating interactions
  for var in [covariates_startingby(df,"d_price_?");"avgrating"]
    df[Symbol(string(var,"_income"))] = df[Symbol(var)] .* df[:median_household_income_home]
  end

  #Generate log reviews
  df[:reviews_log] = log.(df[:reviews])

  df[:user_weight] = 1

  df = covariates_racespecific_dropalot(df;cuisinetype_midaggregate=cuisinetype_midaggregate,nest_id=nest_id,keep_time_levels=keep_time_levels,cars=cars)

  #sort
  sort!(df,cols = [order(:userid_num),order(:tripnumber),order(:venue_num)])

  return df
end

#Generate array for predicted visits
function predvisitarray(df,df_venues,df_geoid11,df_geoid11_home,df_geoid11_home_pair,df_geoid11_work_pair,df_geoid11_home_work,tract_num,randomvenuesupport;cuisinetype_midaggregate::Int = 0,nest_id::Int = 0,keep_time_levels::Int=0,cars::Int=1)

    #Keep specified tracts
    df = df[(df[:geoid11_home_num].==tract_num),:]

    #create user_id
    df = gen_userid(df,[:geoid11_home; :geoid11_work])

    #add tripnumnber
    df[:tripnumber] = 1

    #Merge user characteristics, venue characteristics, tract-pair characteristics, etc for every choice
    df = expand_df(df,randomvenuesupport)

    #generate randomvenueid
    df = gen_randomvenueid(df)

    #venues
    df = join(df,df_venues,on=:randomvenueid,kind=:inner)

    #geoid11_dest
    df = join(df,df_geoid11 ,on=:geoid11_dest,kind=:inner)

    #geoid11_home
    df = join(df,df_geoid11_home ,on=:geoid11_home,kind=:inner)

    #geoid11_home & geoid11_dest
    df = join(df,df_geoid11_home_pair,on=[:geoid11_home;:geoid11_dest],kind=:inner)

    #geoid11_work & geoid11_dest
    df = join(df,df_geoid11_work_pair,on=[:geoid11_work;:geoid11_dest],kind=:inner)

    #geoid11_home & geoid11_work
    df = join(df,df_geoid11_home_work,on=[:geoid11_home;:geoid11_work],kind=:inner)

    ###############################################
    # Prep covariates program
    ###############################################

    df = prepcovariates_racespecific(df;cuisinetype_midaggregate=cuisinetype_midaggregate,nest_id=nest_id,keep_time_levels=keep_time_levels,cars=cars)

  return df
end
