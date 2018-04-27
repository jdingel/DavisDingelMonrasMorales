## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

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

##Specification employing only tract-level covariates
compute_estimates_mnl_newton(6,path_input,"estarray_raceblind.jld",path_output,"estimates_raceblind.csv")
