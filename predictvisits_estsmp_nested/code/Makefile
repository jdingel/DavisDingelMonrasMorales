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
	../input/estimates/mintime/estimates_whithisp_nlogit_nested2.csv  \
	../input/estimates/mintime/estimates_whithisp_nlogit_nested1.csv  \
	../input/estimates/mintime/estimates_black_nlogit_nested2.csv  \
	../input/estimates/mintime/estimates_black_nlogit_nested1.csv  \
	../input/estimates/mintime/estimates_asian_nlogit_nested2.csv  \
	../input/estimates/mintime/estimates_asian_nlogit_nested1.csv  \

estimates_sixom=\
	../input/estimates/sixom/estimates_whithisp_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_whithisp_nlogit_nested1.csv \
	../input/estimates/sixom/estimates_black_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_black_nlogit_nested1.csv \
	../input/estimates/sixom/estimates_asian_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_asian_nlogit_nested1.csv \

predictarray=\
	../input/estsample_predictarray/estsample_predictarray_whithisp_nest2.dta \
	../input/estsample_predictarray/estsample_predictarray_whithisp_nest1.dta \
	../input/estsample_predictarray/estsample_predictarray_black_nest2.dta \
	../input/estsample_predictarray/estsample_predictarray_black_nest1.dta \
	../input/estsample_predictarray/estsample_predictarray_asian_nest2.dta \
	../input/estsample_predictarray/estsample_predictarray_asian_nest1.dta \

############################
# OUTPUT
############################

folders_and_symlinks=create_folders_and_symlinks.txt

predictedvisits=\
	../output/predictedvisits/sixom/predictedvisits_asian_sixom_nlogit_nest1.csv \
	../output/predictedvisits/sixom/predictedvisits_asian_sixom_nlogit_nest2.csv \
	../output/predictedvisits/sixom/predictedvisits_black_sixom_nlogit_nest1.csv \
	../output/predictedvisits/sixom/predictedvisits_black_sixom_nlogit_nest2.csv \
	../output/predictedvisits/sixom/predictedvisits_whithisp_sixom_nlogit_nest1.csv \
	../output/predictedvisits/sixom/predictedvisits_whithisp_sixom_nlogit_nest2.csv \
	../output/predictedvisits/mintime/predictedvisits_asian_mintime_nlogit_nest1.csv \
	../output/predictedvisits/mintime/predictedvisits_asian_mintime_nlogit_nest2.csv \
	../output/predictedvisits/mintime/predictedvisits_black_mintime_nlogit_nest1.csv \
	../output/predictedvisits/mintime/predictedvisits_black_mintime_nlogit_nest2.csv \
	../output/predictedvisits/mintime/predictedvisits_whithisp_mintime_nlogit_nest1.csv \
	../output/predictedvisits/mintime/predictedvisits_whithisp_mintime_nlogit_nest2.csv \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predictedvisits): $(PROGS) $(estimates_mintime) $(estimates_sixom) $(predictarray) predvisits_estsmp_nlogit.jl predvisits_estsmp_nlogit.sbatch
	sbatch -W predvisits_estsmp_nlogit.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
