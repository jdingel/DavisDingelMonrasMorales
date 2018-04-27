## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
######################

race = ARGS[1]
originmode = ARGS[2]
spec = ARGS[3]

using DataFrames
using FileIO
using StatFiles
using JLD

#Calls relevant functions
include("gen_estimationarray_functions.jl")

path_input    = string("../input/estarrays/",originmode,"/")
path_output   = string("../output/estarrays_JLDs/",originmode,"/")

if originmode == "sixom"
  norg = 6
  mintravel_time = 0
elseif  originmode == "mintime"
  norg = 1
  mintravel_time = 1
end

if spec == "spatialincome" || spec == "spatialage" || spec == "spatialgender"
  interacted_timecovariates = 1
else
  interacted_timecovariates = 0
end

########################
# Calls
########################
println("This is with race =",race," originmode =",originmode," spec = ",spec)

name_input  = string("estarray_",race,"_",spec,".dta")
name_output = string("estarray_",race,"_",spec,".jld")
gen_estimationarray_mnl(norg,path_input,name_input,path_output,name_output;mintravel_time=mintravel_time,interacted_timecovariates=interacted_timecovariates)
