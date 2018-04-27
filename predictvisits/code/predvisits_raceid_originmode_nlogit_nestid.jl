## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Packages
@everywhere using DataFrames
@everywhere using CSV
@everywhere using JLD
@everywhere using StatsFuns

#Arguments
race_tmp = ARGS[1]
originmode_temp = ARGS[2]
nestid_tmp = ARGS[3]

for i in procs()
  @spawnat i global const race = race_tmp
  @spawnat i global const originmode = originmode_temp
  @spawnat i global const nestid = nestid_tmp
end

@everywhere specification="nlogit"

if originmode == "sixom"
  @everywhere norg = 6
  @everywhere mintime = 0
  @everywhere fastestmode = 0
elseif  originmode == "mintime"
  @everywhere norg = 1
  @everywhere mintime = 1
  @everywhere fastestmode= 0
elseif  originmode == "fastestmode"
  @everywhere norg = 3
  @everywhere mintime = 0
  @everywhere fastestmode= 1
end

#Path
@everywhere path_input = "../input/JLDs/"
@everywhere path_predvisitsarray = "../input/predictedvisitsarray/"
@everywhere path_estimates = string("../input/estimates/",originmode,"/")
@everywhere path_output = string("../output/predictedvisits/",originmode,"/")

#Imported functions
@everywhere include("compute_predvisits_racespecific_functions.jl")

##############################
# Primitive data
##############################

@everywhere data = load(string(path_input,"top_workplaces_5.jld"))["data"]

#List of predicted visits array in the directory path_predvisitsarray
@everywhere list_files = readdir(string(path_predvisitsarray))

###########################
# Calls
###########################

################################################################################################################################################################################
# Prepare input
#################################################################################################################################################################################

@everywhere data_estimates = CSV.read(string(path_estimates,"estimates_",race,"_",specification,"_","nested",nestid,".csv"),allowmissing=:none,weakrefstrings=false)

#Add potential missing dummies
@everywhere data_estimates = add_missing_dummy_area(data_estimates)
@everywhere data_estimates = add_missing_dummy_cuisine(data_estimates)
@everywhere data_estimates = add_missing_dummy_price(data_estimates)

@everywhere spec_neither,spec_nosocial,spec_nospatial,spec_standard = prepare_spec_variations(norg,originmode,specification,data_estimates;nlogit=1)

@everywhere list_spec = ["neither";"nosocial";"nospatial";"standard"]

#####################
# Predicted visits
#####################

@time list_predvisits = pmap(file->begin

  println(string("predivisit for file",file))
  df = load(string(path_predvisitsarray,file))["predvisitarray"]

  if originmode == "mintime"
    df = create_mintime_spatialfriction(df)
  end

  df_spec_neither = compute_prob_visit_venue_nlogit(norg,df,data_estimates,spec_neither,nestid;fastestmode=fastestmode,mintime=mintime)
  df_spec_nosocial = compute_prob_visit_venue_nlogit(norg,df,data_estimates,spec_nosocial,nestid;fastestmode=fastestmode,mintime=mintime)
  df_spec_nospatial = compute_prob_visit_venue_nlogit(norg,df,data_estimates,spec_nospatial,nestid;fastestmode=fastestmode,mintime=mintime)
  df_spec_standard = compute_prob_visit_venue_nlogit(norg,df,data_estimates,spec_standard,nestid;fastestmode=fastestmode,mintime=mintime)

  list_df_all_spec = push!([],df_spec_neither,df_spec_nosocial,df_spec_nospatial,df_spec_standard)
  df_all_spec = combine_results(list_df_all_spec,list_spec;proba_home=0)
  df_all_spec = remove_missing_type(df_all_spec)

  return df_all_spec
end, list_files)

@time list_predvisits_collapsed_over_workplace = pmap(df->collapse_over_workplace(df,data;proba_home=0),list_predvisits)
@time predvisits_collapsed_over_workplace = append_list_df(list_predvisits_collapsed_over_workplace)

@time save(string(path_output,"predictedvisits_collapsed_over_workplace_",race,"_",originmode,"_",specification,"_nested",nestid,".jld"),"predvisit",predvisits_collapsed_over_workplace,compress=true)
