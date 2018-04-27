## Author: Kevin Dano
## Date: February 2018
## Purpose: Produce dissimilarity tables
## Julia version: 0.6.2

###########################
# Computing ressources
###########################

#Packages
using DataFrames
using CSV

#Path
path_input = "../input/sixom/"
path_output = "../output/sixom/"

#Imported functions
include("dissimilarity_tables_functions.jl")

############################
# Produce tex table
############################

retain_spec = ["prob_visit_venue_home_standard", "prob_visit_venue_nospatial","prob_visit_venue_home_nosocial","prob_visit_venue_neither"]

###################################################
# Dissimilarity venue level
###################################################

data_dissimilarity_residential = CSV.read(string(path_input,"../","dissimilarity_index_residential.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity_pairwise_residential = CSV.read(string(path_input,"../","dissimilarity_index_pairwise_residential.csv"),allowmissing=:none,weakrefstrings=false)

data_dissimilarity = CSV.read(string(path_input,"dissimilarity_index_venue_level_sixom_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity = data_dissimilarity[findin(data_dissimilarity[:spec],retain_spec),:]

data_dissimilarity_pairwise = CSV.read(string(path_input,"dissimilarity_index_pairwise_venue_level_sixom_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity_pairwise = data_dissimilarity_pairwise[findin(data_dissimilarity_pairwise[:spec],retain_spec),:]

dissimilarity_tex_table(data_dissimilarity_residential,data_dissimilarity_pairwise_residential,data_dissimilarity,data_dissimilarity_pairwise,path_output,"dissimilarity_mainspec_venue_level_homeonly.tex")

###################################################
# Dissimilarity tract level - main specification
###################################################

data_dissimilarity_residential = CSV.read(string(path_input,"../","dissimilarity_index_residential.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity_pairwise_residential = CSV.read(string(path_input,"../","dissimilarity_index_pairwise_residential.csv"),allowmissing=:none,weakrefstrings=false)

data_dissimilarity = CSV.read(string(path_input,"dissimilarity_index_tract_level_sixom_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity = data_dissimilarity[findin(data_dissimilarity[:spec],retain_spec),:]

data_dissimilarity_pairwise = CSV.read(string(path_input,"dissimilarity_index_pairwise_tract_level_sixom_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
data_dissimilarity_pairwise = data_dissimilarity_pairwise[findin(data_dissimilarity_pairwise[:spec],retain_spec),:]

dissimilarity_tex_table(data_dissimilarity_residential,data_dissimilarity_pairwise_residential,data_dissimilarity,data_dissimilarity_pairwise,path_output,"dissimilarity_mainspec_tract_level_homeonly.tex")
