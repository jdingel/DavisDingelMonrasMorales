## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
######################

#Arguments
race = ARGS[1]

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

name_input  = string("estarray_",race,"_","mainspec",".dta")
name_output = string("estarray_",race,"_","omintercepts",".jld")
gen_estimationarray_mnl_originmodeintercept(6,path_input,name_input,path_output,name_output)
