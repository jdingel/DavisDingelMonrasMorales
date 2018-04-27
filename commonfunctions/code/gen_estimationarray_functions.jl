## Author: Kevin Dano
## Date: April 2018
## Purpose: Converts stata estimation array in a JLD object understandable by the estimation code
## Packages required: DataFrames, FileIO, StatFiles, JLD
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Imported functions
include("general_functions.jl")

#####################
# Functions
#####################

#####################
# General programs
#####################

#Check rank of estimation array
function check_full_rank(df)

    temp = convert(Array{Float64},df)
    dim = size(df)
    rk = rank(temp)

    if rk == minimum(dim)
      return "full rank"
    else
      return  "rank deficient"
    end
end

#Repeat each row n times (faster than Julia's function repeat)
function repeat_inner(A::Array{Float64,2},n::Int)
  (J,I) = size(A)
  Jn = J*n
  B = zeros(Jn,I)
  for j in 1:Jn
    B[j,:]= A[div((j-1),n)+1,:]
  end
  return B
end

#Impose order on spatial covariates
function sort_spatialcovariates(norg,specification;mintravel_time::Int64 = 0,fastestmode::Int64 = 0,interacted_timecovariates::Int64 = 0)

  spec = map(x->string(x),specification)

  if mintravel_time == 1
    spe_spatial_original = ["time_minimum_log"]
  elseif fastestmode == 1
    spe_spatial_original = ["time_home_log";"time_work_log";"time_path_log"]
  else
    spe_spatial_original = ["time_public_home_log"; "time_car_home_log"; "time_public_work_log";"time_car_work_log";"time_public_path_log";"time_car_path_log"][1:norg]
  end

  if interacted_timecovariates == 0
    nospatial_cov = specification[[!startswith(x,"time_") for x in map(i->string(i),specification)]]
    spe_spatial_original = map(x->Symbol(x),spe_spatial_original)
    spec_full = [spe_spatial_original;nospatial_cov]
    return spec_full
  elseif interacted_timecovariates == 1

    ind_spatial = [contains(i,"time") for i in spec]
    spe_spatial_additional = setdiff(spec[ind_spatial],spe_spatial_original) #

    n = length(spe_spatial_original)
    temp = similar(spe_spatial_additional)

    if length(temp)>0
      for i in  1:n
        temp[i] = spe_spatial_additional[find([ismatch(Regex(spe_spatial_original[i]),j) for j in spe_spatial_additional])][1]
      end
    end

    spatial_cov = [spe_spatial_original;temp]
    nospatial_cov = setdiff(spec,spatial_cov)

    spec_full = map(x->Symbol(x),[spatial_cov;nospatial_cov])
    return spec_full
  end
end

#Diagonalize time covariates
function diagonalize_time_covariates(data::DataFrame,norg::Int;fastestmode::Int64 = 0)

  names_data = names(data)
  if fastestmode == 1
    ind_temp = find(names(data).== :time_home_log)[1] #standar case
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

function diagonalize_time_covariates_interacted(data::DataFrame,norg::Int;fastestmode::Int=0)

  names_data = names(data)

  if fastestmode == 1
    ind_temp = find([contains(i,"time_home_log") for i in map(x->string(x),names(data))])
  elseif fastestmode == 0
    ind_temp = find([contains(i,"time_public_home_log") for i in map(x->string(x),names(data))])
  end

  data = convert(Array{Float64},data)
  data = repeat_inner(data,norg) #repeat each row norg times

  for ind in ind_temp
    #Diagonalize time-related terms
    data_time=data[:,ind:ind+norg-1]
    for i in 1:norg:size(data_time,1)
      data_time[i:i+norg-1,:]=diagm(data_time[i,:][1:norg])
    end
    data[:,ind:ind+norg-1]=data_time
  end

  data = convert(DataFrame,data)
  rename!(data, Dict(Symbol("x$i")=>names_data[i] for i in 1:length(names_data)))

  return data

