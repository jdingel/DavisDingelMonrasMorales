###################
# PROGRAMS
###################

PROGS = compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl

######################
# INPUT
######################

estimates_sixom=\
	../input/estimates/sixom/socialchange_parameters_whithisp.csv \
	../input/estimates/sixom/socialchange_parameters_black.csv \
	../input/estimates/sixom/socialchange_parameters_asian.csv \
	../input/estimates/sixom/estimates_whithisp_mainspec.csv \
	../input/estimates/sixom/estimates_black_mainspec.csv \
	../input/estimates/sixom/estimates_asian_mainspec.csv

JLDs=\
	../input/JLDs/venues.jld \
	../input/JLDs/top_workplaces_5.jld \
	../input/JLDs/geoid11_work_pair_slowdown.jld \
	../input/JLDs/geoid11_work_pair_2ndAve.jld \
	../input/JLDs/geoid11.jld \
	../input/JLDs/geoid11_home_work_slowdown.jld \
	../input/JLDs/geoid11_home_work_2ndAve.jld \
	../input/JLDs/geoid11_home_pair_slowdown.jld \
	../input/JLDs/geoid11_home_pair_2ndAve.jld \
	../input/JLDs/geoid11_home.jld

predictedvisitsarray_2ndAve=$(shell seq 1 2103|awk '$$0="../input/predictedvisitsarray/2ndAve/predvisitarray_"$$0'| awk '$$0=$$0"_2ndAve.jld"'|tr "\n" " ")

predictedvisitsarray_slowdown=$(shell seq 1 2103|awk '$$0="../input/predictedvisitsarray/slowdown/predvisitarray_"$$0'| awk '$$0=$$0"_slowdown.jld"'|tr "\n" " ")

predictedvisitsarray_socialchange=$(shell seq 1 2103|awk '$$0="../input/predictedvisitsarray/socialchange/predvisitarray_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

######################
# OUTPUT
######################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# Predicted visits
####################

predictedvisits_cftl =\
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_mainspec_slowdown.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec_2ndAve.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec_slowdown.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec_socialchange.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec_2ndAve.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec_socialchange.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_mainspec_socialchange.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_mainspec_2ndAve.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec_slowdown.jld

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits_cftl)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predictedvisits_cftl): $(PROGS) $(estimates_sixom) $(JLDs) $(predictedvisitsarray_2ndAve) $(predictedvisitsarray_slowdown) $(predictedvisitsarray_socialchange) predvisits_raceid_originmode_specification_cftl.jl predvisits_raceid_originmode_specification_cftl.sbatch
	sbatch -W predvisits_raceid_originmode_specification_cftl.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
