## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames, JLD, FileIO, StatFiles, CSV
using StatsFuns

#Arguments
race = ARGS[1]
originmode = ARGS[2]
nestid = ARGS[3]

#Path
path_estimates = string("../input/estimates/",originmode,"/")
path_predictarray = "../input/estsample_predictarray/"
path_output = string("../output/predictedvisits/",originmode,"/")

#Imported functions
include("compute_predvisits_racespecific_functions.jl")

if originmode == "sixom"
  norg = 6
elseif originmode == "mintime"
  norg = 1
end

##############################
# Calls
##############################

##Load estsample predicted
data_estsample_predictarray = read_stata(string(path_predictarray,"estsample_predictarray_",race,"_nest",nestid,".dta"))

#convert string to numeric format
data_estsample_predictarray = convert_string_numeric(data_estsample_predictarray,[:geoid11_home,:geoid11_work,:geoid11_dest])

##Load estimates
data_estimates =  CSV.read(string(path_estimates,"estimates_",race,"_nlogit_nested",nestid,".csv"),allowmissing=:none,weakrefstrings=false)

#Add potential missing dummies
data_estimates = add_missing_dummy_area(data_estimates)
data_estimates = add_missing_dummy_cuisine(data_estimates)
data_estimates = add_missing_dummy_price(data_estimates)

spec = map(i->Symbol(i),convert(Array{String},data_estimates[:names]))
spec = setdiff(spec,[:lambda])

if originmode == "mintime"
  data_estsample_predictarray = create_mintime_spatialfriction(data_estsample_predictarray)
  data_predvisits = compute_prob_visit_venue_nlogit(norg,data_estsample_predictarray,data_estimates,spec,nestid;mintime=1)
else
  data_predvisits = compute_prob_visit_venue_nlogit(norg,data_estsample_predictarray,data_estimates,spec,nestid)
end

CSV.write(string(path_output,"predictedvisits_",race,"_",originmode,"_nlogit_nest",nestid,".csv"),data_predvisits)