end

function prepare_data_user_trip(norg,data_sub,specification;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  choice_it = convert(Array{Bool},data_sub[:,:chosen])

  if mintravel_time == 0
    df_temp = diagonalize_time_covariates(data_sub,norg;fastestmode=fastestmode) #standard case
  else
    df_temp = data_sub
  end

  return choice_it,convert(Array{Float64},df_temp[:,specification])

end

function prepare_data_user_trip_originmodeintercept(norg,data_sub,specification,intercept_origin_mode)

  choice_it = convert(Array{Bool},data_sub[:,:chosen])

  for i in 1:length(intercept_origin_mode)
      data_sub[intercept_origin_mode[i]] = 1
  end

  df_temp = diagonalize_time_covariates_originmodeintercept(data_sub,norg)

  #drop one dummy
  df_temp = delete!(df_temp,:intercept_car_path)

  return choice_it,convert(Array{Float64},df_temp[:,[specification;intercept_origin_mode[1:norg-1]]])

end

function prepare_data_user_trip_interactedtimecovariates(norg,data_sub,specification;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  choice_it = convert(Array{Bool},data_sub[:,:chosen])

  if mintravel_time == 0
    df_temp = diagonalize_time_covariates_interacted(data_sub,norg;fastestmode=fastestmode) #standard case
  else
    df_temp = data_sub
  end
  return choice_it,convert(Array{Float64},df_temp[:,specification])
end

function prepare_data_user_trip_FE(norg,data_sub,specification,list_venues,omitted_restaurant;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  choice_it = convert(Array{Bool},data_sub[:,:chosen])

  if mintravel_time == 0
    df_temp = diagonalize_time_covariates(data_sub,norg;fastestmode=fastestmode) #standard case
  else
    df_temp = data_sub
  end

  #Add restaurant dummies
  list_venue_FE = []
  for j in setdiff(list_venues,omitted_restaurant)
    df_temp[Symbol("restaurant_",j)] = (df_temp[:venue_num].==j)
    list_venue_FE = [list_venue_FE;Symbol("restaurant_",j)]
  end

  retain_var = convert(Array{Symbol},[specification;list_venue_FE])

  return choice_it,convert(Array{Float64},df_temp[:,retain_var])

end

function prepare_data_incval_user_trip(norg,nest_id,data_incval_sub,specification;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  #diagonalize dataset
  if mintravel_time == 0
    df_temp = diagonalize_time_covariates(data_incval_sub,norg;fastestmode=fastestmode) #standard case
  else
    df_temp = data_incval_sub
  end

  specification = [nest_id;specification] #includes nest_id

  return convert(Array{Float64},df_temp[:,specification])
end

function prepare_data_nests_user_trip(norg,nest_id,data_nests_sub,specification;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  choice_it = convert(Array{Int},data_nests_sub[:,[nest_id,:chosen]])

  #diagonalize dataset
  if mintravel_time == 0
    df_temp = diagonalize_time_covariates(data_nests_sub,norg;fastestmode=fastestmode) #standard case
  else
    df_temp = data_nests_sub
  end

  specification = [nest_id;specification] #includes nest_id

  return choice_it,convert(Array{Float64},df_temp[:,specification])

end

##########################################
# Estimation array for multinomial logit
##########################################

#Note: The code assumes that the input is a dta file
function gen_estimationarray_mnl(norg,path_input,name_input,path_output,name_output;mintravel_time::Int64 = 0,fastestmode::Int64 = 0,interacted_timecovariates::Int64 = 0)

  #Load the data
  data = read_stata(string(path_input,name_input))

  #Order columns
  names_data = names(data)

  #Columns of interest
  cols_id = [:userid_num; :tripnumber;:venue_num; :chosen]
  discard_cols = [:user_weight,:geoid11_home,:geoid11_work,:geoid11_dest,:female,:asian,:black,:whithisp,:gender_nd,:race_nd]
  specification = setdiff(names_data,[cols_id;discard_cols])
  specification = sort_spatialcovariates(norg,specification;mintravel_time=mintravel_time,fastestmode=fastestmode,interacted_timecovariates=interacted_timecovariates)

  keep_cols = [cols_id;specification]
  data = data[:,keep_cols]

  rank_estarray = check_full_rank(data)

  #Split the data by user and tripnumber
  data_split = groupby(data,[:tripnumber,:userid_num])
  num_trips = length(data_split) #total number of trips

  #transforms the data in a collection
  list_data = Array[]; list_choices = Array[]

  if interacted_timecovariates == 0
    for n in 1:length(data_split)
        choice_tf,data_tf = prepare_data_user_trip(norg,data_split[n][:,1:end],specification;mintravel_time=mintravel_time,fastestmode=fastestmode)
       push!(list_data,data_tf) ; push!(list_choices,choice_tf)
    end
  elseif interacted_timecovariates == 1
    for n in 1:length(data_split)
      choice_tf,data_tf = prepare_data_user_trip_interactedtimecovariates(norg,data_split[n][:,1:end],specification;mintravel_time=mintravel_time,fastestmode=fastestmode)
      push!(list_data,data_tf) ; push!(list_choices,choice_tf)
    end
  end

  #save to JLD format
  save(string(path_output,name_output),"list_choices",list_choices,"list_data",list_data,"names_covariates",specification,"num_trips",num_trips,"rank_estarray",rank_estarray,compress=true)

end

function gen_estimationarray_mnl_originmodeintercept(norg,path_input,name_input,path_output,name_output)

#Load the data
data = read_stata(string(path_input,name_input))

#Order columns
names_data = names(data)

#Columns of interest
cols_id = [:userid_num; :tripnumber;:venue_num; :chosen]
discard_cols = [:user_weight,:geoid11_home,:geoid11_work,:geoid11_dest,:female,:asian,:black,:whithisp,:gender_nd,:race_nd]
specification = setdiff(names_data,[cols_id;discard_cols])

if norg == 2
  specification = specification[setdiff(collect(1:length(specification)),findin(specification,[:time_public_work_log;:time_car_work_log;:time_public_path_log;:time_car_path_log]))]
elseif norg == 4
  specification = specification[setdiff(collect(1:length(specification)),findin(specification,[:time_public_path_log;:time_car_path_log]))]
end

keep_cols = [cols_id;specification]
data = data[:,keep_cols]

rank_estarray = check_full_rank(data)

#Split the data by user and tripnumber
data_split = groupby(data,[:tripnumber,:userid_num])
num_trips = length(data_split) #total number of trips

#transforms the data in a collection
list_data = Array[]; list_choices = Array[]

intercept_origin_mode = [:intercept_public_home;:intercept_car_home; :intercept_public_work; :intercept_car_work; :intercept_public_path; :intercept_car_path]

for n in 1:length(data_split)
    choice_tf,data_tf = prepare_data_user_trip_originmodeintercept(norg,data_split[n][:,1:end],specification,intercept_origin_mode)
    push!(list_data,data_tf) ; push!(list_choices,choice_tf)
end

specification = [specification;intercept_origin_mode[1:norg-1]]

#save to JLD format
save(string(path_output,name_output),"list_choices",list_choices,"list_data",list_data,"names_covariates",specification,"num_trips",num_trips,"rank_estarray",rank_estarray,compress=true)

end

#For fixed effect specification
function gen_estimationarray_mnl_FE(norg,path_input,name_input,path_output,name_output;mintravel_time::Int64 = 0,fastestmode::Int64 = 0)

  #Load the data
  data = read_stata(string(path_input,name_input))

  #Order columns
  names_data = names(data)

  #Columns of interest
  cols_id = [:userid_num; :tripnumber;:venue_num; :chosen]
  discard_cols = [:user_weight,:geoid11_home,:geoid11_work,:geoid11_dest,:female,:asian,:black,:whithisp,:gender_nd,:race_nd]
  specification = setdiff(names_data,[cols_id;discard_cols])
  specification = sort_spatialcovariates(norg,specification;mintravel_time=mintravel_time,fastestmode=fastestmode)

  #venue FE
  list_venues = convert(Array{Int},unique(data[:venue_num]))
  omitted_restaurant = minimum(list_venues)

  keep_cols = [cols_id;specification]
  data = data[:,keep_cols]

  rank_estarray = check_full_rank(data)

  #Split the data by user and tripnumber
  data_split = groupby(data,[:tripnumber,:userid_num])
  num_trips = length(data_split) #total number of trips

  #transforms the data in a collection
  list_data = Array[]; list_choices = Array[]

  for n in 1:length(data_split)
      choice_tf,data_tf = prepare_data_user_trip_FE(norg,data_split[n][:,1:end],specification,list_venues,omitted_restaurant;mintravel_time=mintravel_time,fastestmode=fastestmode)
     push!(list_data,data_tf) ; push!(list_choices,choice_tf)
  end

  #add list of restaurant FE to specification
  specification = [specification;[Symbol("restaurant_",j) for j in setdiff(list_venues,omitted_restaurant)]]

  #save to JLD format
  save(string(path_output,name_output),"list_choices",list_choices,"list_data",list_data,"names_covariates",specification,"num_trips",num_trips,"omitted_dummy",omitted_restaurant,"rank_estarray",rank_estarray,compress=true)

end

function gen_estimationarray_nlogit(norg,nest_scheme,path_input,name_input_nests,name_input_incval,path_output,name_output;mintravel_time::Int64 = 0,fastestmode::Int64 = 0,interacted_timecovariates::Int64 = 0)

#Load the data
data_nests = read_stata(string(path_input,name_input_nests))
data_incval = read_stata(string(path_input,name_input_incval))

#Order columns
names_data_nests = names(data_nests)

nest_id = Symbol(string("nest",nest_scheme))

#Columns of interest
cols_id = [:userid_num; :tripnumber;:venue_num; :chosen;nest_id]
discard_cols = [:user_weight,:geoid11_home,:geoid11_work,:geoid11_dest,:female,:asian,:black,:whithisp,:gender_nd,:race_nd]
specification = setdiff(names_data_nests,[cols_id;discard_cols])

delete!(data_nests,discard_cols)
delete!(data_incval,discard_cols)

rank_estarray = check_full_rank(data_nests)

collection_data_nests = groupby(data_nests,[:userid_num])
collection_data_incval = groupby(data_incval,[:userid_num])
num_trips = nrow(unique(data_nests[:,[:userid_num;:tripnumber]]))
I = length(collection_data_nests)

list_data_nests = Array[] ; list_choices = Array[]; list_data_incval = Array[]

for i in 1:I

  data_nests_sub = groupby(collection_data_nests[i][:,1:end],[:tripnumber])
  T = length(data_nests_sub)
  list_data_nests_i = Array[]; list_choices_i = Array[]

  #data by trips
  for t in 1:T
    choices_it, data_it = prepare_data_nests_user_trip(norg,nest_id,data_nests_sub[t][:,1:end],specification;mintravel_time=mintravel_time,fastestmode=fastestmode)
    push!(list_data_nests_i,data_it)
    push!(list_choices_i,choices_it)
  end

  push!(list_data_nests,list_data_nests_i)
  push!(list_choices,list_choices_i)

  data_incval_i = prepare_data_incval_user_trip(norg,nest_id,collection_data_incval[i][:,1:end],specification;mintravel_time = mintravel_time,fastestmode = fastestmode)

  push!(list_data_incval,data_incval_i)

end

#save to JLD format
save(string(path_output,name_output),"list_choices",list_choices,"list_data_nests",list_data_nests,"list_data_incval",list_data_incval,"names_covariates",specification,"num_trips",num_trips,"rank_estarray",rank_estarray,compress=true)

end
