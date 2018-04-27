## Author: Kevin Dano
## Date: April 2018
## Purpose: Dissimilarity robustness checks
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

###################################################
# Dissimilarity venue level
###################################################

list_data_dissimilarity_venue_level = []; list_data_dissimilarity_tract_level = []

for spec in ["mainspec","nlogit_nested1","nlogit_nested2","omintercepts_nobias","half","fifth","locainfo1","locainfo2","lateadopt","carshare","revchain","disaggcuis"]
  list_data_dissimilarity_venue_level = push!(list_data_dissimilarity_venue_level,CSV.read(string(path_input,"dissimilarity_index_venue_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))
  list_data_dissimilarity_tract_level = push!(list_data_dissimilarity_tract_level,CSV.read(string(path_input,"dissimilarity_index_tract_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))
end

list_names = ["mainspec","nest1","nest2","omintercepts","half","fifth","Locainfo1","Locainfo2","Late adopt","Cars","Chains","Disagg cuisine"]

#Add Home-only

data_homeonly_venue_level = CSV.read(string(path_input,"dissimilarity_index_venue_level_sixom_","mainspec",".csv"),allowmissing=:none,weakrefstrings=false)
data_homeonly_venue_level = data_homeonly_venue_level[findin(data_homeonly_venue_level[:spec],["prob_visit_venue_home_standard", "prob_visit_venue_nospatial","prob_visit_venue_home_nosocial","prob_visit_venue_neither"]),:]
data_homeonly_venue_level[data_homeonly_venue_level[:spec].=="prob_visit_venue_home_standard",:spec]="prob_visit_venue_standard"
data_homeonly_venue_level[data_homeonly_venue_level[:spec].=="prob_visit_venue_home_nosocial",:spec]="prob_visit_venue_nosocial"

list_data_dissimilarity_venue_level = push!(list_data_dissimilarity_venue_level,data_homeonly_venue_level)

data_homeonly_tract_level = CSV.read(string(path_input,"dissimilarity_index_tract_level_sixom_","mainspec",".csv"),allowmissing=:none,weakrefstrings=false)
data_homeonly_tract_level = data_homeonly_tract_level[findin(data_homeonly_tract_level[:spec],["prob_visit_venue_home_standard", "prob_visit_venue_nospatial","prob_visit_venue_home_nosocial","prob_visit_venue_neither"]),:]
data_homeonly_tract_level[data_homeonly_tract_level[:spec].=="prob_visit_venue_home_standard",:spec]="prob_visit_venue_standard"
data_homeonly_tract_level[data_homeonly_tract_level[:spec].=="prob_visit_venue_home_nosocial",:spec]="prob_visit_venue_nosocial"

list_data_dissimilarity_tract_level = push!(list_data_dissimilarity_tract_level,data_homeonly_tract_level)

list_names = [list_names;"Home only"]


#comparison "within-race"
dissimilarity_robustnesschecks_tex_table(list_data_dissimilarity_venue_level,list_names,path_output,"dissimilarity_robustnesschecks_venue_level_comp_within_race";presentation=1)
dissimilarity_robustnesschecks_tex_table(list_data_dissimilarity_tract_level,list_names,path_output,"dissimilarity_robustnesschecks_tract_level_comp_within_race";presentation=1)

#comparison "across races"
dissimilarity_robustnesschecks_tex_table(list_data_dissimilarity_venue_level,list_names,path_output,"dissimilarity_robustnesschecks_venue_level_comp_across_race";presentation=0)
dissimilarity_robustnesschecks_tex_table(list_data_dissimilarity_venue_level,list_names,path_output,"dissimilarity_robustnesschecks_tract_level_comp_across_race";presentation=0)
