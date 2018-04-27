## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Arguments
cftl_temp = ARGS[1]
for i in procs()
  @spawnat i global const cftl = cftl_temp
end

#Packages
@everywhere using DataFrames
@everywhere using JLD

#Path
@everywhere path_input = "../output/JLDs/"
@everywhere path_output = string("../output/predictedvisitsarray/",cftl,"/")

#Imported functions
@everywhere include("general_functions.jl")
@everywhere include("gen_array_predvisits_racespecific_functions.jl")

##############################
# Import data
##############################

#Load all primitives from the beginning
@everywhere data = load(string(path_input,"top_workplaces_5.jld"))["data"]
@everywhere data_venues = load(string(path_input,"venues.jld"))["data_venues"]
@everywhere data_geoid11 = load(string(path_input,"geoid11.jld"))["data_geoid11"]
@everywhere data_geoid11_home = load(string(path_input,"geoid11_home.jld"))["data_geoid11_home"]
@everywhere data_geoid11_home_pair = load(string(path_input,"geoid11_home_pair_",cftl,".jld"))["data_geoid11_home_pair"]
@everywhere data_geoid11_work_pair = load(string(path_input,"geoid11_work_pair_",cftl,".jld"))["data_geoid11_work_pair"]
@everywhere data_geoid11_home_work = load(string(path_input,"geoid11_home_work_",cftl,".jld"))["data_geoid11_home_work"]

###########################
# Calls
###########################

############################
# Declare global variables
############################

@everywhere list_tract = convert(Array{Int},unique(data[:geoid11_home_num]))
@everywhere randomvenuesupport = 10945

##############################
# Predicted visits users
##############################

@time pmap(tr->begin
println(string("tract num: ",tr))
temp = predvisitarray(data,data_venues,data_geoid11,data_geoid11_home,data_geoid11_home_pair,data_geoid11_work_pair,data_geoid11_home_work,tr,randomvenuesupport;cuisinetype_midaggregate=1,nest_id=1)
save(string(path_output,"predvisitarray_",tr,"_",cftl,".jld"),"predvisitarray",temp,compress = true)
end
,list_tract)
