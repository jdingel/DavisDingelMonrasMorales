## Author: Kevin Dano
## Purpose: Estimate all specifications in paper with alternative spatial-friction assumptions
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]
originmode = ARGS[2]
spec = ARGS[3]

#Packages
using DataFrames
using CSV
using JLD
using StatsFuns
using Optim
using Calculus

#Imported functions
include("estimation_functions.jl")

#Path
path_input= string("../output/estarrays_JLDs/",originmode,"/")
path_output= string("../output/estimates/",originmode,"/")

if originmode == "sixom"
  norg = 6
elseif  originmode == "mintime"
  norg = 1
end

########################
# Calls
########################

name_input = string("estarray_",race,"_",spec,".jld")
name_output = string("estimates_",race,"_",spec,".csv")
compute_estimates_mnl_newton(norg,path_input,name_input,path_output,name_output)
