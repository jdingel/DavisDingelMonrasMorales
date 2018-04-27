## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
######################

#Arguments
race = ARGS[1]
spec = ARGS[2]

#Packages
using DataFrames
using FileIO
using StatFiles
using JLD

#Imported functions
include("gen_estimationarray_functions.jl")

#Path
path_input    = string("../input/estarrays/norg/")
path_output   = string("../output/estarrays_JLDs/norg/")

########################
# Calls
########################

name_input  = string("estarray_",race,"_",spec,".dta")
name_output = string("estarray_",race,"_",spec,".jld")
gen_estimationarray_mnl(2,path_input,name_input,path_output,name_output)
