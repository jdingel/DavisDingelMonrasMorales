## Author: Kevin Dano
## Purpose: estimate bootstrap
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Packages
@everywhere using DataFrames
@everywhere using CSV
@everywhere using JLD
@everywhere using StatsFuns
@everywhere using Optim
@everywhere using Calculus

#Imported functions
@everywhere include("estimation_functions.jl")

#Arguments
race_tmp = ARGS[1]
specification_tmp = ARGS[2]

for i in procs()
  @spawnat i global const race = race_tmp
  @spawnat i global const specification = specification_tmp
end

#Path
@everywhere path_input = string("../output/estarrays_JLDs/",specification,"/")
@everywhere path_output =string("../output/estimates/",specification,"/")

if specification == "mainspec"
  @everywhere norg = 6
elseif specification == "mintime"
  @everywhere norg = 1
end

##################################
# Calls
##################################

#Generate estimates for all 500 instances in parallel
@everywhere list_instances = collect(1:500)
pmap(i-> begin

println("instance : ",i)
#Give MLE as starting point
provide_starting_point = 1
path_starting_point = string("../input/estimates/",specification,"/")
name_starting_point = string("estimates_",race,"_mainspec.csv")

compute_estimates_mnl_newton(norg,path_input,string(race,"_",specification,"_",i,".jld"),path_output,string("estimates_",race,"_",specification,"_",i,".csv");provide_starting_point=provide_starting_point,path_starting_point=path_starting_point,name_starting_point=name_starting_point)

end,list_instances)
