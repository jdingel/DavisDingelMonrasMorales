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
include("dissimilarity_tables_cftl_functions.jl")

############################
# Produce tex table
############################

###################################################
# Dissimilarity venue level
###################################################

list_data_dissimilarity_venue_level = []; list_data_dissimilarity_tract_level = []
list_data_dissimilarity_pairwise_venue_level = []; list_data_dissimilarity_pairwise_tract_level = []

for spec in "mainspec".*["";"_";"_";"_"].*["";"2ndAve";"slowdown";"socialchange"]
  list_data_dissimilarity_venue_level = push!(list_data_dissimilarity_venue_level,CSV.read(string(path_input,"dissimilarity_index_venue_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))
  list_data_dissimilarity_tract_level = push!(list_data_dissimilarity_tract_level,CSV.read(string(path_input,"dissimilarity_index_tract_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))

  list_data_dissimilarity_pairwise_venue_level = push!(list_data_dissimilarity_pairwise_venue_level,CSV.read(string(path_input,"dissimilarity_index_pairwise_venue_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))
  list_data_dissimilarity_pairwise_tract_level = push!(list_data_dissimilarity_pairwise_tract_level,CSV.read(string(path_input,"dissimilarity_index_pairwise_tract_level_sixom_",spec,".csv"),allowmissing=:none,weakrefstrings=false))
end

list_names = ["Estimated","2nd Ave","Slowdown","Social Change"]

#venue level
dissimilarity_tex_table_cftl(list_data_dissimilarity_venue_level,list_data_dissimilarity_pairwise_venue_level,list_names,path_output,"dissimilarity_cftl_venue_level.tex")
#tract level
dissimilarity_tex_table_cftl(list_data_dissimilarity_tract_level,list_data_dissimilarity_pairwise_tract_level,list_names,path_output,"dissimilarity_cftl_tract_level.tex")
