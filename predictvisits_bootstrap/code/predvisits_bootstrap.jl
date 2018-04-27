## Author: Kevin Dano
## Date: February 2018
## Purpose: Computes predicted visits collapsed over workplace for bootstrap estimates
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Arguments
race_tmp = ARGS[1]
originmode_tmp = ARGS[2]
num_tmp  = ARGS[3]

for i in procs()
  @spawnat i global const race = race_tmp
  @spawnat i global const originmode = originmode_tmp
  @spawnat i global const number = num_tmp
end

if originmode == "mainspec"
  @everywhere norg = 6
  @everywhere mintime = 0
elseif  originmode == "mintime"
  @everywhere norg = 1
  @everywhere mintime = 1
end

#Path
@everywhere path_input = string("../input/JLDs/")
@everywhere path_predvisitarrays = string("../input/predictedvisitsarray/")
@everywhere path_estimates = string("../input/estimates/",originmode,"/")
@everywhere path_output = string("../output/predictedvisits/",originmode,"/")

#Packages
@everywhere using DataFrames
@everywhere using CSV
@everywhere using JLD
@everywhere using StatsFuns
@everywhere using Optim
@everywhere using Calculus

#Imported functions
@everywhere include("compute_predvisits_racespecific_functions.jl")

##############################
# Primitive data
##############################

@everywhere data = load(string(path_input,"top_workplaces_5.jld"))["data"]

#List of predicted visits array for these users
@everywhere list_files = readdir(string(path_predvisitarrays))

###########################
# Calls
###########################

################################################################################################################################################################################
# mintime specification
#################################################################################################################################################################################
@everywhere data_estimates = readtable(string(path_estimates,"estimates_",race,"_",originmode,"_bootstrap_clean.csv"))
@everywhere data_estimates = remove_missing_type(data_estimates)

@everywhere data_estimates = data_estimates[data_estimates[:instance].==parse(Int,number),:]

@everywhere data_estimates = add_missing_dummy_area(data_estimates)
@everywhere data_estimates = add_missing_dummy_cuisine(data_estimates)
@everywhere data_estimates = add_missing_dummy_price(data_estimates)

@everywhere spec_neither,spec_nosocial,spec_nospatial,spec_standard = prepare_spec_variations(norg,originmode,"",data_estimates)

@everywhere list_spec = ["neither";"nosocial";"nospatial";"standard"]

##############################
# Predicted visits
##############################

@time list_predvisits = pmap(file->begin

  println(string("predivisit for ",file))
  df = load(string(path_predvisitarrays,file))["predvisitarray"]

  if originmode == "mintime"
    df = create_mintime_spatialfriction(df)
  end

  df_spec_neither = compute_prob_visit_venue(norg,df,data_estimates,spec_neither;mintime=mintime)
  df_spec_nosocial = compute_prob_visit_venue(norg,df,data_estimates,spec_nosocial;mintime=mintime)
  df_spec_nospatial = compute_prob_visit_venue(norg,df,data_estimates,spec_nospatial;mintime=mintime)
  df_spec_standard = compute_prob_visit_venue(norg,df,data_estimates,spec_standard;mintime=mintime)

  list_df_all_spec = push!([],df_spec_neither,df_spec_nosocial,df_spec_nospatial,df_spec_standard)
  df_all_spec = combine_results(list_df_all_spec,list_spec)
  df_all_spec = remove_missing_type(df_all_spec)

  return df_all_spec
end, list_files)

@time list_predvisits_collapsed_over_workplace = pmap(df->collapse_over_workplace(df,data),list_predvisits)
@time predvisits_collapsed_over_workplace = append_list_df(list_predvisits_collapsed_over_workplace)

@time save(string(path_output,"predictedvisits_collapsed_over_workplace_",race,"_",originmode,"_instance",number,".jld"),"predvisit",predvisits_collapsed_over_workplace,compress=true)
