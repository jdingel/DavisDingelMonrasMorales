## Author:  Kevin Dano
## Purpose: Estimate all specifications in paper with alternative spatial-friction assumptions
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]
norg = ARGS[2]

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
path_input= string("../output/estarrays_JLDs/norg/")
path_output= string("../output/estimates/norg/")

########################
# Calls
########################

name_input = string("estarray_",race,"_spatial",norg,".jld")
name_output = string("estimates_",race,"_spatial",norg,".csv")
compute_estimates_mnl_newton(parse(Int,norg),path_input,name_input,path_output,name_output)
