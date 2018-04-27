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

estimates=\
	../input/estimates_asian_mainspec_bootstrap_avg.csv \
	../input/estimates_black_mainspec_bootstrap_avg.csv \
	../input/estimates_whithisp_mainspec_bootstrap_avg.csv \

estsample=\
	../input/estsample_predictarray_asian_sixom.dta \
	../input/estsample_predictarray_black_sixom.dta \
	../input/estsample_predictarray_whithisp_sixom.dta \

############################
# OUTPUT
############################

folders_and_symlinks=create_folders_and_symlinks.txt

predictedvisits=\
	../output/predictedvisits_asian_bsavg.csv \
	../output/predictedvisits_black_bsavg.csv \
	../output/predictedvisits_whithisp_bsavg.csv \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predictedvisits): $(PROGS) $(estimates) $(estsample) predictvisits_estsmp_betabsavg.jl run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
