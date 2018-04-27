## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

@everywhere using DataFrames
@everywhere using CSV
@everywhere using FileIO
@everywhere using StatFiles
@everywhere using JLD

@everywhere include("dissimilarity_functions.jl")
@everywhere include("dot_maps_functions.jl")

@everywhere originmode = "sixom"
@everywhere specification= "mainspec"

@everywhere path_input = "../input/"
@everywhere path_prob_venue_cond_race_home = "../input/predictedvisits/"
@everywhere path_output = "../output/"

##################
#Load primitives
##################

@everywhere data_tract_2010_characteristics_est = read_stata(string(path_input,"tract_2010_characteristics_est.dta"))
@everywhere data_tract_2010_characteristics_est = convert_string_numeric(data_tract_2010_characteristics_est,[:geoid11])

############################
# Compute Pr(h|r) and Pr(r)
#############################

@everywhere data_prob_home_cond_race,data_prob_race = compute_prob_home_cond_race_and_prob_race(data_tract_2010_characteristics_est;add_nonrace=1)

################################################################################
# Computes Pr(j|r)
################################################################################

#Import  Pr(j|r,h) = proba of visit conditional on race and home origin
@everywhere data_prob_venue_cond_black_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","black","_",originmode,"_",specification,".jld"))["predvisit"]
@everywhere data_prob_venue_cond_asian_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","asian","_",originmode,"_",specification,".jld"))["predvisit"]
@everywhere data_prob_venue_cond_whithisp_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","whithisp","_",originmode,"_",specification,".jld"))["predvisit"]

#Specification of interest
@everywhere list_spec = ["prob_visit_venue_neither","prob_visit_venue_nosocial","prob_visit_venue_nospatial","prob_visit_venue_standard"]
@everywhere list_spec_abbreviation = ["neither","nosocial","nospatial","standard"]

list_df = pmap((spec,name)-> begin
df_temp = gather_prob_venue_cond_race(spec,name,data_tract_2010_characteristics_est,data_prob_home_cond_race,data_prob_race,data_prob_venue_cond_black_home,data_prob_venue_cond_asian_home,data_prob_venue_cond_whithisp_home)
end, list_spec,list_spec_abbreviation)

df_all = append_list_df(list_df)

CSV.write(string(path_output,"pr_dest_race_tract_level_",originmode,"_",specification,".csv"),df_all)
