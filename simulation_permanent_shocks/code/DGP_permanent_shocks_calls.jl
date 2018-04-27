## Author: Kevin Dano
## Date: April 2018
## Purpose: Simulation of permanent ij shocks: is there an attenuation bias as we increase the number of periods ?
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames, JLD
using LaTeXStrings
using Distributions
using Optim,StatsFuns, Calculus

#Imported functions
include("fit_mnl_newton.jl")
include("DGP_permanent_shocks_functions.jl")

#Path
path_tables = "../output/"

########################################################################################################################################################################################################################################################
# Simulations
########################################################################################################################################################################################################################################################

#In each draw there are 100 users who make 40 trips to restaurants
I = 100
T = 40
names_covariates = ["Rating";"Distance"]
disutility_distance = -1.0
coeff_rating = 1.0
theta = [coeff_rating;disutility_distance]
K = length(theta)
theta_init = zeros(K)

########################################################################################################################################################################################################################################################
#  J = 1000, T = 40
########################################################################################################################################################################################################################################################

####################################
# 1) norg = 1, magnitude_error = 1
####################################

#Fixing the seed
srand(2)

norg = 1
J = 1000
magnitude_error = 1

data_venue = generate_data_venue(J)

list_choices_full1 = Array[]; list_data_full1 = Array[]
list_choices_half1 = Array[]; list_data_half1 = Array[]
list_choices_fifth1 = Array[]; list_data_fifth1 = Array[]

list_list_choices_full1 = Array[]; list_list_data_full1 = Array[]
list_list_choices_half1 = Array[]; list_list_data_half1 = Array[]
list_list_choices_fifth1 = Array[]; list_list_data_fifth1 = Array[]

for i in 1:I
  list_choices_full1_temp, list_data_full1_temp = DGP_norg_permanentshocks(norg,T,data_venue,i,disutility_distance,coeff_rating;magnitude_error = magnitude_error)

  list_choices_half1_temp = keep_obs(list_choices_full1_temp,0.5)
  list_data_half1_temp =   keep_obs(list_data_full1_temp,0.5)

  list_choices_fifth1_temp = keep_obs(list_choices_full1_temp,0.2)
  list_data_fifth1_temp =   keep_obs(list_data_full1_temp,0.2)

  list_choices_full1 = Array[list_choices_full1;list_choices_full1_temp];
  list_data_full1 = Array[list_data_full1;list_data_full1_temp];

  list_choices_half1=Array[list_choices_half1;list_choices_half1_temp];
  list_data_half1 = Array[list_data_half1;list_data_half1_temp];

  list_choices_fifth1 = Array[list_choices_fifth1;list_choices_fifth1_temp];
  list_data_fifth1 = Array[list_data_fifth1;list_data_fifth1_temp];

  list_list_choices_full1 = push!(list_list_choices_full1,list_choices_full1_temp);
  list_list_data_full1 = push!(list_list_data_full1,list_data_full1_temp);

  list_list_choices_half1=push!(list_list_choices_half1,list_choices_half1_temp)
  list_list_data_half1 = push!(list_list_data_half1,list_data_half1_temp);

  list_list_choices_fifth1=push!(list_list_choices_fifth1,list_choices_fifth1_temp)
  list_list_data_fifth1 = push!(list_list_data_fifth1,list_data_fifth1_temp);
end

println("MLE using all trips: T = ", T)
@time rez_full1 = fit_mnl_newton(theta_init,list_data_full1,list_choices_full1,norg)
theta_estimate_full1 = Optim.minimizer(rez_full1)
println("True theta:",theta)
println("Estimator:",theta_estimate_full1)

std_estimate_full1 = std_mnl_newton(theta_estimate_full1,list_data_full1,list_choices_full1,norg)
println("Standard deviation of MLE:",std_estimate_full1)

df_full1 = DataFrame(names = names_covariates,estimates = theta_estimate_full1,std = std_estimate_full1,num_trips = length(list_data_full1),num_venues = 1000)

println("MLE using half of the trips")
@time rez_half1 = fit_mnl_newton(theta_init,list_data_half1,list_choices_half1,norg)
theta_estimate_half1 = Optim.minimizer(rez_half1)
println("True theta:",theta)
println("Estimator:",theta_estimate_half1)

std_estimate_half1 = std_mnl_newton(theta_estimate_half1,list_data_half1,list_choices_half1,norg)
println("Standard deviation of MLE:",std_estimate_half1)

df_half1 = DataFrame(names = names_covariates,estimates = theta_estimate_half1,std = std_estimate_half1,num_trips = length(list_data_half1),num_venues = 1000)

println("MLE using one fifth of the trips")
@time rez_fifth1 = fit_mnl_newton(theta_init,list_data_fifth1,list_choices_fifth1,norg)
theta_estimate_fifth1 = Optim.minimizer(rez_fifth1)
println("True theta:",theta)
println("Estimator:",theta_estimate_fifth1)

