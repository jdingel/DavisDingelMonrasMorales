# Note: Please run the following commands sequentially to complete the task 
# 1) make import_bootstrap_estimates 
# 2) make or make all
# The error messages appearing after "make import_bootstrap_estimates" are innocuous and can be ignored.
# The command "make import_bootstrap_estimates" is necessary to generate some of the dependencies listed in the target "all".

#####################
# PROGRAMS
#####################

PROGS = \
	compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl

######################
# INPUT
######################

estimates_mainspec=\
	../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv

estimates_mintime=\
	../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv

JLDs=../input/JLDs/top_workplaces_5.jld

predvisitsarray = $(shell seq 1 2103|awk '$$0="../input/predictedvisitsarray/predvisitarray_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

######################
# OUTPUT
######################

folders_and_symlinks=create_folders_and_symlinks.txt

#####################
# slurm files
#####################

slurm_files=$(shell seq 1 5|awk '$$0="run_array_black_mainspec_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_asian_mainspec_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_whithisp_mainspec_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_black_mintime_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_asian_mintime_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")
slurm_files+=$(shell seq 1 5|awk '$$0="run_array_whithisp_mintime_"$$0'| awk '$$0=$$0".sbatch"'|tr "\n" " ")

#####################
# Predicted visits
#####################

predvisits_black_mainspec_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mainspec_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mainspec_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mainspec_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mainspec_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_black_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predvisits_asian_mainspec_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mainspec_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mainspec_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mainspec_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mainspec_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_asian_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predvisits_whithisp_mainspec_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mainspec_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mainspec_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mainspec_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mainspec_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mainspec/predictedvisits_collapsed_over_workplace_whithisp_mainspec_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predvisits_black_mintime_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mintime_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mintime_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mintime_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_black_mintime_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predvisits_asian_mintime_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mintime_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mintime_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mintime_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_asian_mintime_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

predvisits_whithisp_mintime_1 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,100p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mintime_2 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 101,200p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mintime_3 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 201,300p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mintime_4 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 301,400p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predvisits_whithisp_mintime_5 = $(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 401,500p| awk '$$0 = "../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_instance"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(slurm_files) $(predvisits_black_mainspec_1) $(predvisits_black_mainspec_2) $(predvisits_black_mainspec_3) $(predvisits_black_mainspec_4) $(predvisits_black_mainspec_5) \
	$(predvisits_asian_mainspec_1) $(predvisits_asian_mainspec_2) $(predvisits_asian_mainspec_3) $(predvisits_asian_mainspec_4) $(predvisits_asian_mainspec_5) \
	$(predvisits_whithisp_mainspec_1) $(predvisits_whithisp_mainspec_2) $(predvisits_whithisp_mainspec_3) $(predvisits_whithisp_mainspec_4) $(predvisits_whithisp_mainspec_5) \
	$(predvisits_black_mintime_1) $(predvisits_black_mintime_2) $(predvisits_black_mintime_3) $(predvisits_black_mintime_4) $(predvisits_black_mintime_5)\
	$(predvisits_asian_mintime_1) $(predvisits_asian_mintime_2) $(predvisits_asian_mintime_3) $(predvisits_asian_mintime_4) $(predvisits_asian_mintime_5) \
	$(predvisits_whithisp_mintime_1) $(predvisits_whithisp_mintime_2) $(predvisits_whithisp_mintime_3) $(predvisits_whithisp_mintime_4) $(predvisits_whithisp_mintime_5)

import_bootstrap_estimates: $(folders_and_symlinks)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(slurm_files): gen_array_jobs.sh
	-bash gen_array_jobs.sh

$(predvisits_black_mainspec_1): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mainspec_1.sbatch
	sbatch -W run_array_black_mainspec_1.sbatch

$(predvisits_black_mainspec_2): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mainspec_2.sbatch
	sbatch -W run_array_black_mainspec_2.sbatch

$(predvisits_black_mainspec_3): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mainspec_3.sbatch
	sbatch -W run_array_black_mainspec_3.sbatch

$(predvisits_black_mainspec_4): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mainspec_4.sbatch
	sbatch -W run_array_black_mainspec_4.sbatch

$(predvisits_black_mainspec_5): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mainspec_5.sbatch
	sbatch -W run_array_black_mainspec_5.sbatch

$(predvisits_asian_mainspec_1): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mainspec_1.sbatch
	sbatch -W run_array_asian_mainspec_1.sbatch

$(predvisits_asian_mainspec_2): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mainspec_2.sbatch
	sbatch -W run_array_asian_mainspec_2.sbatch

$(predvisits_asian_mainspec_3): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mainspec_3.sbatch
	sbatch -W run_array_asian_mainspec_3.sbatch

$(predvisits_asian_mainspec_4): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mainspec_4.sbatch
	sbatch -W run_array_asian_mainspec_4.sbatch

$(predvisits_asian_mainspec_5): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mainspec_5.sbatch
	sbatch -W run_array_asian_mainspec_5.sbatch

$(predvisits_whithisp_mainspec_1): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mainspec_1.sbatch
	sbatch -W run_array_whithisp_mainspec_1.sbatch

$(predvisits_whithisp_mainspec_2): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mainspec_2.sbatch
	sbatch -W run_array_whithisp_mainspec_2.sbatch

$(predvisits_whithisp_mainspec_3): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mainspec_3.sbatch
	sbatch -W run_array_whithisp_mainspec_3.sbatch

$(predvisits_whithisp_mainspec_4): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mainspec_4.sbatch
	sbatch -W run_array_whithisp_mainspec_4.sbatch

$(predvisits_whithisp_mainspec_5): $(PROGS) $(estimates_mainspec) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mainspec_5.sbatch
	sbatch -W run_array_whithisp_mainspec_5.sbatch

$(predvisits_black_mintime_1): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mintime_1.sbatch
	sbatch -W run_array_black_mintime_1.sbatch

$(predvisits_black_mintime_2): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mintime_2.sbatch
	sbatch -W run_array_black_mintime_2.sbatch

$(predvisits_black_mintime_3): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mintime_3.sbatch
	sbatch -W run_array_black_mintime_3.sbatch

$(predvisits_black_mintime_4): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mintime_4.sbatch
	sbatch -W run_array_black_mintime_4.sbatch

$(predvisits_black_mintime_5): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_black_mintime_5.sbatch
	sbatch -W run_array_black_mintime_5.sbatch

$(predvisits_asian_mintime_1): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mintime_1.sbatch
	sbatch -W run_array_asian_mintime_1.sbatch

$(predvisits_asian_mintime_2): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mintime_2.sbatch
	sbatch -W run_array_asian_mintime_2.sbatch

$(predvisits_asian_mintime_3): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mintime_3.sbatch
	sbatch -W run_array_asian_mintime_3.sbatch

$(predvisits_asian_mintime_4): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mintime_4.sbatch
	sbatch -W run_array_asian_mintime_4.sbatch

$(predvisits_asian_mintime_5): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_asian_mintime_5.sbatch
	sbatch -W run_array_asian_mintime_5.sbatch

$(predvisits_whithisp_mintime_1): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mintime_1.sbatch
	sbatch -W run_array_whithisp_mintime_1.sbatch

$(predvisits_whithisp_mintime_2): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mintime_2.sbatch
	sbatch -W run_array_whithisp_mintime_2.sbatch

$(predvisits_whithisp_mintime_3): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mintime_3.sbatch
	sbatch -W run_array_whithisp_mintime_3.sbatch

$(predvisits_whithisp_mintime_4): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mintime_4.sbatch
	sbatch -W run_array_whithisp_mintime_4.sbatch

$(predvisits_whithisp_mintime_5): $(PROGS) $(estimates_mintime) $(JLDs) $(predvisitsarray) predvisits_bootstrap.jl run_array_whithisp_mintime_5.sbatch
	sbatch -W run_array_whithisp_mintime_5.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
