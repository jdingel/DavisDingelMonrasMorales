## Author: Kevin Dano
## Date: April 2018
## Purpose: Simulation of permanent ij shocks
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using Distributions
using DataFrames

###########################################
# Functions
###########################################

#Computes the distance between two points described by latitude and longitude using the Haversine formula
function distance(lat1::Float64, lon1::Float64, lat2::Float64, lon2::Float64)
    p=pi/180
    a=0.5 - cos((lat2 - lat1) * p)/2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2
    return 12742 * asin(sqrt(a)) #2*R, R=6371km
end

#Much faster than Julia's function repeat
function repeat_inner(A,n::Int)
  (J,I) = size(A)
  Jn = J*n
  B = zeros(Jn,I)
  for j in 1:Jn
    B[j,:]= A[div((j-1),n)+1,:]
  end
  return B
end

#Diagonalize time covariates
function repeat_data_inner(df,norg::Int)

  list_cols = names(df)
  ind_temp = find(names(df).== :time_home_venue_public)[1]
  data = repeat_inner(convert(Array{Float64},df),norg) #repeat each row norg times

  #Diagonalize time-related terms
  data_time=data[:,ind_temp:ind_temp+norg-1]

  for i in 1:norg:size(data_time,1)
    data_time[i:i+norg-1,:]=diagm(data_time[i,:][1:norg])
  end

  data[:,ind_temp:ind_temp+norg-1]=data_time
  data=convert(DataFrame,data)
  rename!(data, Dict(Symbol("x$i")=>list_cols[i] for i in 1:length(list_cols)))
  return data
end

#Keeps requested percentage of observations
function keep_obs(list_df,keep_percent)

  N = length(list_df)
  N0 = convert(Int64,floor(keep_percent*N))

  list_df_short = Array[list_df[k] for k in 1:N0]
  return list_df_short
end

#Creates venues' coordinates & ratings
function generate_data_venue(J)
  data_venue = DataFrame(venue_num=collect(1:J),venue_latitude=40.75+randn(J),venue_longitude=-74.25+randn(J),rating = 1 + 4*rand(J))
  return data_venue
end

