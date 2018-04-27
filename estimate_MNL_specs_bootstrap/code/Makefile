##################
# PROGRAMS
##################

PROGS_JLDs = gen_estimationarray_functions.jl \
	general_functions.jl

PROGS_estimation = estimation_functions.jl \
	fit_mnl_hessianfree.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl

##########################
# INPUT
##########################

estarrays_bootstrap_mainspec=$(shell seq 1 500|awk '$$0="../input/estarrays/mainspec/asian_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap_mainspec+=$(shell seq 1 500|awk '$$0="../input/estarrays/mainspec/black_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap_mainspec+=$(shell seq 1 500|awk '$$0="../input/estarrays/mainspec/whithisp_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")

estarrays_bootstrap_mintime=$(shell seq 1 500|awk '$$0="../input/estarrays/mintime/asian_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap_mintime+=$(shell seq 1 500|awk '$$0="../input/estarrays/mintime/black_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap_mintime+=$(shell seq 1 500|awk '$$0="../input/estarrays/mintime/whithisp_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")

estimates_init_mainspec=\
	../input/estimates/mainspec/estimates_asian_mainspec.csv \
	../input/estimates/mainspec/estimates_black_mainspec.csv \
	../input/estimates/mainspec/estimates_whithisp_mainspec.csv \

estimates_init_mintime=\
	../input/estimates/mintime/estimates_asian_mainspec.csv \
	../input/estimates/mintime/estimates_black_mainspec.csv \
	../input/estimates/mintime/estimates_whithisp_mainspec.csv \

##########################
# OUTPUT
##########################

folders_and_symlinks=create_folders_and_symlinks.txt

##################
# JLD files
##################

estarrays_JLDs_mainspec= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mainspec/black_mainspec_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")
estarrays_JLDs_mainspec+= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mainspec/asian_mainspec_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")
estarrays_JLDs_mainspec+= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mainspec/whithisp_mainspec_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

estarrays_JLDs_mintime= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mintime/black_mintime_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")
estarrays_JLDs_mintime+= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mintime/asian_mintime_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")
estarrays_JLDs_mintime+= $(shell seq 1 500|awk '$$0="../output/estarrays_JLDs/mintime/whithisp_mintime_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

#####################
# Estimates
#####################

estimates_newton_mainspec= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_black_mainspec_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")
estimates_newton_mainspec+= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_asian_mainspec_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")
estimates_newton_mainspec+= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_whithisp_mainspec_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")

estimates_hessianfree_mainspec= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_black_mainspec_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")
estimates_hessianfree_mainspec+= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_asian_mainspec_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")
estimates_hessianfree_mainspec+= $(shell seq 1 500|awk '$$0="../output/estimates/mainspec/estimates_whithisp_mainspec_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")

estimates_newton_mintime=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_black_mintime_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")
estimates_newton_mintime+=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_asian_mintime_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")
estimates_newton_mintime+=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_whithisp_mintime_"$$0'| awk '$$0=$$0".csv"'|tr "\n" " ")

estimates_hessianfree_mintime=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_black_mintime_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")
estimates_hessianfree_mintime+=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_asian_mintime_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")
estimates_hessianfree_mintime+=$(shell seq 1 500|awk '$$0="../output/estimates/mintime/estimates_whithisp_mintime_"$$0'| awk '$$0=$$0"_hessianfree.csv"'|tr "\n" " ")

estimates_aggregate = \
	../output/estimates/mainspec/estimates_black_mainspec_bootstrap_all.csv	\
	../output/estimates/mainspec/estimates_asian_mainspec_bootstrap_all.csv	\
	../output/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_all.csv \
	../output/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv \
	../output/estimates/mainspec/estimates_asian_mainspec_bootstrap_clean.csv \
	../output/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_clean.csv \
	../output/estimates/mainspec/estimates_black_mainspec_bootstrap_avg.csv \
	../output/estimates/mainspec/estimates_asian_mainspec_bootstrap_avg.csv \
	../output/estimates/mainspec/estimates_whithisp_mainspec_bootstrap_avg.csv \
	../output/estimates/mintime/estimates_black_mintime_bootstrap_all.csv	\
	../output/estimates/mintime/estimates_asian_mintime_bootstrap_all.csv	\
	../output/estimates/mintime/estimates_whithisp_mintime_bootstrap_all.csv \
	../output/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv \
	../output/estimates/mintime/estimates_asian_mintime_bootstrap_clean.csv \
	../output/estimates/mintime/estimates_whithisp_mintime_bootstrap_clean.csv \
	../output/estimates/mintime/estimates_black_mintime_bootstrap_avg.csv \
	../output/estimates/mintime/estimates_asian_mintime_bootstrap_avg.csv \
	../output/estimates/mintime/estimates_whithisp_mintime_bootstrap_avg.csv

#########################
# Figures
#########################

figures_mainspec=\
	../output/figures/mainspec/density_social_frictions_whithisp_mainspec_2by3.pdf \
	../output/figures/mainspec/density_social_frictions_whithisp_mainspec_3by2.pdf \
	../output/figures/mainspec/density_time_covariates_whithisp_mainspec_zoom_2by3.pdf \
	../output/figures/mainspec/density_time_covariates_whithisp_mainspec_zoom_3by2.pdf \
	../output/figures/mainspec/density_time_car_work_log_whithisp_mainspec_trimleft2percent.pdf \
	../output/figures/mainspec/density_time_covariates_whithisp_mainspec.pdf \
	../output/figures/mainspec/density_social_frictions_asian_mainspec_2by3.pdf \
	../output/figures/mainspec/density_social_frictions_asian_mainspec_3by2.pdf \
	../output/figures/mainspec/density_time_covariates_asian_mainspec_zoom_2by3.pdf \
	../output/figures/mainspec/density_time_covariates_asian_mainspec_zoom_3by2.pdf \
	../output/figures/mainspec/density_time_covariates_asian_mainspec.pdf \
	../output/figures/mainspec/density_social_frictions_black_mainspec_2by3.pdf \
	../output/figures/mainspec/density_social_frictions_black_mainspec_3by2.pdf \
	../output/figures/mainspec/density_time_covariates_black_mainspec_zoom_2by3.pdf \
	../output/figures/mainspec/density_time_covariates_black_mainspec_zoom_3by2.pdf \
	../output/figures/mainspec/density_time_covariates_black_mainspec.pdf

figures_mintime=\
	../output/figures/mintime/density_spatial_frictions_whithisp_mintime_1by3.pdf \
	../output/figures/mintime/density_social_frictions_whithisp_mintime_2by3.pdf \
	../output/figures/mintime/density_social_frictions_whithisp_mintime_3by2.pdf \
	../output/figures/mintime/density_time_home_log_whithisp_mintime.pdf \
	../output/figures/mintime/density_social_frictions_asian_mintime_2by3.pdf \
	../output/figures/mintime/density_social_frictions_asian_mintime_3by2.pdf \
	../output/figures/mintime/density_time_home_log_asian_mintime.pdf \
	../output/figures/mintime/density_social_frictions_black_mintime_2by3.pdf \
	../output/figures/mintime/density_social_frictions_black_mintime_3by2.pdf \
	../output/figures/mintime/density_time_home_log_black_mintime.pdf

##########################
# Work section
##########################

all: $(folders_and_symlinks) $(estarrays_JLDs_mainspec) $(estarrays_JLDs_mintime) \
	$(estimates_newton_mainspec) $(estimates_hessianfree_mainspec) \
	$(estimates_newton_mintime) $(estimates_hessianfree_mintime) \
	$(estimates_aggregate) $(figures_mintime) $(figures_mainspec)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estarrays_JLDs_mainspec): $(PROGS_JLDs)  $(estarrays_bootstrap_mainspec) estarrays_JLDs_bootstrap_raceid_specification.jl estarrays_JLDs_bootstrap_raceid_specification_mainspec.sbatch
	sbatch -W estarrays_JLDs_bootstrap_raceid_specification_mainspec.sbatch

$(estarrays_JLDs_mintime): $(PROGS_JLDs)  $(estarrays_bootstrap_mintime) estarrays_JLDs_bootstrap_raceid_specification.jl estarrays_JLDs_bootstrap_raceid_specification_mintime.sbatch
	sbatch -W estarrays_JLDs_bootstrap_raceid_specification_mintime.sbatch

$(estimates_newton_mainspec): $(estarrays_JLDs_mainspec) $(PROGS_estimation) $(estimates_init_mainspec) estimation_bootstrap_raceid_specification.jl estimation_bootstrap_raceid_specification_mainspec.sbatch
	sbatch -W estimation_bootstrap_raceid_specification_mainspec.sbatch

$(estimates_newton_mintime): $(estarrays_JLDs_mintime) $(PROGS_estimation) $(estimates_init_mintime) estimation_bootstrap_raceid_specification.jl estimation_bootstrap_raceid_specification_mintime.sbatch
	sbatch -W estimation_bootstrap_raceid_specification_mintime.sbatch

$(estimates_hessianfree_mainspec): $(estarrays_JLDs_mainspec) $(PROGS_estimation) $(estimates_init_mainspec) estimation_bootstrap_raceid_specification_hessianfree.jl estimation_bootstrap_raceid_specification_hessianfree_mainspec.sbatch
	sbatch -W estimation_bootstrap_raceid_specification_hessianfree_mainspec.sbatch

$(estimates_hessianfree_mintime): $(estarrays_JLDs_mintime) $(PROGS_estimation) $(estimates_init_mintime) estimation_bootstrap_raceid_specification_hessianfree.jl estimation_bootstrap_raceid_specification_hessianfree_mintime.sbatch
	sbatch -W estimation_bootstrap_raceid_specification_hessianfree_mintime.sbatch

$(estimates_aggregate): $(estimates_newton_mainspec) $(estimates_newton_mintime) $(estimates_hessianfree_mainspec) $(estimates_hessianfree_mintime) general_functions.jl process_bootstrap_raceid_specification.jl process_bootstrap_estimates_functions.jl process_bootstrap_raceid_specification.sbatch
	sbatch -W process_bootstrap_raceid_specification.sbatch

$(figures_mintime): $(estimates_aggregate) density_plots_bootstrapestimates_functions.R density_plot_bootstrapestimates_mintime.R density_plot_bootstrapestimates_mintime.sbatch
	sbatch -W density_plot_bootstrapestimates_mintime.sbatch

$(figures_mainspec): $(estimates_aggregate) density_plots_bootstrapestimates_functions.R density_plot_bootstrapestimates_mainspec.R density_plot_bootstrapestimates_mainspec.sbatch
	sbatch -W density_plot_bootstrapestimates_mainspec.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
