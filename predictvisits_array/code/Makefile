####################
# PROGRAMS
####################

PROGS =\
	gen_array_predvisits_racespecific_functions.jl \
	general_functions.jl

####################
# INPUT
####################

stata_dta=\
	../input/venues.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/top_workplaces_5.dta

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs = \
	../output/JLDs/geoid11_home_work.jld \
	../output/JLDs/geoid11_work_pair.jld \
	../output/JLDs/geoid11_home_pair.jld \
	../output/JLDs/geoid11_home.jld \
	../output/JLDs/geoid11.jld \
	../output/JLDs/venues.jld \
	../output/JLDs/top_workplaces_5.jld

#####################
# Predicted visits
#####################

predvisitsarray = $(shell seq 1 2103|awk '$$0="../output/predictedvisitsarray/predvisitarray_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs) $(predvisitsarray)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs): $(PROGS) gen_sourcefiles_predvisits_jld.jl gen_sourcefiles_predvisits_jld.sbatch
	sbatch -W gen_sourcefiles_predvisits_jld.sbatch

$(predvisitsarray): $(PROGS) $(JLDs) predvisitarray_alltracts.jl predvisitarray_alltracts.sbatch
	sbatch -W predvisitarray_alltracts.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
