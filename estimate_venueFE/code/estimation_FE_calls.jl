## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]
originmode = ARGS[2]

#Packages
using DataFrames,JLD, CSV
using StatsFuns, Optim, Calculus

#Imported functions
include("estimation_functions.jl")

#Path
path_input  = string("../output/estarrays_JLDs/",originmode,"/")
path_output =  string("../output/estimates/",originmode,"/")

if originmode == "sixom"
 norg = 6
elseif originmode == "mintime"
 norg = 1
end

########################
# Calls
########################

name_input = string("estarray_venueFE_",race,"_",originmode,".jld")
name_output = string("estimates_venueFE_",race,"_",originmode,".csv")

#Give MLE as staring point
provide_starting_point=1
path_starting_point = string("../input/estimates/",originmode,"/")
name_starting_point = string("estimates_",race,"_mainspec.csv")

compute_estimates_mnl_FE_hessianfree(norg,path_input,name_input,path_output,name_output;provide_starting_point=provide_starting_point,path_starting_point=path_starting_point,name_starting_point=name_starting_point)
