## Author: Kevin Dano
## Julia version: 0.6.2

######################
# Computing resources
#####################

#Packages
using DataFrames, LaTeXStrings, Distributions, CSV

#Imported functions
include("tables_functions_Taddy.jl")

#Path
path_input = "../output/estimates/"
path_output = "../output/tables/"

##########################
# Functions
##########################

##################################
# Covariates to be shown in table
##################################

#covariates shown in Table 3
tab_Taddy_spec = ["time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"; "eucl_demo_distance"; "eucl_demo_distance_ssi"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"]

###############
# Tables
###############

#Table homeonly
gen_Taddy_tab(path_input,path_output,tab_Taddy_spec,"table_Taddy")
