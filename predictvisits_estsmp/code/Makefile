###################
# Programmes
###################

PROGS = compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl

####################
# INPUT
####################

estimates_mintime=\
	../input/estimates_black_mintime.csv \
	../input/estimates_asian_mintime.csv \
	../input/estimates_whithisp_mintime.csv 

estimates_sixom=\
	../input/estimates_black_mainspec.csv \
	../input/estimates_black_mainspec.csv \
	../input/estimates_black_mainspec.csv 

estimates_raceblind=../input/estimates_raceblind.csv

estsample_predictarray=\
	../input/estsample_predictarray_black_mintime.dta \
	../input/estsample_predictarray_asian_mintime.dta \
	../input/estsample_predictarray_whithisp_mintime.dta \
	../input/estsample_predictarray_black_sixom.dta \
	../input/estsample_predictarray_asian_sixom.dta \
	../input/estsample_predictarray_whithisp_sixom.dta 


####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# Predicted visits
####################

predictedvisits=\
	../output/predictedvisits_black_mintime.csv	\
	../output/predictedvisits_asian_mintime.csv	\
	../output/predictedvisits_whithisp_mintime.csv	\
	../output/predictedvisits_black_mainspec.csv	\
	../output/predictedvisits_asian_mainspec.csv	\
	../output/predictedvisits_whithisp_mainspec.csv	\
	../output/predictedvisits_black_pooled.csv	\
	../output/predictedvisits_asian_pooled.csv	\
	../output/predictedvisits_whithisp_pooled.csv	

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predictedvisits): $(PROGS) $(estimates_mintime) $(estimates_sixom) $(estimates_raceblind) predictvisits_estsmp.jl run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
