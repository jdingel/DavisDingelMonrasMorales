## Author:  Kevin Dano
## Julia version: 0.6.2
## Note: Please edit path_input and path_output

######################
# Computing resources
#####################

#Packages
using DataFrames, LaTeXStrings, Distributions, CSV

#Imported functions
include("tables_functions.jl")

#Path
path_input_sixom = "../output/estimates/sixom/"
path_output_sixom = "../output/tables/sixom/"

path_input_norg = "../output/estimates/norg/"
path_output_norg = "../output/tables/norg/"

path_input_mintime = "../output/estimates/mintime/"
path_output_mintime = "../output/tables/mintime/"

##################################
# Covariates to be shown in table
##################################

#covariates shown in mainspec
tab_mainspec = ["time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]

tab_spatial = ["time_public_home_log", "time_car_home_log", "time_public_work_log", "time_car_work_log", "time_public_path_log", "time_car_path_log", "d_price_2", "d_price_3", "d_price_4", "avgrating", "d_cuisine_1", "d_cuisine_2", "d_cuisine_3", "d_cuisine_4", "d_cuisine_5", "d_cuisine_6", "d_cuisine_7", "d_cuisine_9", "d_price_2_income", "d_price_3_income", "d_price_4_income", "avgrating_income", "median_income_percent_difference", "med_income_perc_diff_signed","median_income_log"]

tab_mintime_spec =  ["time_minimum_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]

tab_robustnesschecks_sixom = ["time_public_home_log"; "time_car_home_log"; "time_public_work_log"; "time_car_work_log"; "time_public_path_log"; "time_car_path_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"; "chain"; "reviews_log"; "vehicle_avail_hhshare_diff"]

tab_robustnesschecks_mintime = ["time_minimum_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"; "chain"; "reviews_log"; "vehicle_avail_hhshare_diff"]

tab_spatialfrictionsinteracted = ["time_public_home_log";"time_car_home_log";"time_public_work_log";"time_car_work_log";"time_public_path_log";"time_car_path_log";"time_public_home_log_21to39";"time_car_home_log_21to39";"time_public_work_log_21to39";"time_car_work_log_21to39";"time_public_path_log_21to39";"time_car_path_log_21to39";"time_public_home_log_income";"time_car_home_log_income";"time_public_work_log_income";"time_car_work_log_income";"time_public_path_log_income";"time_car_path_log_income";"time_public_home_log_female";"time_car_home_log_female";"time_public_work_log_female";"time_car_work_log_female";"time_public_path_log_female";"time_car_path_log_female";"eucl_demo_distance";"spectralsegregationindex";"eucl_demo_distance_ssi";"asian_percent";"black_percent";"hispanic_percent";"other_percent"]

#covariates homeonly
homeonly_spec = ["time_public_home_log"; "time_car_home_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"; "d_price_2"; "d_price_3"; "d_price_4"; "avgrating"; "d_cuisine_1"; "d_cuisine_2"; "d_cuisine_3"; "d_cuisine_4"; "d_cuisine_5"; "d_cuisine_6"; "d_cuisine_7"; "d_cuisine_9"; "d_price_2_income"; "d_price_3_income"; "d_price_4_income"; "avgrating_income"; "median_income_percent_difference"; "med_income_perc_diff_signed"; "median_income_log"; "robberies_0711_perres"]

#origin-mode-specific intercepts
omintercepts_spec = ["time_public_home_log"; "intercept_public_home";"time_car_home_log";"intercept_car_home"; "time_public_work_log"; "intercept_public_work";;"time_car_work_log"; "intercept_car_work";"time_public_path_log"; "intercept_public_path";"time_car_path_log"; "eucl_demo_distance"; "spectralsegregationindex"; "eucl_demo_distance_ssi"; "asian_percent"; "black_percent"; "hispanic_percent"; "other_percent"]

###############
# Tables
###############

#spatial frictions + social frictions tables
gen_tab_ABW_ABW(path_input_norg,path_input_sixom,path_output_sixom,"spatial6","mainspec","","",tab_mainspec,"tab_nosocial_and_mainspec";add_missing_cov=1,multicol_titles=0,report_norg=0,label="alt")

#Produce race-specific tables with many columns
list_specs = ["mainspec","50","100","half","fifth","locainfo1","locainfo2","lateadopt","droploca","disaggcuis","carshare","revchain"]
list_colnames = ["Main spec","Choice 50","Choice 100","Half","Fifth","Locainfo1","Locainfo2","Late adopt","Droploca","Disagg cuisine","Cars","Chains"]

list_norg_sixom = repeat([6],inner=12) #sixom
for race in ["black","asian","whithisp"]
  gen_tab_racespecific_robustnesschecks(path_input_sixom,path_output_sixom,race,list_specs,list_colnames,list_norg_sixom,tab_robustnesschecks_sixom,string("tab_robustnesschecks_",race,"_sixom");report_norg=0)
end

##Split the robustness checks across two tables
list_specs1 = ["mainspec","50","100","half","fifth","droploca"]
list_specs2 = ["mainspec","locainfo1","locainfo2","lateadopt","disaggcuis","carshare","revchain"]

#Sixom
list_cols1 = ["Main spec","Choice 50","Choice 100","Half","Fifth","Droploca"]
list_cols2 = ["Main spec", "Locainfo1","Locainfo2","Late adopt","Disagg cuisine","Cars","Chains"]
list_norg_sixom1 = repeat([6],inner=6)
list_norg_sixom2 = repeat([6],inner=7)

for race in ["black","whithisp","asian"]
  gen_tab_racespecific_robustnesschecks(path_input_sixom,path_output_sixom,race,list_specs1,list_cols1,list_norg_sixom1,tab_mainspec,string("tab_robustnesschecks1_",race,"_sixom");report_norg=0)
  gen_tab_racespecific_robustnesschecks(path_input_sixom,path_output_sixom,race,list_specs2,list_cols2,list_norg_sixom2,tab_robustnesschecks_sixom,string("tab_robustnesschecks2_",race,"_sixom");report_norg=0)
end
  gen_tab_racespecific_robustnesschecks(path_input_sixom,path_output_sixom,"asian",list_specs1,list_cols1,list_norg_sixom1,tab_mainspec,string("tab_robustnesschecks1_","asian","_sixom");report_norg=0)

#Mintime
list_norg_mintime = repeat([1],inner=12) #mintime
for race in ["black","asian","whithisp"]
  gen_tab_racespecific_robustnesschecks(path_input_mintime,path_output_mintime,race,list_specs,list_colnames,list_norg_mintime,tab_robustnesschecks_mintime,string("tab_robustnesschecks_",race,"_mintime");report_norg=0)
end

list_cols1 = ["Mintime","Choice 50","Choice 100","Half","Fifth","Droploca"]
list_cols2 = ["Mintime", "Locainfo1","Locainfo2","Late adopt","Disagg cuisine","Cars","Chains"]
list_norg_mintime1 = repeat([1],inner=6)
list_norg_mintime2 = repeat([1],inner=7)

for race in ["black","asian","whithisp"]
  gen_tab_racespecific_robustnesschecks(path_input_mintime,path_output_mintime,race,list_specs1,list_cols1,list_norg_mintime1,tab_mintime_spec,string("tab_robustnesschecks1_",race,"_mintime");report_norg=0)
  gen_tab_racespecific_robustnesschecks(path_input_mintime,path_output_mintime,race,list_specs2,list_cols2,list_norg_mintime2,tab_robustnesschecks_mintime,string("tab_robustnesschecks2_",race,"_mintime");report_norg=0)
end

#Table with interactions of spatial frictions
gen_tab_spatialfrictionsinteracted(path_input_sixom,path_output_sixom,tab_spatialfrictionsinteracted,"table_spatialfrictions_robustness";report_norg=0)

#Table for homeonlysample and homeonly
gen_tab_ABW_ABW(path_input_norg,path_input_norg,path_output_norg,"homeonlysample","homeonly","Home only sample","Estimation sample",homeonly_spec,"table_homeonlysample_homeonly";report_norg=0)

#Table with origin-mode-specific
gen_standard_tab(path_input_sixom,path_output_sixom,omintercepts_spec,"omintercepts","tab_omintercepts",6;report_norg=0)

##Specification employing only tract-level covariates
gen_tab_raceblind(path_input_sixom,path_output_sixom,"estimates_raceblind.csv",tab_mainspec,"tab_raceblind",6;report_norg=0)

##Table 2: Travel Time
gen_tab_ABW_ABW_ABW(path_input_norg,path_output_norg,["spatial2","spatial4","spatial6"],["";"";""],[2;4;6],tab_spatial,"table_spatialfrictionsonly";add_missing_cov=1,multicol_titles=0)
