####################
# PROGRAMS
####################

PROGS=\
	compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl \

####################
# INPUT
####################

estarrays_sixom=\
	../input/estarrays/sixom/estarray_venueFE_asian.dta \
	../input/estarrays/sixom/estarray_venueFE_black.dta \
	../input/estarrays/sixom/estarray_venueFE_whithisp.dta \

estimates_sixom=\
	../input/estimates/sixom/estimates_whithisp_mainspec.csv  \
	../input/estimates/sixom/estimates_venueFE_whithisp_sixom.csv  \
	../input/estimates/sixom/estimates_asian_mainspec.csv  \
	../input/estimates/sixom/estimates_venueFE_asian_sixom.csv  \
	../input/estimates/sixom/estimates_black_mainspec.csv  \
	../input/estimates/sixom/estimates_venueFE_black_sixom.csv  \

predictarray_sixom=\
	../input/estsample_predictarray/sixom/estsample_predictarray_whithisp_sixom.dta \
	../input/estsample_predictarray/sixom/estsample_predictarray_asian_sixom.dta \
	../input/estsample_predictarray/sixom/estsample_predictarray_black_sixom.dta \

stata_dta = ../input/trips_est.dta

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

trip_data=../output/tripdata.dta

LL_observables_vs_FE=../output/results/sixom/loglikelihood_observables_vs_FE.csv

Tex=../output/tables/sixom/table_observables_vs_FE.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(trip_data) $(LL_observables_vs_FE) $(Tex)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(trip_data): $(stata_dta) prepare_tripdata.do prepare_tripdata.sbatch
	sbatch -W prepare_tripdata.sbatch

$(LL_observables_vs_FE): $(PROGS) $(trip_data) $(estarrays_sixom) $(estimates_sixom) $(predictarray_sixom) compute_loglikelihood_observables_vs_FE.jl compute_loglikelihood_observables_vs_FE_functions.jl compute_loglikelihood_observables_vs_FE.sbatch
	sbatch -W compute_loglikelihood_observables_vs_FE.sbatch

$(Tex):	$(LL_observables_vs_FE) table_observables_vs_FE.jl table_observables_vs_FE_functions.jl table_observables_vs_FE.sbatch
	sbatch -W table_observables_vs_FE.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
