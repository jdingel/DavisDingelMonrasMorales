## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
######################

#Arguments
race = ARGS[1]
norg = ARGS[2]

#Packages
using DataFrames
using FileIO
using StatFiles
using JLD

#Imported functions
include("gen_estimationarray_functions.jl")

#Path
path_input  = string("../input/estarrays/sixom/")
path_output = string("../output/estarrays_JLDs/norg/")

########################
# Calls
########################

name_input = string("estarray_",race,"_spatial.dta")
gen_estimationarray_mnl(parse(Int,norg),path_input,name_input,path_output,string("estarray_",race,"_spatial",norg,".jld"))
