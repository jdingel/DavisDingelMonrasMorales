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
@everywhere using FileIO
@everywhere using StatFiles

@everywhere originmode = "sixom"
@everywhere specification = "omintercepts"

#Arguments
bias_temp = ARGS[1]
for i in procs()
  @spawnat i global const bias = bias_temp
end

#Path
@everywhere path_input = "../input/"
@everywhere path_prob_venue_cond_race_home =  string("../input/predictedvisits/",originmode,"/")
@everywhere path_output = string("../output/",originmode,"/")

#Imported functions
@everywhere include("dissimilarity_functions.jl")

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
# COMPUTE DISSIMILARITY MEASURES
################################################################################

@everywhere list_race = ["asian","black","hispanic","white","other"]

#Import  Pr(j|r,h) = proba of visit conditional on race and home origin
@everywhere data_prob_venue_cond_black_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","black","_",originmode,"_",specification,"_",bias,".jld"))["predvisit"]
@everywhere data_prob_venue_cond_asian_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","asian","_",originmode,"_",specification,"_",bias,".jld"))["predvisit"]
@everywhere data_prob_venue_cond_whithisp_home = load(string(path_prob_venue_cond_race_home,"predictedvisits_collapsed_over_workplace_","whithisp","_",originmode,"_",specification,"_",bias,".jld"))["predvisit"]

#specification of interest
@everywhere list_spec = ["prob_visit_venue_neither","prob_visit_venue_nosocial","prob_visit_venue_home_nosocial","prob_visit_venue_nospatial","prob_visit_venue_standard","prob_visit_venue_home_standard"]

### Dissimilarity measure at venue level ###
@everywhere geographic_level = "venue_level"

list_df_temp_venue_level = pmap(spec->compute_dissimilarity(data_prob_venue_cond_black_home,data_prob_venue_cond_asian_home,data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,list_race,spec;geographic_level=geographic_level),list_spec)

data_dissimilarity_venue_level,data_dissimilarity_pairwise_venue_level =  list_df_temp_venue_level[1]

for i in 2:length(list_df_temp_venue_level)
  data_dissimilarity_venue_level = [data_dissimilarity_venue_level;list_df_temp_venue_level[i][1]]
  data_dissimilarity_pairwise_venue_level = [data_dissimilarity_pairwise_venue_level;list_df_temp_venue_level[i][2]]
end

CSV.write(string(path_output,"dissimilarity_index_",geographic_level,"_",originmode,"_",specification,"_",bias,".csv"),data_dissimilarity_venue_level)
CSV.write(string(path_output,"dissimilarity_index_pairwise_",geographic_level,"_",originmode,"_",specification,"_",bias,".csv"),data_dissimilarity_pairwise_venue_level)

### Dissimilarity measure at tract level ###
@everywhere geographic_level = "tract_level"

list_df_temp_tract_level = pmap(spec->compute_dissimilarity(data_prob_venue_cond_black_home,data_prob_venue_cond_asian_home,data_prob_venue_cond_whithisp_home,data_prob_home_cond_race,data_prob_race,list_race,spec;geographic_level=geographic_level),list_spec)

data_dissimilarity_tract_level,data_dissimilarity_pairwise_tract_level =  list_df_temp_tract_level[1]

for i in 2:length(list_df_temp_tract_level)
  data_dissimilarity_tract_level = [data_dissimilarity_tract_level;list_df_temp_tract_level[i][1]]
  data_dissimilarity_pairwise_tract_level = [data_dissimilarity_pairwise_tract_level;list_df_temp_tract_level[i][2]]
end

CSV.write(string(path_output,"dissimilarity_index_",geographic_level,"_",originmode,"_",specification,"_",bias,".csv"),data_dissimilarity_tract_level)
CSV.write(string(path_output,"dissimilarity_index_pairwise_",geographic_level,"_",originmode,"_",specification,"_",bias,".csv"),data_dissimilarity_pairwise_tract_level)
