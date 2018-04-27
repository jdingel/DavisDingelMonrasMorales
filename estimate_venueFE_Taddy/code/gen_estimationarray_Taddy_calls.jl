## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]

#Packages
using DataFrames
using FileIO
using StatFiles
using JLD

#Imported functions
include("gen_estimationarray_Taddy_functions.jl")
include("general_functions.jl")

#Path
path_input = "../input/estarrays/"
path_output = "../output/estarrays_JLDs/"

###########################
# Calls
###########################

name_input = string("estarray_venueFE_Taddy_",race,".dta")
name_output = string("estarray_Taddy_",race,".jld")
gen_estimationarray_Taddy(6,path_input,name_input,path_output,name_output)
