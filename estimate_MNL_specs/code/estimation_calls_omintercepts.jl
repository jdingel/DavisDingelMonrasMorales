## Author:  Kevin Dano
## Purpose: Estimate all specifications in paper with alternative spatial-friction assumptions
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]

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
path_input= string("../output/estarrays_JLDs/sixom/")
path_output= string("../output/estimates/sixom/")

########################
# Calls
########################

name_input = string("estarray_",race,"_","omintercepts",".jld")
name_output = string("estimates_",race,"_","omintercepts",".csv")
compute_estimates_mnl_newton(6,path_input,name_input,path_output,name_output)
