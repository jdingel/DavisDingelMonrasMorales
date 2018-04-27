# Note: Please run the following commands sequentially to complete the task 
# 1) make import_bootstrap_estimates 
# 2) make or make all
# The error messages appearing after "make import_bootstrap_estimates" are innocuous and can be ignored.
# The command "make import_bootstrap_estimates" is necessary to generate some of the dependencies listed in the target "all".

###################
# PROGRAMS
###################

PROGS = compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl

############################
# INPUT
############################

estimates_mintime=\
	../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv \
	../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv \

estimates_mainspec=\
	../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv \
	../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv \

predictarray_mintime=\
	../input/estsample_predictarray/mintime/estsample_predictarray_whithisp_mintime.dta \
	../input/estsample_predictarray/mintime/estsample_predictarray_black_mintime.dta \
	../input/estsample_predictarray/mintime/estsample_predictarray_asian_mintime.dta \

predictarray_mainspec=\
	../input/estsample_predictarray/mainspec/estsample_predictarray_asian_sixom.dta \
	../input/estsample_predictarray/mainspec/estsample_predictarray_black_sixom.dta \
	../input/estsample_predictarray/mainspec/estsample_predictarray_whithisp_sixom.dta \

############################
# OUTPUT
############################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# Predicted visits
####################

predvisits_mainspec=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mainspec/black/predictedvisits_black_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predvisits_mainspec+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mainspec/asian/predictedvisits_asian_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predvisits_mainspec+=$(shell awk -F,  '{print $$5}' ../input/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mainspec/whithisp/predictedvisits_whithisp_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

predvisits_mintime=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mintime/black/predictedvisits_black_mintime_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predvisits_mintime+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mintime/asian/predictedvisits_asian_mintime_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predvisits_mintime+=$(shell awk -F,  '{print $$5}' ../input/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/mintime/whithisp/predictedvisits_whithisp_mintime_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predvisits_mintime) $(predvisits_mainspec)

import_bootstrap_estimates: $(folders_and_symlinks)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predvisits_mintime): $(PROGS) $(estimates_mintime) $(predictarray_mintime) predvisits_raceid_originmode_estsmp_bootstrap.jl predvisits_raceid_originmode_estsmp_bootstrap_mintime.sbatch
	sbatch -W predvisits_raceid_originmode_estsmp_bootstrap_mintime.sbatch

$(predvisits_mainspec): $(PROGS) $(estimates_mainspec) $(predictarray_mainspec) predvisits_raceid_originmode_estsmp_bootstrap.jl predvisits_raceid_originmode_estsmp_bootstrap_mainspec.sbatch
	sbatch -W predvisits_raceid_originmode_estsmp_bootstrap_mainspec.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
