## Author: Kevin Dano
## Date: April 2018
## Purpose: Computes P_ij for residents of tract 36061022400 and 36047029300
## Note: "Harlem" geoid11=="36061022400"; "Bedstuy"  geoid11=="36047029300"
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using CSV
using JLD
using FileIO
using StatFiles
using StatsFuns

#Path
path_input1 = "../input/"
path_input2 = "../output/JLDs/"
path_estimates = "../input/estimates/"
path_predictarray = "../input/predvisitsarray/"
path_output = "../output/predictedvisits/"

#Imported functions
include("general_functions.jl")
include("compute_predvisits_racespecific_functions.jl")
include("gen_array_predvisits_racespecific_functions.jl")

##############################
# Calls
##############################

norg = 6
data = load(string(path_input1,"top_workplaces_5.jld"))["data"]
data_estimates = CSV.read(string(path_estimates,"estimates_","black","_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
spec_standard = map(i->Symbol(i),convert(Array{String},data_estimates[:names]))
randomvenuesupport = 10945

##################################
# Computes true P_ij
##################################

for (tract_geoid11,tract_name) in zip([36061022400;36047029300],["Harlem";"Bedstuy"])

  tract_num = convert(Array{Int},unique(data[data[:geoid11_home].==tract_geoid11,:geoid11_home_num]))[1]
  data_predvisitarray = load(string(path_predictarray,"predvisitarray_",tract_num,".jld"))["predvisitarray"]
  data_predvisit_standard = compute_prob_visit_venue(norg,data_predvisitarray,data_estimates,spec_standard;gentrification=1)

  CSV.write(string(path_output,"predictedvisits_","black","_",tract_name,"_truevalue.csv"),data_predvisit_standard)

end

##################################################
# Computes P_ij for the gentrification scenarios
##################################################

for (tract_geoid11,tract_name) in zip([36061022400;36047029300],["Harlem";"Bedstuy"])

  data_venues = load(string(path_input2,"venues_",tract_name,".jld"))["data_venues"]
  data_geoid11 = load(string(path_input2,"geoid11_",tract_name,".jld"))["data_geoid11"]
  data_geoid11_home = load(string(path_input2,"geoid11_home_",tract_name,".jld"))["data_geoid11_home"]
  data_geoid11_home_pair = load(string(path_input2,"geoid11_home_pair_",tract_name,".jld"))["data_geoid11_home_pair"]
  data_geoid11_work_pair = load(string(path_input2,"geoid11_work_pair_",tract_name,".jld"))["data_geoid11_work_pair"]
  data_geoid11_home_work = load(string(path_input2,"geoid11_home_work_",tract_name,".jld"))["data_geoid11_home_work"]

  tract_num = convert(Array{Int},unique(data[data[:geoid11_home].==tract_geoid11,:geoid11_home_num]))[1]

  data_predvisitarray = predvisitarray(data,data_venues,data_geoid11,data_geoid11_home,data_geoid11_home_pair,data_geoid11_work_pair,data_geoid11_home_work,tract_num,randomvenuesupport;cars=0)
  save(string(path_output,"../predvisitsarray/","predvisitarray_","black","_",tract_name,"_gentrificationscenario.jld"),"predvisitarray",data_predvisitarray,compress=true)

  data_predvisit_gentrification = compute_prob_visit_venue(norg,data_predvisitarray,data_estimates,spec_standard;gentrification=1)
  CSV.write(string(path_output,"predictedvisits_","black","_",tract_name,"_gentrificationscenario.csv"),data_predvisit_gentrification)

end
