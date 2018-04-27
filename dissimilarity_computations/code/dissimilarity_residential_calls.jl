## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using CSV
using JLD
using FileIO
using StatFiles

#Path
path_input = "../input/"
path_output = "../output/"

#Imported functions
include("dissimilarity_functions.jl")

################################################################################
# SIMULATIONS
################################################################################

##################
#Load primitives
##################

data_tract_2010_characteristics_est = read_stata(string(path_input,"tract_2010_characteristics_est.dta"))
data_tract_2010_characteristics_est = convert_string_numeric(data_tract_2010_characteristics_est,[:geoid11])

############################
# Compute Pr(h|r) and Pr(r)
#############################

data_prob_home_cond_race,data_prob_race = compute_prob_home_cond_race_and_prob_race(data_tract_2010_characteristics_est;add_nonrace=1)

################################################################################
# COMPUTE DISSIMILARITY MEASURES
################################################################################

list_race = ["asian","black","hispanic","white","other","whithisp"]

############################
# Residential dissimilarity
############################

data_dissimilarity_index_residential = append_list_df(map(race->dissimilarity_index_residential(data_prob_home_cond_race,race),list_race))
data_dissimilarity_index_pairwise_residential = append_list_df(map((r1,r2)->dissimilarity_index_pairwise_residential(data_prob_home_cond_race,r1,r2),["asian";"asian";"asian";"hispanic";"black";"black"],["hispanic";"black";"white";"white";"hispanic";"white"]))

CSV.write(string(path_output,"dissimilarity_index_residential.csv"),data_dissimilarity_index_residential)
CSV.write(string(path_output,"dissimilarity_index_pairwise_residential.csv"),data_dissimilarity_index_pairwise_residential)
