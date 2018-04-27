## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames
using LaTeXStrings
using Distributions
using CSV

#Imported functions
include("tables_functions_FE.jl")

#Path
path_input_sixom = "../output/estimates/sixom/"
path_output_sixom = "../output/tables/sixom/"

path_input_mintime = "../output/estimates/mintime/"
path_output_mintime = "../output/tables/mintime/"

##################################
# Covariates to be shown in table
##################################

tab_venueFE_sixom_spec = ["time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"; "eucl_demo_distance"; "eucl_demo_distance_ssi"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"]

tab_venueFE_mintime_spec = ["time_minimum_log"; "eucl_demo_distance"; "eucl_demo_distance_ssi"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"]

###############
# Tables
###############

#Table FE sixom
gen_standard_tab_FE(6,path_input_sixom,path_output_sixom,"sixom",tab_venueFE_sixom_spec,"tab_venueFE_sixom";report_norg=0)

#Table FE mintime
gen_standard_tab_FE(1,path_input_mintime,path_output_mintime,"mintime",tab_venueFE_mintime_spec,"tab_venueFE_mintime";report_norg=0)
