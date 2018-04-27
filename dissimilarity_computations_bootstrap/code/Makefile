# Note: Please run the following commands sequentially to complete the task 
# 1) make import_bootstrap_estimates 
# 2) make or make all
# The error messages appearing after "make import_bootstrap_estimates" are innocuous and can be ignored.
# The command "make import_bootstrap_estimates" is necessary to generate some of the dependencies listed in the target "all".

#####################
# PROGRAMS
#####################

PROGS= \
	dissimilarity_functions.jl \
	general_functions.jl

#########################
# INPUT
#########################

JLDs=../input/tract_2010_characteristics_est.dta

estimates_mainspec=\
	../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv

estimates_mintime=\
	../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv

predictedvisits_mainspec1=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec1+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec1+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mainspec2=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec2+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec2+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mainspec3=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec3+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec3+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mainspec4=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec4+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec4+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mainspec5=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec5+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mainspec5+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mintime1=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime1+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime1+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mintime2=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime2+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime2+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mintime3=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime3+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime3+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mintime4=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime4+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime4+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predictedvisits_mintime5=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime5+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_mintime5+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

#########################
# OUTPUT
#########################

folders_and_symlinks=create_folders_and_symlinks.txt

#####################
# slurm files
#####################

slurm_files=$(shell seq 1 5|awk '$$0="run_array_dissim_mainspec_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_dissim_mintime_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")

#####################
# Predicted visits
#####################

#Mainspec
dissim_mainspec1= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mainspec/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mainspec/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")

dissim_mainspec2= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mainspec/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mainspec/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")

dissim_mainspec3= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mainspec/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mainspec/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")

dissim_mainspec4= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mainspec/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mainspec/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")

dissim_mainspec5= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mainspec/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mainspec/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")
dissim_mainspec5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mainspec/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mainspec.csv"'| tr "\n" " ")

#Mintime
dissim_mintime1= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mintime/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mintime/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime1+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")

dissim_mintime2= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mintime/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mintime/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime2+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")

dissim_mintime3= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mintime/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mintime/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime3+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")

dissim_mintime4= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mintime/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mintime/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime4+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")

dissim_mintime5= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mintime/dissimilarity_index_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_venue_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mintime/dissimilarity_index_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")
dissim_mintime5+= $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0= "../output/mintime/dissimilarity_index_pairwise_tract_level_instance"$$0'|awk '$$0=$$0"_mintime.csv"'| tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(slurm_files) $(dissim_mainspec1) $(dissim_mainspec2) $(dissim_mainspec3) $(dissim_mainspec4) $(dissim_mainspec5) \
	$(dissim_mintime1) $(dissim_mintime2) $(dissim_mintime3) $(dissim_mintime4) $(dissim_mintime5)

import_bootstrap_estimates: $(folders_and_symlinks)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(slurm_files): gen_array_jobs.sh
	-bash gen_array_jobs.sh

$(dissim_mainspec1): $(PROGS) $(JLDs) $(estimates_mainspec) $(predictedvisits_mainspec1) dissimilarity_bootstrap.jl run_array_dissim_mainspec_1.sbatch
	sbatch -W run_array_dissim_mainspec_1.sbatch

$(dissim_mainspec2): $(PROGS) $(JLDs) $(estimates_mainspec) $(predictedvisits_mainspec2) dissimilarity_bootstrap.jl run_array_dissim_mainspec_2.sbatch
	sbatch -W run_array_dissim_mainspec_2.sbatch

$(dissim_mainspec3): $(PROGS) $(JLDs) $(estimates_mainspec) $(predictedvisits_mainspec3) dissimilarity_bootstrap.jl run_array_dissim_mainspec_3.sbatch
	sbatch -W run_array_dissim_mainspec_3.sbatch

$(dissim_mainspec4): $(PROGS) $(JLDs) $(estimates_mainspec) $(predictedvisits_mainspec4) dissimilarity_bootstrap.jl run_array_dissim_mainspec_4.sbatch
	sbatch -W run_array_dissim_mainspec_4.sbatch

$(dissim_mainspec5): $(PROGS) $(JLDs) $(estimates_mainspec) $(predictedvisits_mainspec5) dissimilarity_bootstrap.jl run_array_dissim_mainspec_5.sbatch
	sbatch -W run_array_dissim_mainspec_5.sbatch

$(dissim_mintime1): $(PROGS) $(JLDs) $(estimates_mintime) $(predictedvisits_mintime1) dissimilarity_bootstrap.jl run_array_dissim_mintime_1.sbatch
	sbatch -W run_array_dissim_mintime_1.sbatch

$(dissim_mintime2): $(PROGS) $(JLDs) $(estimates_mintime) $(predictedvisits_mintime2) dissimilarity_bootstrap.jl run_array_dissim_mintime_2.sbatch
	sbatch -W run_array_dissim_mintime_2.sbatch

$(dissim_mintime3): $(PROGS) $(JLDs) $(estimates_mintime) $(predictedvisits_mintime3) dissimilarity_bootstrap.jl run_array_dissim_mintime_3.sbatch
	sbatch -W run_array_dissim_mintime_3.sbatch

$(dissim_mintime4): $(PROGS) $(JLDs) $(estimates_mintime) $(predictedvisits_mintime4) dissimilarity_bootstrap.jl run_array_dissim_mintime_4.sbatch
	sbatch -W run_array_dissim_mintime_4.sbatch

$(dissim_mintime5): $(PROGS) $(JLDs) $(estimates_mintime) $(predictedvisits_mintime5) dissimilarity_bootstrap.jl run_array_dissim_mintime_5.sbatch
	sbatch -W run_array_dissim_mintime_5.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
