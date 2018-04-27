## Author: Kevin Dano
## Date: April 2018
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using FileIO
using StatFiles
using JLD

#Imported functions
include("general_functions.jl")

#Path
path_input = "../input/"
path_output =  "../output/JLDs/"

##################################################################
# Generate JLD files required in the computation of predicted visits
##################################################################

####
data = read_stata(string(path_input,"top_workplaces_5.dta"))
try
  return convert_string_numeric(data,[:geoid11_home;:geoid11_work]) #convert to the right format
  catch
  return data #already in proper format
end
save(string(path_output,"top_workplaces_5.jld"),"data",data,compress=true)
####

####
data_venues = read_stata(string(path_input,"venues.dta"))
try
  return convert_string_numeric(data_venues,[:geoid11]) #convert to the right format
catch
  return
  data_venues #already in proper format
end
rename!(data_venues,:geoid11=>:geoid11_dest)
data_venues = sort!(data_venues,cols = order(:venue_num))
data_venues[:randomvenueid] = collect(1:nrow(data_venues))
save(string(path_output,"venues.jld"),"data_venues",data_venues,compress=true)
####

####
data_geoid11 = read_stata(string(path_input,"tract_2010_characteristics_est.dta"))
retain_cols = ["geoid11";covariates_endingwith(data_geoid11,"_percent");covariates_startingby(data_geoid11,"spectral")]
retain_cols = [retain_cols;covariates_startingby(data_geoid11,"robberies");"median_household_income";"area_dummy_assignment"]
retain_cols = map(x->Symbol(x),retain_cols)
data_geoid11 = data_geoid11[:,retain_cols]
try
  return convert_string_numeric(data_geoid11,[:geoid11]) #convert to the right format
catch
  return
  data_geoid11 #already in proper format
end
rename!(data_geoid11,:geoid11=>:geoid11_dest)
save(string(path_output,"geoid11.jld"),"data_geoid11",data_geoid11,compress=true)
####

####
data_geoid11_home = read_stata(string(path_input,"tract_2010_characteristics_est.dta"))
retain_cols = [:geoid11 ;:median_household_income ;:share_21to39]
data_geoid11_home = data_geoid11_home[:,retain_cols]
rename!(data_geoid11_home,[f => t for (f, t) = zip([:geoid11; :median_household_income],[:geoid11_home, :median_household_income_home])])
try
  return convert_string_numeric(data_geoid11_home,[:geoid11_home]) #convert to the right format
catch
  return
  data_geoid11_home #already in proper format
end
save(string(path_output,"geoid11_home.jld"),"data_geoid11_home",data_geoid11_home,compress=true)
####

####
data_geoid11_home_pair = read_stata(string(path_input,"tract_pairs_2010_characteristics_est.dta"))
retain_cols =[covariates_startingby(data_geoid11_home_pair,"geoid11_");"median_income_percent_difference"; "med_income_perc_diff_signed"; "eucl_demo_distance"; "traveltime_car"; "traveltime_public"; "vehicle_avail_hhshare_diff"]
retain_cols = map(x->Symbol(x),retain_cols)
data_geoid11_home_pair = data_geoid11_home_pair[:,retain_cols]
rename!(data_geoid11_home_pair,[f => t for (f, t) = zip([:geoid11_orig; :traveltime_public ;:traveltime_car],[:geoid11_home; :time_public_home; :time_car_home])])
try
  return convert_string_numeric(data_geoid11_home_pair,[:geoid11_home;:geoid11_dest]) #convert to the right format
catch
  return
  data_geoid11_home_pair #already in proper format
end
save(string(path_output,"geoid11_home_pair.jld"),"data_geoid11_home_pair",data_geoid11_home_pair,compress=true)
####

####
data_geoid11_work_pair = read_stata(string(path_input,"tract_pairs_2010_characteristics_est.dta"))
retain_cols= [covariates_startingby(data_geoid11_work_pair,"geoid11_");"traveltime_car";"traveltime_public"]
retain_cols = map(x->Symbol(x),retain_cols)
data_geoid11_work_pair = data_geoid11_work_pair[:,retain_cols]
rename!(data_geoid11_work_pair,[f => t for (f, t) = zip([:geoid11_orig; :traveltime_public; :traveltime_car],[:geoid11_work; :time_public_work; :time_car_work])])
try
  return convert_string_numeric(data_geoid11_work_pair,[:geoid11_work;:geoid11_dest]) #convert to the right format
catch
  return
  data_geoid11_work_pair #already in proper format
end
save(string(path_output,"geoid11_work_pair.jld"),"data_geoid11_work_pair",data_geoid11_work_pair,compress=true)
####

####
data_geoid11_home_work=copy(data_geoid11_work_pair)
rename!(data_geoid11_home_work,[f => t for (f, t) = zip([:geoid11_work; :geoid11_dest; :time_public_work; :time_car_work],[:geoid11_home; :geoid11_work; :time_public_home_work; :time_car_home_work])])
save(string(path_output,"geoid11_home_work.jld"),"data_geoid11_home_work",data_geoid11_home_work,compress=true)
####