#First step: calculate various distances between user and venues & generate a permanent shock (ij specific)
function generate_data_user_venue(norg,num_user,data_venue,disutility_distance;magnitude_error=1.0)

  #sorting: home-car, work-car, home-public, work-public, commute-car, commute-public
  origin_transport=["home_venue_public","home_venue_car","work_venue_public","work_venue_car","commute_venue_public","commute_venue_car"]
  origin_transport = origin_transport[1:norg] #impose the number of origin-mode for the simulation

  #1)Generate user data: coordinates
  data_user = DataFrame(user_num=num_user,user_home_latitude=40.75+randn(1),user_home_longitude=-74.25+randn(1),user_work_latitude=40.75+randn(1),user_work_longitude=-74.25+randn(1))
  data_user[:logdistance_home_work] = log(distance(data_user[:user_home_latitude][1],data_user[:user_home_longitude][1],data_user[:user_work_latitude][1],data_user[:user_work_longitude][1]))

  data_user[:time_home_work_car] = data_user[:logdistance_home_work]
  data_user[:time_home_work_public] = data_user[:time_home_work_car] + randn(nrow(data_user)) #prevents perfect colinearity

  #2)Merge user and venue data
  df = join(data_user,data_venue,kind= :cross)
  df = sort!(df,cols=[order(:user_num),order(:venue_num)])

  #Calculate relevant distances
  df[:logdistance_home_venue]=zeros(nrow(df))
  df[:logdistance_work_venue]=zeros(nrow(df))

  for i in 1:nrow(df)
    df[:logdistance_home_venue][i] = log(distance(df[:user_home_latitude][i],df[:user_home_longitude][i],df[:venue_latitude][i],df[:venue_longitude][i]))
    df[:logdistance_work_venue][i] = log(distance(df[:user_work_latitude][i],df[:user_work_longitude][i],df[:venue_latitude][i],df[:venue_longitude][i]))
  end

  #We assume a simple linear relationship between distance and time
  for j in origin_transport
    if j == "home_venue_public"
      df[Symbol("time_"*j)] = df[:logdistance_home_venue]
    elseif j == "home_venue_car"
      df[Symbol("time_"*j)] = df[:logdistance_home_venue] + randn(nrow(df)) #prevents perfect colinearity
    elseif j =="work_venue_public"
      df[Symbol("time_"*j)]  = df[:logdistance_work_venue]
    elseif j =="work_venue_car"
      df[Symbol("time_"*j)]  = df[:logdistance_work_venue] + randn(nrow(df)) #prevents perfect colinearity
    elseif j == "commute_venue_public"
      df[Symbol("time_"*j)] = 0.5*(df[:time_home_venue_public] + df[:time_work_venue_public] - df[:time_home_work_public])
      df[Symbol("time_"*j)] = df[Symbol("time_"*j)].*(df[Symbol("time_"*j)].>0)
    elseif j == "commute_venue_car"
      df[Symbol("time_"*j)] =  0.5*(df[:time_home_venue_car] + df[:time_work_venue_car] - df[:time_home_work_car])
      df[Symbol("time_"*j)] = df[Symbol("time_"*j)].*(df[Symbol("time_"*j)].>0)
    end
  end

  #Retain relevant columns
  keep_col0 = [:user_num;:venue_num;:rating;[Symbol("time_"*i) for i in origin_transport]]
  df = df[:,keep_col0]

  #diagonalize time covariates
  df_augmented = repeat_data_inner(df,norg)
  df_augmented = convert(Array{Float64},df_augmented)

  #disutility due to origin-transport mode
  df_disutility_distance = sum(df_augmented[:,end-norg+1:end].*disutility_distance',2)

  #Add column of disutilities to data
  df_augmented = hcat(df_augmented,df_disutility_distance)

  df_augmented = convert(DataFrame,df_augmented)
  rename!(df_augmented, Dict(Symbol("x$i")=>keep_col0[i] for i in 1:length(keep_col0)))
  rename!(df_augmented,Dict(Symbol("x$i")=>Symbol("disutility_distance") for i=(length(keep_col0)+1)))

  #Generate permanent shock: ij specific ; the parameter magnitude_error controls the variance
  df_augmented[:permanent_error] =  magnitude_error*(-log(-log(rand(nrow(df_augmented)))))

  return df_augmented
end

#Second step: user makes choices after adding a transitory shock
function gen_data_user_venue_trip(norg,data,num_trip,coeff_rating)

  data[:tripnumber] = num_trip

  origin_transport = ["home_venue_public","home_venue_car","work_venue_public","work_venue_car","commute_venue_public","commute_venue_car"]
  origin_transport = origin_transport[1:norg] #impose the number of origin-mode for the simulation

  #Generate choices
  data[:transitory_error] = -log(-log(rand(nrow(data)))) #transitory shock (trip specific)
  data[:utility] = data[:disutility_distance] + coeff_rating.*data[:rating] + data[:permanent_error] + data[:transitory_error]

  #Identify users' choices
  data[:chosen] = fill(false,nrow(data))
  utilitymax = by(data,[:user_num,:tripnumber],df->maximum(df[:utility]))
  data[:chosen][find(x->x in utilitymax[:,end],data[:utility])]=true

  choices=by(data,[:tripnumber,:user_num,:venue_num,],df->DataFrame(chosen = sum(df[:chosen])))[end-1:end]

  keep_col = [:venue_num;:rating;[Symbol("time_"*i) for i in origin_transport]]
  data = data[:,keep_col]

  return choices[:,[:venue_num;:chosen]],data
end

function DGP_norg_permanentshocks(norg,T,data_venue,num_user,disutility_distance,coeff_rating;magnitude_error = 1.0)

  #1) Generate user venue data
  data_user_venue = generate_data_user_venue(norg,num_user,data_venue,disutility_distance;magnitude_error=magnitude_error)

  list_choices = Array[]; list_data = Array[];
  list_chosen_venues = Float64[]

  #2) T = 1
  choices_currentperiod,data_currentperiod = gen_data_user_venue_trip(norg,data_user_venue,1,coeff_rating)

  chosen_venue = choices_currentperiod[choices_currentperiod[:chosen].==1,:venue_num][1]
  list_chosen_venues = push!(list_chosen_venues,chosen_venue)

  push!(list_choices,choices_currentperiod[:,:chosen])
  push!(list_data,data_currentperiod[:,setdiff(names(data_currentperiod),[:venue_num])])

  count_periods = 1

  #3) T > 1
  while count_periods < T

    choices_currentperiod,data_currentperiod = gen_data_user_venue_trip(norg,data_user_venue,1+count_periods,coeff_rating)
    chosen_venue = choices_currentperiod[choices_currentperiod[:chosen].==1,:venue_num][1]

    if length(findin(list_chosen_venues,chosen_venue))==0 #e.g if chosen venue in period t+1 is not present in the list of venues that were previously reviewed

      #i) Drop all previously reviewed restaurants from estimation array
      keep_venues = setdiff(choices_currentperiod[:venue_num],list_chosen_venues)
      choices_currentperiod = choices_currentperiod[findin(choices_currentperiod[:venue_num],keep_venues),:]
      data_currentperiod = data_currentperiod[findin(data_currentperiod[:venue_num],keep_venues),:]

      #ii) Add newly chosen restaurant to the set of reviewed restaurants
      list_chosen_venues = push!(list_chosen_venues,chosen_venue)

      push!(list_choices,choices_currentperiod[:,:chosen])
      push!(list_data,data_currentperiod[:,setdiff(names(data_currentperiod),[:venue_num])])

    end
    count_periods += 1
  end

  return list_choices, list_data

end

function convert_df_to_tex(list_data,names_covariates,insert_colnames,path,saveas)

    #size of one dataframe
    (n1,n2) = size(list_data[1])
    n3 = length(list_data)

    colnames = string("Sample share")
    sim_num = string("")

    for i in 1:n3
      colnames = string(colnames,"&",insert_colnames[i])
      sim_num = sim_num = string(sim_num,"&","($i)")
    end

    colnames = string(colnames," \\\\")
    sim_num = string(sim_num," \\\\")
    temp_tex = string("\\begin{tabular}{l","c"^(n3),"} \\toprule \n",sim_num,"\n",colnames," \\midrule \n")

    for i in 1:n1
      temp_covariates = ""
      std_covariates = ""

      for k in 1:n3
        temp_covariates = string(temp_covariates,"&",@sprintf("%9.2f",list_data[k][:estimates][i]))
        std_covariates = string(std_covariates,"& \\footnotesize{("@sprintf("%.3f",list_data[k][:std][i])")}")
      end

        temp_covariates = string(names_covariates[i],temp_covariates)
        temp_covariates = string(temp_covariates," \\\\ ")
        std_covariates = string(std_covariates," \\\\ ")
        temp_tex = string(temp_tex,"\n",temp_covariates,"\n",std_covariates)
    end

    temp_tex = string(temp_tex,"\n \\midrule")
    temp_num_trips = "Reviews"
    temp_num_venues = "Restaurants"

    for k in 1:n3
        temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
        temp_num_venues = string(temp_num_venues,"&",list_data[k][:num_venues][1])
    end

    temp_num_trips = string(temp_num_trips," \\\\ ")
    temp_num_venues = string(temp_num_venues," \\\\ ")

    temp_tex = string(temp_tex,"\n",temp_num_venues,"\n",temp_num_trips)

    latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

    write(string(path,saveas),latex_table)

end

function convert_df_to_tex_multicol(list_data,names_covariates,insert_colnames,insert_sample_share,path,saveas)

    #size of one dataframe
    (n1,n2) = size(list_data[1])
    n3 = length(list_data)

    colnames = string("")
    sim_num = string("")

    for i in 1:div(n3,3)
      colnames = string(colnames,"& \\multicolumn{3}{c}{",insert_colnames[i],"}")
    end

    for i in 1:n3
      sim_num = sim_num = string(sim_num,"&","($i)")
    end

    colnames = string(colnames," \\\\")
    colnames  = string(colnames,"\\cmidrule(lr){2-4} \\cmidrule(lr){5-7} \\cmidrule(lr){8-10}")
    sim_num = string(sim_num," \\\\")
    temp_tex = string("\\begin{tabular}{l","c"^(n3),"} \\toprule \n",colnames,"\n",sim_num," \\midrule \n")

    for i in 1:n1
      temp_covariates = ""
      std_covariates = ""

      for k in 1:n3
        temp_covariates = string(temp_covariates,"&",@sprintf("%9.2f",list_data[k][:estimates][i]))
        std_covariates = string(std_covariates,"& \\footnotesize{("@sprintf("%.3f",list_data[k][:std][i])")}")
      end

        temp_covariates = string(names_covariates[i],temp_covariates)
        temp_covariates = string(temp_covariates," \\\\ ")
        std_covariates = string(std_covariates," \\\\ ")
        temp_tex = string(temp_tex,"\n",temp_covariates,"\n",std_covariates)
    end

    temp_tex = string(temp_tex,"\n \\\\")
    temp_num_trips = "Reviews"
    temp_sample_share = "Sample share"

    for k in 1:n3
        temp_num_trips = string(temp_num_trips,"&",list_data[k][:num_trips][1])
        temp_sample_share = string(temp_sample_share,"&",insert_sample_share[k])
    end

    temp_num_trips = string(temp_num_trips," \\\\ ")
    temp_sample_share = string(temp_sample_share," \\\\ ")

    temp_tex = string(temp_tex,"\n",temp_sample_share,"\n",temp_num_trips)

    latex_table = string(temp_tex,"\n \\bottomrule","\n","\\end{tabular}")

    write(string(path,saveas),latex_table)

end
