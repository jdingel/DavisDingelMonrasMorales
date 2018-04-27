##########################
# INPUT
##########################

stata_dta=\
	../input/venues.dta \
	../input/top_workplaces_5.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/tract_pairs_2ndAve.dta \
	../input/tract_pairs_slowdown.dta \=

##########################
# OUTPUT
##########################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs = \
../output/JLDs/geoid11_home_work_slowdown.jld \
../output/JLDs/geoid11_work_pair_slowdown.jld \
../output/JLDs/geoid11_home_pair_slowdown.jld \
../output/JLDs/geoid11_home_work_2ndAve.jld \
../output/JLDs/geoid11_work_pair_2ndAve.jld \
../output/JLDs/geoid11_home_pair_2ndAve.jld \
../output/JLDs/geoid11_home.jld \
../output/JLDs/geoid11.jld \
../output/JLDs/venues.jld \
../output/JLDs/top_workplaces_5.jld

##########################
# Predicted visits arrays
##########################

predvisitsarray= $(shell seq 1 2103|awk '$$0="../output/predictedvisitsarray/2ndAve/predvisitarray_"$$0'| awk '$$0=$$0"_2ndAve.jld"'|tr "\n" " ")
predvisitsarray+=$(shell seq 1 2103|awk '$$0="../output/predictedvisitsarray/slowdown/predvisitarray_"$$0'| awk '$$0=$$0"_slowdown.jld"'|tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs) $(predvisitsarray)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs): general_functions.jl gen_sourcefiles_predvisits_cftl_jld.jl gen_sourcefiles_predvisits_cftl_jld.sbatch
	sbatch -W gen_sourcefiles_predvisits_cftl_jld.sbatch

$(predvisitsarray): $(JLDs) gen_array_predvisits_racespecific_functions.jl predvisitarray_alltracts_cftl.jl predvisitarray_alltracts_cftl.sbatch
	sbatch -W predvisitarray_alltracts_cftl.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
