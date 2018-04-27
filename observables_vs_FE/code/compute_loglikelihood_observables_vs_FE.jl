## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

println("Now using ",nprocs()," workers")

#Packages
@everywhere using DataFrames
@everywhere using JLD
@everywhere using FileIO
@everywhere using StatFiles
@everywhere using StatsFuns
@everywhere using CSV

#Arguments
@everywhere originmode = "sixom"
@everywhere norg = 6

#Path
@everywhere path_estimates = string("../input/estimates/",originmode,"/")
@everywhere path_predictarray = string("../input/estsample_predictarray/",originmode,"/")
@everywhere path_estarray = string("../input/estarrays/",originmode,"/")
@everywhere path_user_trip = "../output/"
@everywhere path_results = string("../output/results/",originmode,"/")

#Imported functions
@everywhere include("compute_predvisits_racespecific_functions.jl")
@everywhere include("compute_loglikelihood_observables_vs_FE_functions.jl")

##############################
# Calls
##############################

list_df_LL = pmap(raceid->begin

##Load estsample predicted
data_estsample_predictarray = read_stata(string(path_predictarray,"estsample_predictarray_",raceid,"_",originmode,".dta"))
data_estsample_predictarray = convert_string_numeric(data_estsample_predictarray,[:geoid11_home,:geoid11_work,:geoid11_dest])

##Load user-trip data
data_user_trip = read_stata(string(path_user_trip,"tripdata.dta"))
data_user_trip[:tripnumber]=convert(Array{Int},data_user_trip[:tripnumber])

##Load estimates
#venue FE
data_estimates_FE =  CSV.read(string(path_estimates,"estimates_venueFE_",raceid,"_",originmode,".csv"),allowmissing=:none, weakrefstrings=false)
spec_FE = map(i->Symbol(i),convert(Array{String},data_estimates_FE[:names]))
#Observables
data_estimates_obs = CSV.read(string(path_estimates,"estimates_",raceid,"_mainspec.csv"),allowmissing=:none, weakrefstrings=false)
spec_obs = map(i->Symbol(i),convert(Array{String},data_estimates_obs[:names]))

list_users = unique(data_estsample_predictarray[:userid_num])
LL_observables = sum(map(x->compute_LL_observables_userlvl(x,spec_obs,data_estimates_obs,data_estsample_predictarray,data_user_trip),list_users))
LL_FE = sum(map(x->compute_LL_FE_userlvl(x,spec_FE,data_estimates_FE,data_estsample_predictarray,data_user_trip),list_users))

df = DataFrame(race=raceid,LL_observables = LL_observables,LL_FE=LL_FE)
return df
end, ["black","asian","whithisp"])

df_LL = append_list_df(list_df_LL)
CSV.write(string(path_results,"loglikelihood_observables_vs_FE.csv"),df_LL)
