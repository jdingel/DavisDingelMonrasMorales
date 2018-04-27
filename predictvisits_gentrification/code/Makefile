####################
# PROGRAMS
####################

PROGS = \
	compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	gen_array_predvisits_racespecific_functions.jl \
	general_functions.jl

#####################
# INPUT
#####################

DTA_input=\
	../input/venues_Harlem.dta \
	../input/venues_Bedstuy.dta \
	../input/tracts_Harlem.dta \
	../input/tracts_Bedstuy.dta \
	../input/tractpairs_Harlem.dta \
	../input/tractpairs_Bedstuy.dta \
	../input/gentrify_avgcovars_Harlem.dta \
	../input/gentrify_avgcovars_Bedstuy.dta \

JLD_input=\
	../input/venues.jld \
	../input/top_workplaces_5.jld \
	../input/geoid11_work_pair.jld \
	../input/geoid11_home_work.jld \
	../input/geoid11_home_pair.jld \
	../input/geoid11_home.jld \
	../input/geoid11.jld \

estimates=../input/estimates/estimates_black_mainspec.csv

predvisitsarray=$(shell seq 1 2103|awk '$$0="../input/predvisitsarray/predvisitarray_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

#####################
# OUTPUT
#####################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs = \
	../output/JLDs/geoid11_home_work_Bedstuy.jld \
	../output/JLDs/geoid11_work_pair_Bedstuy.jld \
	../output/JLDs/geoid11_home_pair_Bedstuy.jld \
	../output/JLDs/geoid11_home_Bedstuy.jld \
	../output/JLDs/geoid11_Bedstuy.jld \
	../output/JLDs/venues_Bedstuy.jld \
	../output/JLDs/geoid11_home_work_Harlem.jld \
	../output/JLDs/geoid11_work_pair_Harlem.jld \
	../output/JLDs/geoid11_home_pair_Harlem.jld \
	../output/JLDs/geoid11_home_Harlem.jld \
	../output/JLDs/geoid11_Harlem.jld \
	../output/JLDs/venues_Harlem.jld

##########################################
# Predictedvisits array + predictedvisits
##########################################

predvisits = \
	../output/predvisitsarray/predvisitarray_black_Bedstuy_gentrificationscenario.jld \
	../output/predvisitsarray/predvisitarray_black_Harlem_gentrificationscenario.jld \
	../output/predictedvisits/predictedvisits_black_Bedstuy_gentrificationscenario.csv \
	../output/predictedvisits/predictedvisits_black_Harlem_gentrificationscenario.csv \
	../output/predictedvisits/predictedvisits_black_Bedstuy_truevalue.csv \
	../output/predictedvisits/predictedvisits_black_Harlem_truevalue.csv

####################
# Delta
####################

delta = \
	../output/predictedvisits/equiv_percentage_increase_minutes_time_home_Bedstuy.csv \
	../output/predictedvisits/equiv_percentage_increase_minutes_time_home_Harlem.csv

################
# Tables
################

tables = \
	../output/tables/table_gentrification_Bedstuy.tex \
	../output/tables/table_gentrification_Harlem.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs) $(predictedvisits) $(predvisitarray) $(delta) $(tables)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs): $(DTA_input) $(JLD_input) general_functions.jl gen_sourcefiles_predvisits_gentrification_jld.jl gen_sourcefiles_predvisits_gentrification_jld.sbatch
	sbatch -W gen_sourcefiles_predvisits_gentrification_jld.sbatch

$(predvisits): $(JLDs) $(PROGS) predvisit_gentrification.jl predvisit_gentrification.sbatch
	sbatch -W predvisit_gentrification.sbatch

$(delta): $(JLDs) $(PROGS) $(predvisits) equivalent_welfare_change_functions.jl equivalent_welfare_change.jl equivalent_welfare_change.sbatch
	sbatch -W equivalent_welfare_change.sbatch

$(tables): $(JLDs) $(PROGS) $(predvisits) $(delta) table_gentrification_function.jl table_gentrification.jl table_gentrification.sbatch
	sbatch -W table_gentrification.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
