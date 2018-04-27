## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]
originmode = ARGS[2]

#Packages
using  DataFrames, FileIO, StatFiles, JLD

#Imported functions
include("gen_estimationarray_functions.jl")

#Path
path_input  = string("../input/estarrays/",originmode,"/")
path_output = string("../output/estarrays_JLDs/",originmode,"/")

if originmode == "sixom"
  norg = 6
  mintravel_time = 0
  name_input = string("estarray_venueFE_",race,".dta")
elseif originmode == "mintime"
  norg = 1
  mintravel_time = 1
  name_input = string("estarray_venueFE_mintime_",race,".dta")
end

########################
# Calls
########################

name_output = string("estarray_venueFE_",race,"_",originmode,".jld")
gen_estimationarray_mnl_FE(norg,path_input,name_input,path_output,name_output;mintravel_time=mintravel_time)
