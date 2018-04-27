## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
######################

#Arguments
race = ARGS[1]
nestid = ARGS[2]
originmode = ARGS[3]

#Packages
using  DataFrames, FileIO, StatFiles, JLD

#Imported functions
include("gen_estimationarray_functions.jl")

#Path
path_input = string("../input/estarrays/",originmode,"/")
path_output = string("../output/estarrays_JLDs/",originmode,"/")

if originmode == "sixom"
  norg = 6
  mintravel_time = 0
elseif  originmode == "mintime"
  norg = 1
  mintravel_time = 1
end

########################
# Calls
########################

name_input_nests = string("estarray_",race,"_nests_nested",nestid,".dta")
name_input_incval = string("estarray_",race,"_incval_nested",nestid,".dta")
name_output = string("estarray_",race,"_nlogit_nested",nestid,".jld")
gen_estimationarray_nlogit(norg,nestid,path_input,name_input_nests,name_input_incval,path_output,name_output;mintravel_time = mintravel_time)
