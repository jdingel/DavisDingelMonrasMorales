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
include("table_gentrification_function.jl")
include("compute_predvisits_racespecific_functions.jl")

#Path
path_predictedvisits= "../output/predictedvisits/"
path_input1 = "../input/"
path_JLDs = "../output/JLDs/"
path_estimates = "../input/estimates/"
path_predvisitarray_truevalue = "../input/predvisitsarray/"
path_predvisitarray_gentrified = "../output/predvisitsarray/"
path_tables = "../output/tables/"


for (tract_geoid11,tract_name) in zip([36061022400;36047029300],["Harlem";"Bedstuy"])

#########################
# Prepare initial data
#########################

df_truevalue = CSV.read(string(path_predictedvisits,"predictedvisits_black_",tract_name,"_truevalue.csv"),allowmissing=:none,weakrefstrings=false)
df_truevalue[:welfare_truevalue] = log.(df_truevalue[:denom_prob_visit_venue])
sort!(df_truevalue,cols=[order(:userid_num),order(:venue_num)])

df_gentrified = CSV.read(string(path_predictedvisits,"predictedvisits_black_",tract_name,"_gentrificationscenario.csv"),allowmissing=:none,weakrefstrings=false)
df_gentrified[:welfare_gentrified]= log.(df_gentrified[:denom_prob_visit_venue])
sort!(df_gentrified,cols=[order(:userid_num),order(:venue_num)])

df = hcat(df_truevalue,DataFrame(welfare_gentrified =df_gentrified[:welfare_gentrified]))
top_5_workplaces = load(string(path_input1,"top_workplaces_5.jld"))["data"]
tract_num = convert(Array{Int},unique(top_5_workplaces[top_5_workplaces[:geoid11_home].==tract_geoid11,:geoid11_home_num]))[1]
top_5_workplaces = top_5_workplaces[:,[:geoid11_home;:geoid11_work;:share]]

df = join(df,top_5_workplaces,on = [:geoid11_home;:geoid11_work])

df_venues = load(string(path_JLDs,"venues_",tract_name,".jld"))["data_venues"]
venues_treated = convert(Array{Int},unique(df_venues[df_venues[:treat].==1,:venue_num])) #treated venues
venues_untreated = convert(Array{Int},unique(df_venues[df_venues[:treat].==0,:venue_num]))

#########################
#1) Initial visit share
#########################

df_initial_visit_share = copy(df[findin(df[:venue_num],venues_treated),:])
df_initial_visit_share = by(df_initial_visit_share,[:userid_num;:geoid11_home;:geoid11_work],data->DataFrame(initial_visit_share = sum(data[:prob_visit_venue])))
df_initial_visit_share = join(df_initial_visit_share,top_5_workplaces,on=[:geoid11_home;:geoid11_work])
df_initial_visit_share[:temp]=1
df_initial_visit_share = by(df_initial_visit_share,:temp,data->DataFrame(
initial_visit_share = sum(data[:initial_visit_share].*data[:share])./sum(data[:share])
))

#################################################
#2) Change in value of restaurant characteristics
##################################################

#Need to get the predicted visits array
data_estimates = CSV.read(string(path_estimates,"estimates_","black","_mainspec.csv"),allowmissing=:none,weakrefstrings=false)
keep_cols = [:userid_num;:venue_num;:geoid11_home;:geoid11_work]

data_predvisitarray_truevalue = load(string(path_predvisitarray_truevalue,"predvisitarray_",tract_num,".jld"))["predvisitarray"]
data_predvisitarray_gentrified = load(string(path_predvisitarray_gentrified,"predvisitarray_","black","_",tract_name,"_gentrificationscenario.jld"))["predvisitarray"]

df_change = copy(data_predvisitarray_truevalue[:,keep_cols])
df_change[:social_change] = 0.0
df_change[:restaurant_traits_change] = 0.0
df_change[:other_traits_change] = 0.0

#Change in social frictions
covariates_social = ["eucl_demo_distance","spectralsegregationindex","eucl_demo_distance_ssi","asian_percent","black_percent","hispanic_percent","other_percent"]
theta_social = extract_estimates(data_estimates,covariates_social)
covariates_social = map(i->Symbol(i),covariates_social)

for i in 1:length(covariates_social)
  name_covar = covariates_social[i]
  temp = (data_predvisitarray_gentrified[name_covar]-data_predvisitarray_truevalue[name_covar]).*theta_social[i]
  df_change[:social_change] = df_change[:social_change]+temp
end

#Change in restaurant traits
covariates_restaurant_traits = ["d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"]
theta_restaurant_traits = extract_estimates(data_estimates,covariates_restaurant_traits)
covariates_restaurant_traits = map(i->Symbol(i),covariates_restaurant_traits)

for i in 1:length(covariates_restaurant_traits)
  name_covar = covariates_restaurant_traits[i]
  temp = (data_predvisitarray_gentrified[name_covar]-data_predvisitarray_truevalue[name_covar]).*theta_restaurant_traits[i]
  df_change[:restaurant_traits_change] = df_change[:restaurant_traits_change]+temp
end

#Change in other traits
covariates_other_traits = ["median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]
theta_other_traits = extract_estimates(data_estimates,covariates_other_traits)
covariates_other_traits = map(i->Symbol(i),covariates_other_traits)

for i in 1:length(covariates_other_traits)
  name_covar = covariates_other_traits[i]
  temp = (data_predvisitarray_gentrified[name_covar]-data_predvisitarray_truevalue[name_covar]).*theta_other_traits[i]
  df_change[:other_traits_change] = df_change[:other_traits_change]+temp
end

df_change = df_change[findin(df_change[:venue_num],venues_treated),:]
df_change[:temp]=1

df_change = by(df_change,:temp,data->DataFrame(
social_change = mean(data[:social_change]),
restaurant_traits_change = mean(data[:restaurant_traits_change]),
other_traits_change = mean(data[:other_traits_change])
))

###############################################
# 3) Equivalent percentage increase in minutes
################################################

df_delta = CSV.read(string(path_predictedvisits,"equiv_percentage_increase_minutes_time_home_",tract_name,".csv"),allowmissing=:none,weakrefstrings=false)
df_delta = join(df_delta,top_5_workplaces,on=[:geoid11_home;:geoid11_work])
df_delta[:temp]=1
df_delta = by(df_delta,:temp,data->DataFrame(
delta_percent = sum(data[:delta_percent].*data[:share])./sum(data[:share])
))

df_final = join(df_delta,df_initial_visit_share,on=:temp)
df_final = join(df_final,df_change,on=:temp)

#Export table
gentrification_tex_table(df_final,path_tables,string("table_gentrification_",tract_name,".tex"))

end
