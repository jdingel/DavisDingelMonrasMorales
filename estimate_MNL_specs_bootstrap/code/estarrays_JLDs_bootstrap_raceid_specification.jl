## Author: Kevin Dano
## Purpose: Generate estimation arrays: DTA to JLD
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Packages
@everywhere using DataFrames
@everywhere using FileIO
@everywhere using StatFiles
@everywhere using JLD

#Imported functions
@everywhere include("gen_estimationarray_functions.jl")

#Arguments
race_tmp = ARGS[1]
specification_tmp = ARGS[2]

for i in procs()
  @spawnat i global const race = race_tmp
  @spawnat i global const specification = specification_tmp
end

if specification == "mainspec"
  @everywhere norg = 6
  @everywhere mintravel_time = 0
elseif specification == "mintime"
  @everywhere norg = 1
  @everywhere mintravel_time = 1
end

#Path
@everywhere path_input = string("../input/estarrays/",specification,"/")
@everywhere path_output = string("../output/estarrays_JLDs/",specification,"/")

##################################
# Calls
##################################

#Generate estimationarray for all 500 instances in parallel
@everywhere list_instances = collect(1:500)
pmap(i->gen_estimationarray_mnl(norg,path_input,string(race,"_",i,".dta"),path_output,string(race,"_",specification,"_",i,".jld");mintravel_time=mintravel_time),list_instances)
