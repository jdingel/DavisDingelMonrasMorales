## Author: Kevin Dano
## Date: April 2018
## Purpose: Compute predicted visits
## Packages required: DataFrames
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Imported functions
include("general_functions.jl")
include("fit_mnl_newton.jl")
include("fit_nlogit_onelambda_multiperiod.jl")

##########################
# Functions
##########################

function prepare_spec_variations(norg,type_origin_mode,specification,data_estimates;bias="",nlogit::Int=0)

  if specification != "disaggcuis"
    spec_neither = ["d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "robberies_0711_perres"; "d_area_dummy_2"; "d_area_dummy_3"; "d_area_dummy_4"; "d_area_dummy_5"; "d_area_dummy_6"; "d_area_dummy_7"; "d_area_dummy_8"; "d_area_dummy_9"; "d_area_dummy_10"; "d_area_dummy_11"; "d_area_dummy_12"; "d_area_dummy_13"; "d_area_dummy_14"; "d_area_dummy_15"; "d_area_dummy_16"; "d_area_dummy_17"; "d_area_dummy_18"; "d_area_dummy_19"; "d_area_dummy_20"; "d_area_dummy_21"; "d_area_dummy_22"; "d_area_dummy_23"; "d_area_dummy_24"; "d_area_dummy_25"; "d_area_dummy_26"; "d_area_dummy_27"; "d_area_dummy_28"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"]
  elseif specification == "disaggcuis"
    spec_neither =["d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_m_1"; "d_cuisine_m_2"; "d_cuisine_m_3"; "d_cuisine_m_4"; "d_cuisine_m_5"; "d_cuisine_m_6"; "d_cuisine_m_7"; "d_cuisine_m_8"; "d_cuisine_m_9"; "d_cuisine_m_10"; "d_cuisine_m_11"; "d_cuisine_m_12"; "d_cuisine_m_13"; "d_cuisine_m_14"; "d_cuisine_m_15"; "d_cuisine_m_16"; "d_cuisine_m_17"; "d_cuisine_m_18"; "d_cuisine_m_19"; "d_cuisine_m_20"; "d_cuisine_m_21"; "d_cuisine_m_22"; "d_cuisine_m_23"; "d_cuisine_m_24"; "d_cuisine_m_25"; "d_cuisine_m_26"; "d_cuisine_m_27"; "d_cuisine_m_28"; "d_cuisine_m_29"; "d_cuisine_m_30"; "d_cuisine_m_31"; "d_cuisine_m_32"; "d_cuisine_m_33"; "d_cuisine_m_34"; "d_cuisine_m_35"; "d_cuisine_m_37"; "d_cuisine_m_38"; "d_cuisine_m_39"; "robberies_0711_perres"; "d_area_dummy_2"; "d_area_dummy_3"; "d_area_dummy_4"; "d_area_dummy_5"; "d_area_dummy_6"; "d_area_dummy_7"; "d_area_dummy_8"; "d_area_dummy_9"; "d_area_dummy_10"; "d_area_dummy_11"; "d_area_dummy_12"; "d_area_dummy_13"; "d_area_dummy_14"; "d_area_dummy_15"; "d_area_dummy_16"; "d_area_dummy_17"; "d_area_dummy_18"; "d_area_dummy_19"; "d_area_dummy_20"; "d_area_dummy_21"; "d_area_dummy_22"; "d_area_dummy_23"; "d_area_dummy_24"; "d_area_dummy_25"; "d_area_dummy_26"; "d_area_dummy_27"; "d_area_dummy_28"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"]
  end

  if specification == "carshare"
    spec_neither = [spec_neither;["vehicle_avail_hhshare_diff"]]
  elseif specification == "revchain"
    spec_neither = [spec_neither;["reviews_log";"chain"]]
  end

  spec_nospatial = [spec_neither;["eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"]]

  if type_origin_mode == "sixom" || type_origin_mode == "mainspec"
    spec_nosocial = [spec_neither; ["time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"]]
  elseif type_origin_mode == "mintime"
    spec_nosocial = [spec_neither;["time_minimum_log"]]
  elseif type_origin_mode == "fastestmode"
    spec_nosocial = [spec_neither;["time_home_log";"time_work_log";"time_path_log"]]
  end

  spec_neither = map(i->Symbol(i),spec_neither)
  spec_nosocial = map(i->Symbol(i),spec_nosocial)
  spec_nospatial = map(i->Symbol(i),spec_nospatial)
  spec_standard = map(i->Symbol(i),convert(Array{String},data_estimates[:names]))

  if specification == "omintercepts" && bias == "bias"
    spec_standard = setdiff(spec_standard,[:intercept_public_home; :intercept_car_home; :intercept_public_work; :intercept_car_work; :intercept_public_path])
  elseif specification == "omintercepts" && bias == "nobias"
    spec_nosocial = [spec_nosocial;[:intercept_public_home; :intercept_car_home; :intercept_public_work; :intercept_car_work; :intercept_public_path]]
  end

  if nlogit == 1
    spec_standard = setdiff(spec_standard,[:lambda])
  end

  return spec_neither,spec_nosocial,spec_nospatial,spec_standard

end

##########################
# DataFrame manipulation
##########################

#Add missiing dummies d_area_dummy_`i' to the set of covariates and assign them a large negative coefficient such that P_ij = 0
#This procedure is needed for asian users where there are zero visits to areas 8 and 14
function add_missing_dummy_area(df_estimates;venue_FE::Int=0)

  retain_col = [:names;:estimates]

  if venue_FE == 1
    temp = unique(df_estimates[:omitted_dummy])[1]
  end

  df = df_estimates[:,retain_col]

  for i in 2:28
    if length(findin(df[:names],[string("d_area_dummy_",i)])) == 0 #(missing dummy)
      df1 =  DataFrame(names=[string("d_area_dummy_",i)],estimates=[-10000.0])
      df = append!(df,df1)
    end
  end

  if venue_FE == 1
    df[:omitted_dummy]=temp
  end

  return df
end

function add_missing_dummy_cuisine(df_estimates;venue_FE::Int=0)

  retain_col = [:names;:estimates]

  if venue_FE == 1
    temp = unique(df_estimates[:omitted_dummy])[1]
  end

  df = df_estimates[:,retain_col]

  for i in [collect(1:7);9]
    if length(findin(df[:names],[string("d_cuisine_",i)])) == 0 #(missing dummy)
      df1 =  DataFrame(names=[string("d_cuisine_",i)],estimates=[-10000.0])
      df = append!(df,df1)
    end
  end

  if venue_FE == 1
    df[:omitted_dummy]=temp
  end

  return df
end

function add_missing_dummy_price(df_estimates;venue_FE::Int=0)

  retain_col = [:names;:estimates]

  if venue_FE == 1
    temp = unique(df_estimates[:omitted_dummy])[1]
  end

  df = df_estimates[:,retain_col]

  for i in 2:4
    if length(findin(df[:names],[string("d_price_",i)])) == 0 #(missing dummy)
      df1 =  DataFrame(names=[string("d_price_",i)],estimates=[-10000.0])
      df = append!(df,df1)
    end

    if length(findin(df[:names],[string("d_price_",i,"_income")])) == 0
      df1 =  DataFrame(names=[string("d_price_",i,"_income")],estimates=[-10000.0])
      df = append!(df,df1)
    end
  end

  if venue_FE == 1
    df[:omitted_dummy]=temp
  end

  return df
end

function extract_estimates(df,specification)

  specification_strings = map(i->string(i),specification)
  df = df[findin(df[:names],specification_strings),:]

  df_temp = df[df[:names].==specification_strings[1],:]

  for i in 2:length(specification_strings)
    df_temp = append!(df_temp,df[df[:names].==specification_strings[i],:])
  end

  theta = convert(Array{Float64},df_temp[:estimates])

  return theta
end

function diagonalize_time_covariates(data::DataFrame,norg::Int;fastestmode::Int64 = 0)

  names_data = names(data)
  if fastestmode == 1
    ind_temp = find(names(data).== :time_home_log)[1]
  elseif fastestmode == 0
    ind_temp = find(names(data).== :time_public_home_log)[1]
  end

  data = convert(Array{Float64},data)
  data = repeat_inner(data,norg) #repeat each row norg times

  #Diagonalize time-related terms
  data_time=data[:,ind_temp:ind_temp+norg-1]
  for i in 1:norg:size(data_time,1)
    data_time[i:i+norg-1,:]=diagm(data_time[i,:][1:norg])
  end

  data[:,ind_temp:ind_temp+norg-1]=data_time

  data = convert(DataFrame,data)
  rename!(data, Dict(Symbol("x$i")=>names_data[i] for i in 1:length(names_data)))

  return data

end

function diagonalize_time_covariates_originmodeintercept(data::DataFrame,norg::Int)

  names_data = names(data)
  ind_temp = find(names(data).== :time_public_home_log)[1]
  ind_temp2 = find(names(data).== :intercept_public_home)[1]

  data = convert(Array{Float64},data)
  data = repeat_inner(data,norg) #repeat each row norg times

  #Diagonalize time-related terms
  data_time=data[:,ind_temp:ind_temp+norg-1]
  for i in 1:norg:size(data_time,1)
    data_time[i:i+norg-1,:]=diagm(data_time[i,:][1:norg])
  end

  data[:,ind_temp:ind_temp+norg-1]=data_time

  #Diagonalize origin-mode specific intercepts
  data_intercept = data[:,ind_temp2:ind_temp2+norg-1]
  for i in 1:norg:size(data_intercept,1)
    data_intercept[i:i+norg-1,:]=diagm(data_intercept[i,:][1:norg])
  end

  data[:,ind_temp2:ind_temp2+norg-1]=data_intercept

  data = convert(DataFrame,data)
  rename!(data, Dict(Symbol("x$i")=>names_data[i] for i in 1:length(names_data)))

  return data

end

function prepare_data(norg,keep_cols,data_sub,spatial;fastestmode::Int64=0)

  #diagonalize dataset
  if spatial == 1
    temp0 = diagonalize_time_covariates(data_sub,norg;fastestmode=fastestmode)
  elseif spatial == 0
    temp0 = expand_df(data_sub,norg)
  end

  delete!(temp0,keep_cols)

  return convert(Array{Float64},temp0)

end

function prepare_data_originmodeintercept(norg,keep_cols,data_sub)

  temp0 = diagonalize_time_covariates_originmodeintercept(data_sub,norg)
  delete!(temp0,keep_cols)
  delete!(temp0,:intercept_car_path)

  return convert(Array{Float64},temp0)
end

function prepare_data_FE(norg,keep_cols,specification,posvis_venues,omitted_venue,data_sub,spatial;fastestmode::Int64 = 0)

  if spatial == 1
    df_temp = diagonalize_time_covariates(data_sub,norg;fastestmode=fastestmode) #standard case
  elseif spatial == 0
    df_temp = expand_df(data_sub,norg)
  end

  #Add restaurant dummies
  for j in setdiff(posvis_venues,omitted_venue)
    df_temp[Symbol("restaurant_",j)] = (df_temp[:venue_num].==j)
  end

  retain_var = convert(Array{Symbol},specification)

  return convert(Array{Float64},df_temp[:,retain_var])

end

function prepare_data_nlogit(norg,keep_cols,specification,data_sub,spatial;fastestmode::Int64 = 0)

  if spatial == 1
    df_temp = diagonalize_time_covariates(data_sub,norg;fastestmode=fastestmode) #standard case
  elseif spatial == 0
    df_temp = expand_df(data_sub,norg)
  end

  retain_var = convert(Array{Symbol},[keep_cols[1];specification]) #keep_cols[1] = variable nest_id

  return convert(Array{Float64},df_temp[:,retain_var])

end

#Combines the results of specification neither, nosocial, nospatial
function combine_results(list_df,list_spec;proba_home::Int=1)

  N = length(list_df)

  if proba_home == 1
    for i in 1:N
       rename!(list_df[i],[f => t for (f, t) = zip([:prob_visit_venue,:prob_visit_venue_home],[Symbol(string("prob_visit_venue","_",list_spec[i])),Symbol(string("prob_visit_venue_home","_",list_spec[i]))])])
    end

    df_all = list_df[1]

    if N>1
      for i in 2:N
        df_all = join(df_all,list_df[i][:,[:userid_num;:venue_num;Symbol(string("prob_visit_venue","_",list_spec[i]));Symbol(string("prob_visit_venue_home","_",list_spec[i]))]],on=[:userid_num;:venue_num],kind=:left)
      end
    end
 elseif proba_home == 0
   for i in 1:N
      rename!(list_df[i],:prob_visit_venue=>Symbol(string("prob_visit_venue","_",list_spec[i])))
   end

   df_all = list_df[1]

   if N>1
     for i in 2:N
       df_all = join(df_all,list_df[i][:,[:userid_num;:venue_num;Symbol(string("prob_visit_venue","_",list_spec[i]))]],on=[:userid_num;:venue_num],kind=:left)
     end
   end
 end

   sort!(df_all,cols = [order(:userid_num),order(:venue_num)])

  return df_all
end


#Collapse probabilities over workplace
function collapse_over_workplace(df_proba,top_workplaces_5;proba_home::Int=1)

  df_proba =  join(df_proba,top_workplaces_5,on = [:geoid11_home;:geoid11_work])
  delete!(df_proba,[:residentemployees,:geoid11_home_num]) #remove useless columns

  if proba_home == 1
    df_proba=by(df_proba,[:geoid11_home,:geoid11_dest,:venue_num],df->DataFrame(
    prob_visit_venue_neither= sum(df[:prob_visit_venue_neither].*df[:share])./sum(df[:share]),
    prob_visit_venue_nosocial=sum(df[:prob_visit_venue_nosocial].*df[:share])./sum(df[:share]),
    prob_visit_venue_home_nosocial=sum(df[:prob_visit_venue_home_nosocial].*df[:share])./sum(df[:share]),
    prob_visit_venue_nospatial=sum(df[:prob_visit_venue_nospatial].*df[:share])./sum(df[:share]),
    prob_visit_venue_standard=sum(df[:prob_visit_venue_standard].*df[:share])./sum(df[:share]),
    prob_visit_venue_home_standard=sum(df[:prob_visit_venue_home_standard].*df[:share])./sum(df[:share]),
    ))
  elseif proba_home == 0
    df_proba=by(df_proba,[:geoid11_home,:geoid11_dest,:venue_num],df->DataFrame(
    prob_visit_venue_neither= sum(df[:prob_visit_venue_neither].*df[:share])./sum(df[:share]),
    prob_visit_venue_nosocial=sum(df[:prob_visit_venue_nosocial].*df[:share])./sum(df[:share]),
    prob_visit_venue_nospatial=sum(df[:prob_visit_venue_nospatial].*df[:share])./sum(df[:share]),
    prob_visit_venue_standard=sum(df[:prob_visit_venue_standard].*df[:share])./sum(df[:share]),
    ))
  end

  return df_proba
end

###########################
# Add specific covariates
###########################

#the fastest mode specification requires taking the minimum time across transport modes
function create_fastestmode_spatialfriction(df)

  for i in ["home","work","path"]
    df[Symbol(string("time_"i,"_log"))] = min(df[Symbol(string("time_","public_",i,"_log"))],df[Symbol(string("time_","car_",i,"_log"))])
    delete!(df,[Symbol(string("time_","public_",i,"_log")),Symbol(string("time_","car_",i,"_log"))])
  end

  return df
end

#The mintime specification requires taking the minimum time across all mode and origin
function create_mintime_spatialfriction(df)

  df[:time_minimum_log] = min.(df[:time_public_home_log],df[:time_car_home_log],df[:time_public_work_log],df[:time_car_work_log],df[:time_public_path_log],df[:time_car_path_log])

  delete!(df,[:time_public_home_log,:time_car_home_log,:time_public_work_log,:time_car_work_log,:time_public_path_log,:time_car_path_log])

  return df
end

#The mintime specification requires taking the minimum time across all mode and origin
function create_originmodeintercept(df)

  intercept_origin_mode =  [:intercept_public_home;:intercept_car_home;:intercept_public_work;:intercept_car_work;:intercept_public_path;:intercept_car_path]

  for i in 1:length(intercept_origin_mode)
      df[intercept_origin_mode[i]] = 1
  end

  return df
end

###########################
# Compute Predicted visits
###########################

#Computes sum_j sum_j exp(V_ijl)
function denom_choice_probability_mnl_newton(data,theta)
	denom = sum(exp.(data*theta))
  return denom
end

#computes the probability of visits from home
function sum_choice_probability_home(J,norg,P_ijl)
  P_sum_home = reshape(sum(reshape(P_ijl,norg,J)[1:2,:],1),J)

  #renormalize:
  P_sum_home = P_sum_home./sum(P_sum_home)

  return P_sum_home
end

function prob_visit_venue(norg,theta,keep_cols,df;fastestmode::Int64=0,mintime::Int64=0,gentrification::Int64=0)

  #Does the specification have spatial covariates
  names_string = map(i->string(i),names(df))
  if mintime == 0
    count_spatial_covariates = sum([ismatch(Regex("\^time_.+_log\$"),i) for i in names_string])
  elseif mintime == 1
    count_spatial_covariates = 0 #(no need to diagonalize under the mintime specification)
  end

  df_temp = copy(df)

  if count_spatial_covariates > 0
    df_temp = prepare_data(norg,keep_cols,df_temp,1;fastestmode=fastestmode)
  else
    df_temp = prepare_data(norg,keep_cols,df_temp,0)
  end

  P_ijl = choice_probability_mnl_newton(df_temp,theta)
  P_ij = sum_pairs_choice_probability_mnl_newton(div(size(df_temp,1),norg),norg,P_ijl)
  df[:prob_visit_venue] = P_ij

  if mintime == 0
      P_ij_home = sum_choice_probability_home(div(size(df_temp,1),norg),norg,P_ijl)
      df[:prob_visit_venue_home] = P_ij_home
   elseif mintime == 1
     df[:prob_visit_venue_home] = copy(df[:prob_visit_venue])
   end

   if gentrification == 1
     df[:denom_prob_visit_venue] = denom_choice_probability_mnl_newton(df_temp,theta)
     return df[:,[keep_cols;:prob_visit_venue;:denom_prob_visit_venue]]
   else
   return df[:,[keep_cols;:prob_visit_venue;:prob_visit_venue_home]]
  end
end

function prob_visit_venue_originmodeintercept(norg,theta,keep_cols,df)

  #Does the specification have spatial covariates
  names_string = map(i->string(i),names(df))
  df_temp = copy(df)
  df_temp = prepare_data_originmodeintercept(norg,keep_cols,df_temp)

  P_ijl = choice_probability_mnl_newton(df_temp,theta)
  P_ij = sum_pairs_choice_probability_mnl_newton(div(size(df_temp,1),norg),norg,P_ijl)
  df[:prob_visit_venue] = P_ij

  P_ij_home = sum_choice_probability_home(div(size(df_temp,1),norg),norg,P_ijl)
  df[:prob_visit_venue_home] = P_ij_home

   return df[:,[keep_cols;:prob_visit_venue;:prob_visit_venue_home]]
end

function prob_visit_venue_FE(norg,theta,keep_cols,specification,posvis_venues,omitted_venue,df;fastestmode::Int64=0,mintime::Int64=0)

  #Does the specification have spatial covariates
  names_string = map(i->string(i),names(df))
  if mintime == 0
    count_spatial_covariates = sum([ismatch(Regex("\^time_.+_log\$"),i) for i in names_string])
  elseif mintime == 1
    count_spatial_covariates = 0 #(no need to diagonalize under the mintime specification)
  end

  df_temp = copy(df)

  if count_spatial_covariates > 0
    df_temp = prepare_data_FE(norg,keep_cols,specification,posvis_venues,omitted_venue,df_temp,1;fastestmode=fastestmode)
  else
    df_temp = prepare_data_FE(norg,keep_cols,specification,posvis_venues,omitted_venue,df_temp,0)
  end

  P_ijl = choice_probability_mnl_newton(df_temp,theta)
  P_ij = sum_pairs_choice_probability_mnl_newton(div(size(df_temp,1),norg),norg,P_ijl)
  df[:prob_visit_venue] = P_ij

  if mintime == 0
      P_ij_home = sum_choice_probability_home(div(size(df_temp,1),norg),norg,P_ijl)
      df[:prob_visit_venue_home] = P_ij_home
   elseif mintime == 1
     df[:prob_visit_venue_home] = copy(df[:prob_visit_venue])
   end

   return df[:,[keep_cols;:prob_visit_venue;:prob_visit_venue_home]]
end

function prob_visit_venue_nlogit(norg,beta,lambda,keep_cols,spec,df;fastestmode::Int64=0,mintime::Int64=0)

  #Does the specification have spatial covariates
  names_string = map(i->string(i),names(df))
  if mintime == 0
    count_spatial_covariates = sum([ismatch(Regex("\^time_.+_log\$"),i) for i in names_string])
  elseif mintime == 1
    count_spatial_covariates = 0 #(no need to diagonalize under the mintime specification)
  end

  df_temp = copy(df)

  if count_spatial_covariates > 0
    df_temp = prepare_data_nlogit(norg,keep_cols,spec,df_temp,1;fastestmode=fastestmode)
  else
    df_temp = prepare_data_nlogit(norg,keep_cols,spec,df_temp,0)
  end

  P_ij = choice_probability_nlogit_uniquelambda_multiperiod(norg,beta,lambda,df_temp,df_temp)
  df[:prob_visit_venue] = P_ij

   return df[:,[keep_cols;:prob_visit_venue]]
end


function compute_prob_visit_venue(norg,data,data_estimates,spec;fastestmode::Int64=0,mintime::Int64=0,gentrification::Int64=0)

  theta = extract_estimates(data_estimates,spec)
  keep_cols = [:userid_num;:venue_num;:geoid11_home;:geoid11_work;:geoid11_dest]
  data = data[:,[keep_cols;spec]]

  #Transform data in collection
  list_data = groupby(data,[:userid_num])

  #For each user, attach the probability of visiting a venue
  list_data_with_prob= map(i->prob_visit_venue(norg,theta,keep_cols,list_data[i][:,1:end];fastestmode=fastestmode,mintime=mintime,gentrification=gentrification),collect(1:length(list_data)))

  data_with_prob = append_list_df(list_data_with_prob)

  #Put column back to right format
  data_with_prob = convert_float_integer(data_with_prob,map(i->string(i),keep_cols))

  return data_with_prob

end

function compute_prob_visit_venue_originmodeintercept(norg,data,data_estimates,spec,bias;fastestmode::Int64=0,mintime::Int64=0)

  if bias == "bias"
    return compute_prob_visit_venue(norg,data,data_estimates,spec;fastestmode=fastestmode,mintime=mintime)
  elseif bias == "nobias"

    theta = extract_estimates(data_estimates,spec)
    keep_cols = [:userid_num;:venue_num;:geoid11_home;:geoid11_work;:geoid11_dest]
    data = data[:,[keep_cols;spec;:intercept_car_path]] #Note:  :intercept_car_path is a temporary variable, it is dropped in the end

    #Transform data in collection
    list_data = groupby(data,[:userid_num])

    list_data_with_prob= map(i->prob_visit_venue_originmodeintercept(norg,theta,keep_cols,list_data[i][:,1:end]),collect(1:length(list_data)))

    data_with_prob = append_list_df(list_data_with_prob)

    #Put column back to right format
    data_with_prob = convert_float_integer(data_with_prob,map(i->string(i),keep_cols))

    return data_with_prob
  end
end

function compute_prob_visit_venue_FE(norg,data,data_estimates,spec;fastestmode::Int64=0,mintime::Int64=0)

  theta = extract_estimates(data_estimates,spec)
  keep_cols = [:userid_num;:venue_num;:geoid11_home;:geoid11_work;:geoid11_dest]

  index_FE = [contains(string(spec[i]),"restaurant_") for i in 1:length(spec)]
  list_venue_FE = spec[index_FE] #this assumes that all venues in the file are visited at least once (this is true in our data)
  posvis_venues = map(i->parse(split(string(i),"_")[2]),list_venue_FE) #extract dummy number
  specification_covariates = setdiff(spec,list_venue_FE)
  omitted_venue = unique(data_estimates[:omitted_dummy])[1]

  data = data[:,[keep_cols;specification_covariates]]

  ########################################
  # 1) zero-visits restaurants
  ########################################

  data_zerovis = data[findin(data[:venue_num],setdiff(unique(data[:venue_num]),[posvis_venues;omitted_venue])),:]

  #By default, the FE of zero-visits restaurants is -Inf ==> 0 probability of being visited
  data_zerovis[:prob_visit_venue] = 0.0
  data_zerovis[:prob_visit_venue_home] = 0.0
  data_zerovis_withprob = data_zerovis[:,[keep_cols;[:prob_visit_venue,:prob_visit_venue_home]]]

  ###################################
  # 2) positive-visits restaurants
  ###################################

  data_posvis = data[findin(data[:venue_num],[posvis_venues;omitted_venue]),:]

  #Transform data in collection
  list_data_posvis = groupby(data_posvis,[:userid_num])

  #For each user, attach the probability of visiting a venue
  list_data_with_prob = map(i->prob_visit_venue_FE(norg,theta,keep_cols,spec,posvis_venues,omitted_venue,list_data_posvis[i][:,1:end];fastestmode=fastestmode,mintime=mintime),collect(1:length(list_data_posvis)))
  data_posvis_withprob = append_list_df(list_data_with_prob)

  ########################################################
  # 3) append zero-visits and positive visits restaurants
  #########################################################

  data_pool_with_prob = [data_posvis_withprob;data_zerovis_withprob]
  data_pool_with_prob = sort!(data_pool_with_prob,cols=[order(:userid_num),order(:venue_num)])

  return data_pool_with_prob

end

function compute_prob_visit_venue_nlogit(norg,data,data_estimates,spec,nest_id;fastestmode::Int64=0,mintime::Int64=0)

  theta = extract_estimates(data_estimates,[spec;:lambda])
  beta = theta[1:end-1]
  lambda = theta[end]

  keep_cols = [Symbol(string("nest",nest_id));:userid_num;:venue_num;:geoid11_home;:geoid11_work;:geoid11_dest]

  data = data[:,[keep_cols;spec]]

  #Transform data in collection
  list_data = groupby(data,[:userid_num])

  #For each user, attach the probability of visiting a venue
  list_data_with_prob= map(i->prob_visit_venue_nlogit(norg,beta,lambda,keep_cols,spec,list_data[i][:,1:end];fastestmode=fastestmode,mintime=mintime),collect(1:length(list_data)))

  data_with_prob = append_list_df(list_data_with_prob)

  #Put column back to right format
  data_with_prob = convert_float_integer(data_with_prob,map(i->string(i),keep_cols))

  return data_with_prob

end
