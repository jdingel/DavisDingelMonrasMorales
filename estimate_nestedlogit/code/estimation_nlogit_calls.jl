## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Arguments
race = ARGS[1]
nestid = ARGS[2]
originmode = ARGS[3]
provide_starting_point = parse(Int,ARGS[4])

#Packages
using DataFrames,JLD,CSV
using StatsFuns, Optim, Calculus

#Imported functions
include("estimation_functions.jl")

#Path
path_input = string("../output/estarrays_JLDs/",originmode,"/")
path_output = string("../output/estimates/",originmode,"/")

if originmode == "sixom"
  norg = 6
elseif  originmode == "mintime"
  norg = 1
end

########################
# Calls
########################

name_input = string("estarray_",race,"_nlogit_nested",nestid,".jld")
name_output = string("estimates_",race,"_nlogit_nested",nestid,".csv")

if provide_starting_point == 0
  compute_estimates_nlogit_uniquelambda(norg,path_input,name_input,path_output,name_output)
elseif provide_starting_point == 1

  #Give MLE as starting point
  path_starting_point = string("../input/estimates/",originmode,"/")
  name_starting_point = string("estimates_",race,"_mainspec.csv")

  compute_estimates_nlogit_uniquelambda(norg,path_input,name_input,path_output,name_output;provide_starting_point=provide_starting_point,path_starting_point=path_starting_point,name_starting_point=name_starting_point)

end
