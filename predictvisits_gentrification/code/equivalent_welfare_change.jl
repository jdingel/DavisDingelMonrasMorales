## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
######################

#Packages
using DataFrames
using CSV
using JLD
using Optim
using StatsFuns

#Imported functions
include("general_functions.jl")
include("gen_array_predvisits_racespecific_functions.jl")
include("compute_predvisits_racespecific_functions.jl")
include("equivalent_welfare_change_functions.jl")

#Path
path_input1 = "../input/"
path_input2 = "../output/JLDs/"
path_estimates = "../input/estimates/"
path_predictedvisits = "../output/predictedvisits/"

###################
# Calls
###################

norg = 6
data = load(string(path_input1,"top_workplaces_5.jld"))["data"]
data_estimates = CSV.read(string(path_estimates,"estimates_","black","_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
spec_standard = map(i->Symbol(i),convert(Array{String},data_estimates[:names]))
keep_cols = [:userid_num;:venue_num;:geoid11_home;:geoid11_work;:geoid11_dest]
keep_cols = [keep_cols;spec_standard]
randomvenuesupport = 10945

# primitives for predicted visits array
data_venues = load(string(path_input1,"venues.jld"))["data_venues"]
data_geoid11 = load(string(path_input1,"geoid11.jld"))["data_geoid11"]
data_geoid11_home = load(string(path_input1,"geoid11_home.jld"))["data_geoid11_home"]
data_geoid11_home_pair = load(string(path_input1,"geoid11_home_pair.jld"))["data_geoid11_home_pair"]
data_geoid11_work_pair = load(string(path_input1,"geoid11_work_pair.jld"))["data_geoid11_work_pair"]
data_geoid11_home_work = load(string(path_input1,"geoid11_home_work.jld"))["data_geoid11_home_work"]

for (tract_geoid11,tract_name) in zip([36061022400;36047029300],["Harlem";"Bedstuy"])

  tract_num = convert(Array{Int},unique(data[data[:geoid11_home].==tract_geoid11,:geoid11_home_num]))[1]

  #1) Recompute predicted visits array
  data_predictarray = predvisitarray(data,data_venues,data_geoid11,data_geoid11_home,data_geoid11_home_pair,data_geoid11_work_pair,data_geoid11_home_work,tract_num,randomvenuesupport;cars=0,keep_time_levels=1)

  #2) Identify treated venues
  data_venues = load(string(path_input2,"venues_",tract_name,".jld"))["data_venues"]
  venues_treated = convert(Array{Int},unique(data_venues[data_venues[:treat].==1,:venue_num])) #treated venues
  venues_untreated = convert(Array{Int},unique(data_venues[data_venues[:treat].==0,:venue_num]))

  #3) Load P_ij obtained for the gentrification scenario
  data_predvisits_gentrification = CSV.read(string(path_predictedvisits,"predictedvisits_","black","_",tract_name,"_gentrificationscenario.csv"),allowmissing=:none,weakrefstrings=false)
  data_predvisits_gentrification[:welfare] = log(data_predvisits_gentrification[:denom_prob_visit_venue]) #create welfare variabl

  #4) Search for delta
  delta = zeros(5)

  for userid in 1:5

    data_predictarray_sub = data_predictarray[data_predictarray[:userid_num].==userid,:]
    data_predvisits_gentrification_sub = data_predvisits_gentrification[data_predvisits_gentrification[:userid_num].==userid,:]

    function f_obj(x)
      return compute_welfare_diff(x,data_predictarray_sub,data_predvisits_gentrification_sub,venues_treated,venues_untreated,keep_cols)
    end

    rez = optimize(f_obj,0.0,10.0,show_trace=true)
    delta[userid] = Optim.minimizer(rez)-1 #to get percentage change
  end

  df_temp = unique(data_predictarray[:,[:userid_num,:geoid11_home,:geoid11_work]])
  df_temp[:delta_percent] = 100*delta

  CSV.write(string(path_predictedvisits,"equiv_percentage_increase_minutes_time_home_",tract_name,".csv"),df_temp)

end