std_estimate_fifth1 = std_mnl_newton(theta_estimate_fifth1,list_data_fifth1,list_choices_fifth1,norg)
println("Standard deviation of MLE:",std_estimate_fifth1)

df_fifth1 = DataFrame(names = names_covariates,estimates = theta_estimate_fifth1,std = std_estimate_fifth1,num_trips = length(list_data_fifth1),num_venues = 1000)

######################################
# 2) norg = 1, magnitude_error = 0.5
######################################

#Fixing the seed
srand(2)

norg = 1
J = 1000
magnitude_error = 0.5

data_venue = generate_data_venue(J)

list_choices_full2 = Array[]; list_data_full2 = Array[]
list_choices_half2 = Array[]; list_data_half2 = Array[]
list_choices_fifth2 = Array[]; list_data_fifth2 = Array[]

list_list_choices_full2 = Array[]; list_list_data_full2 = Array[]
list_list_choices_half2 = Array[]; list_list_data_half2 = Array[]
list_list_choices_fifth2 = Array[]; list_list_data_fifth2 = Array[]

for i in 1:I
  list_choices_full2_temp, list_data_full2_temp = DGP_norg_permanentshocks(norg,T,data_venue,i,disutility_distance,coeff_rating;magnitude_error = magnitude_error)

  list_choices_half2_temp = keep_obs(list_choices_full2_temp,0.5)
  list_data_half2_temp =   keep_obs(list_data_full2_temp,0.5)

  list_choices_fifth2_temp = keep_obs(list_choices_full2_temp,0.2)
  list_data_fifth2_temp =   keep_obs(list_data_full2_temp,0.2)

  list_choices_full2 = Array[list_choices_full2;list_choices_full2_temp];
  list_data_full2 = Array[list_data_full2;list_data_full2_temp];

  list_choices_half2=Array[list_choices_half2;list_choices_half2_temp];
  list_data_half2 = Array[list_data_half2;list_data_half2_temp];

  list_choices_fifth2 = Array[list_choices_fifth2;list_choices_fifth2_temp];
  list_data_fifth2 = Array[list_data_fifth2;list_data_fifth2_temp];

  list_list_choices_full2 = push!(list_list_choices_full2,list_choices_full2_temp);
  list_list_data_full2 = push!(list_list_data_full2,list_data_full2_temp);

  list_list_choices_half2=push!(list_list_choices_half2,list_choices_half2_temp)
  list_list_data_half2 = push!(list_list_data_half2,list_data_half2_temp);

  list_list_choices_fifth2=push!(list_list_choices_fifth2,list_choices_fifth2_temp)
  list_list_data_fifth2 = push!(list_list_data_fifth2,list_data_fifth2_temp);
end

println("MLE using all trips: T = ", T)
@time rez_full2 = fit_mnl_newton(theta_init,list_data_full2,list_choices_full2,norg)
theta_estimate_full2 = Optim.minimizer(rez_full2)
println("True theta:",theta)
println("Estimator:",theta_estimate_full2)

std_estimate_full2 = std_mnl_newton(theta_estimate_full2,list_data_full2,list_choices_full2,norg)
println("Standard deviation of MLE:",std_estimate_full2)

df_full2 = DataFrame(names = names_covariates,estimates = theta_estimate_full2,std = std_estimate_full2,num_trips = length(list_data_full2),num_venues=1000)

println("MLE using half of the trips")
@time rez_half2 = fit_mnl_newton(theta_init,list_data_half2,list_choices_half2,norg)
theta_estimate_half2 = Optim.minimizer(rez_half2)
println("True theta:",theta)
println("Estimator:",theta_estimate_half2)

std_estimate_half2 = std_mnl_newton(theta_estimate_half2,list_data_half2,list_choices_half2,norg)
println("Standard deviation of MLE:",std_estimate_half2)

df_half2 = DataFrame(names = names_covariates,estimates = theta_estimate_half2,std = std_estimate_half2,num_trips = length(list_data_half2),num_venues=1000)

println("MLE using one fifth of the trips")
@time rez_fifth2 = fit_mnl_newton(theta_init,list_data_fifth2,list_choices_fifth2,norg)
theta_estimate_fifth2 = Optim.minimizer(rez_fifth2)
println("True theta:",theta)
println("Estimator:",theta_estimate_fifth2)

std_estimate_fifth2 = std_mnl_newton(theta_estimate_fifth2,list_data_fifth2,list_choices_fifth2,norg)
println("Standard deviation of MLE:",std_estimate_fifth2)

df_fifth2 = DataFrame(names = names_covariates,estimates = theta_estimate_fifth2,std = std_estimate_fifth2,num_trips = length(list_data_fifth2),num_venues=1000)

########################################################################################################################################################################################################################################################
#  J = 11000 T = 40
########################################################################################################################################################################################################################################################

####################################
# 1) norg = 1, magnitude_error = 1
####################################

