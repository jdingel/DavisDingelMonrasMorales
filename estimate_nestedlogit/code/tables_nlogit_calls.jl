## Author: Kevin Dano
## Julia version: 0.6.2
## Note: nest1 = "Area-cuisine-rating nests", nest 2 = "Tract-cuisine-price nests"

######################
# Computing resources
#####################

#Packages
using DataFrames
using LaTeXStrings
using Distributions
using CSV

#Imported functions
include("tables_nlogit_functions.jl")

#Path
path_input_sixom = "../output/estimates/sixom/"
path_output_sixom = "../output/tables/sixom/"
path_input_H0_sixom = "../input/estimates/sixom/"

path_input_mintime = "../output/estimates/mintime/"
path_output_mintime = "../output/tables/mintime/"
path_input_H0_mintime = "../input/estimates/mintime/"

##################################
# Covariates to be shown in table
##################################

#covariates shown in mainspec
tab_mintime_spec = ["lambda";"time_minimum_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]

tab_sixom_spec = ["lambda";"time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]

###############
# Tables
###############

#Nested logit table for mintime specification
gen_tab_ABW_ABW_nlogit(path_input_mintime,path_input_H0_mintime,path_output_mintime,"nlogit_nested1","nlogit_nested2","mainspec","Area-cuisine-rating nests","Tract-cuisine-price nests",tab_mintime_spec,"tab_nlogit";add_missing_cov=0,multicol_titles=1,report_norg=0)

#Nested logit table for sixom specification
gen_tab_ABW_ABW_nlogit(path_input_sixom,path_input_H0_sixom,path_output_sixom,"nlogit_nested1","nlogit_nested2","mainspec","Area-cuisine-rating nests","Tract-cuisine-price nests",tab_sixom_spec,"tab_nlogit";add_missing_cov=0,multicol_titles=1,report_norg=0)
