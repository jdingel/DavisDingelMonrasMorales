## Julia version: 0.6.2
## Author: Kevin Dano

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]

#Packages
using DataFrames,JLD, CSV
using StatsFuns, Optim, Calculus

#Imported functions
include("estimation_Taddy_functions.jl")

#Path
path_input  = "../output/estarrays_JLDs/"
path_output = "../output/estimates/"

########################
# Calls
########################

name_input = string("estarray_Taddy_",race,".jld")
name_output = string("estimates_Taddy_",race,".csv")
compute_estimates_Taddy(6,path_input,name_input,path_output,name_output)
