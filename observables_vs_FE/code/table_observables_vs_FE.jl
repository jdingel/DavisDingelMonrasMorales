## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using CSV
using Distributions

#Imported functions
include("general_functions.jl")
include("table_observables_vs_FE_functions.jl")

#Path
path_input = "../output/results/sixom/"
path_tables = "../output/tables/sixom/"

####################
# Calls
###################

data = CSV.read(string(path_input,"loglikelihood_observables_vs_FE.csv"))

#The chisq2 test has 10899 degrees of freedom
data_LR_test = append_list_df(map(raceid->compute_LR_test_observables_vs_FE(raceid,data,10899),["asian";"black";"whithisp"]))
data_LR_test = adds_statistical_significance_LR(data_LR_test)

table_observables_vs_FE(data_LR_test,path_tables,"table_observables_vs_FE.tex")
