## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
######################

#Packages
using DataFrames
using FileIO
using StatFiles
using JLD

#Imported functions
include("gen_estimationarray_functions.jl")

#Path
path_input    = string("../input/estarrays/sixom/")
path_output   = string("../output/estarrays_JLDs/sixom/")

########################
# Calls
########################

#Specification employing only tract-level covariates
gen_estimationarray_mnl(6,path_input,"estarray_raceblind.dta",path_output,"estarray_raceblind.jld")
