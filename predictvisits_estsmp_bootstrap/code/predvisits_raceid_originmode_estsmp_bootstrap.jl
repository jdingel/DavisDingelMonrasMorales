## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Packages
@everywhere using DataFrames
@everywhere using CSV
@everywhere using FileIO
@everywhere using StatFiles
@everywhere using JLD
@everywhere using StatsFuns

#Arguments
race_tmp = ARGS[1]
originmode_tmp = ARGS[2]

for i in procs()
  @spawnat i global const race = race_tmp
  @spawnat i global const originmode = originmode_tmp
end

if originmode == "mainspec"
  @everywhere norg = 6
  @everywhere mintime = 0
  @everywhere spec = "sixom"
elseif  originmode == "mintime"
  @everywhere norg = 1
  @everywhere mintime = 1
  @everywhere spec = "mintime"
end

#Path
@everywhere path_predvisitsarray = string("../input/estsample_predictarray/",originmode,"/") #temporary path
@everywhere path_estimates = string("../input/estimates/",originmode,"/")
@everywhere path_output = string("../output/",originmode,"/",race,"/")

#Imported functions
@everywhere include("compute_predvisits_racespecific_functions.jl")

##############################
# Calls
##############################

##Load estsample predicted
@everywhere data_estsample_predictarray = read_stata(string(path_predvisitsarray,"estsample_predictarray_",race,"_",spec,".dta"))

#convert string to numeric format
@everywhere data_estsample_predictarray = try
  convert_string_numeric(data_estsample_predictarray,[:geoid11_home,:geoid11_work,:geoid11_dest])
catch
  return data_estsample_predictarray
end

@everywhere data_estimates_all = readtable(string(path_estimates,"estimates_",race,"_",originmode,"_bootstrap_clean.csv"))
@everywhere data_estimates_all = remove_missing_type(data_estimates_all)

@everywhere list_data_estimates = groupby(data_estimates_all,:instance)

pmap(k->
begin

data_estimates = list_data_estimates[k][:,1:end]
num_instance = unique(data_estimates[:instance])[1]
println("instance :",num_instance)

#Add potential missing dummies
data_estimates = add_missing_dummy_area(data_estimates)
data_estimates = add_missing_dummy_cuisine(data_estimates)
data_estimates = add_missing_dummy_price(data_estimates)

specification = map(i->Symbol(i),convert(Array{String},data_estimates[:names]))

data_predvisits = compute_prob_visit_venue(norg,data_estsample_predictarray,data_estimates,specification;mintime=mintime)

CSV.write(string(path_output,"predictedvisits_",race,"_",originmode,"_",num_instance,".csv"),data_predvisits)
end, collect(1:length(list_data_estimates)))