#Fixing the seed
srand(2)

norg = 1
J = 11000
magnitude_error = 1

data_venue = generate_data_venue(J)

list_choices_full3 = Array[]; list_data_full3 = Array[]
list_choices_half3 = Array[]; list_data_half3 = Array[]
list_choices_fifth3 = Array[]; list_data_fifth3 = Array[]

list_list_choices_full3 = Array[]; list_list_data_full3 = Array[]
list_list_choices_half3 = Array[]; list_list_data_half3 = Array[]
list_list_choices_fifth3 = Array[]; list_list_data_fifth3 = Array[]

for i in 1:I
  list_choices_full3_temp, list_data_full3_temp = DGP_norg_permanentshocks(norg,T,data_venue,i,disutility_distance,coeff_rating;magnitude_error = magnitude_error)

  list_choices_half3_temp = keep_obs(list_choices_full3_temp,0.5)
  list_data_half3_temp =   keep_obs(list_data_full3_temp,0.5)

  list_choices_fifth3_temp = keep_obs(list_choices_full3_temp,0.2)
  list_data_fifth3_temp =   keep_obs(list_data_full3_temp,0.2)

  list_choices_full3 = Array[list_choices_full3;list_choices_full3_temp];
  list_data_full3 = Array[list_data_full3;list_data_full3_temp];

  list_choices_half3=Array[list_choices_half3;list_choices_half3_temp];
  list_data_half3 = Array[list_data_half3;list_data_half3_temp];

  list_choices_fifth3 = Array[list_choices_fifth3;list_choices_fifth3_temp];
  list_data_fifth3 = Array[list_data_fifth3;list_data_fifth3_temp];

  list_list_choices_full3 = push!(list_list_choices_full3,list_choices_full3_temp);
  list_list_data_full3 = push!(list_list_data_full3,list_data_full3_temp);

  list_list_choices_half3=push!(list_list_choices_half3,list_choices_half3_temp)
  list_list_data_half3 = push!(list_list_data_half3,list_data_half3_temp);

  list_list_choices_fifth3=push!(list_list_choices_fifth3,list_choices_fifth3_temp)
  list_list_data_fifth3 = push!(list_list_data_fifth3,list_data_fifth3_temp);
end

println("MLE using all trips: T = ", T)
@time rez_full3 = fit_mnl_newton(theta_init,list_data_full3,list_choices_full3,norg)
theta_estimate_full3 = Optim.minimizer(rez_full3)
println("True theta:",theta)
println("Estimator:",theta_estimate_full3)

std_estimate_full3 = std_mnl_newton(theta_estimate_full3,list_data_full3,list_choices_full3,norg)
println("Standard deviation of MLE:",std_estimate_full3)

df_full3 = DataFrame(names = names_covariates,estimates = theta_estimate_full3,std = std_estimate_full3,num_trips = length(list_data_full3),num_venues=11000)

println("MLE using half of the trips")
@time rez_half3 = fit_mnl_newton(theta_init,list_data_half3,list_choices_half3,norg)
theta_estimate_half3 = Optim.minimizer(rez_half3)
println("True theta:",theta)
println("Estimator:",theta_estimate_half3)

std_estimate_half3 = std_mnl_newton(theta_estimate_half3,list_data_half3,list_choices_half3,norg)
println("Standard deviation of MLE:",std_estimate_half3)

df_half3 = DataFrame(names = names_covariates,estimates = theta_estimate_half3,std = std_estimate_half3,num_trips = length(list_data_half3),num_venues=11000)

println("MLE using one fifth of the trips")
@time rez_fifth3 = fit_mnl_newton(theta_init,list_data_fifth3,list_choices_fifth3,norg)
theta_estimate_fifth3 = Optim.minimizer(rez_fifth3)
println("True theta:",theta)
println("Estimator:",theta_estimate_fifth3)

std_estimate_fifth3 = std_mnl_newton(theta_estimate_fifth3,list_data_fifth3,list_choices_fifth3,norg)
println("Standard deviation of MLE:",std_estimate_fifth3)
df_fifth3 = DataFrame(names = names_covariates,estimates = theta_estimate_fifth3,std = std_estimate_fifth3,num_trips = length(list_data_fifth3),num_venues=11000)

#####################################################################################################################################################################################################
# Export results to Tex
######################################################################################################################################################################################################

#MLE for all
list_data_MLE = push!([],df_full1, df_half1,df_fifth1, df_full2, df_half2,df_fifth2, df_full3, df_half3,df_fifth3)
insert_colnames = repeat(String[L"a = 1, J = 1000";L"a = 0.5, J = 1000";L"a = 1, J = 11000"])
insert_sample_share = repeat(String["1";"1/2";"1/5"],outer=3)

convert_df_to_tex_multicol(list_data_MLE,names_covariates,insert_colnames,insert_sample_share,path_tables,"estimates_persistent_preferences_MLE.tex")
