##############################################################################
# PROGRAMS
##############################################################################

functions_estarray=\
	gen_estimationarray_functions.jl \
	general_functions.jl

functions_estimation=\
	estimation_functions.jl \
	fit_mnl_hessianfree.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl

##############################################################################
# INPUT
##############################################################################

estarrays_mintime = \
	../input/estarrays/mintime/estarray_venueFE_mintime_whithisp.dta \
	../input/estarrays/mintime/estarray_venueFE_mintime_asian.dta \
	../input/estarrays/mintime/estarray_venueFE_mintime_black.dta

estarrays_sixom = \
	../input/estarrays/sixom/estarray_venueFE_whithisp.dta \
	../input/estarrays/sixom/estarray_venueFE_asian.dta \
	../input/estarrays/sixom/estarray_venueFE_black.dta

estimates_starting_point_mintime=\
	../input/estimates/mintime/estimates_whithisp_mainspec.csv \
	../input/estimates/mintime/estimates_asian_mainspec.csv \
	../input/estimates/mintime/estimates_black_mainspec.csv

estimates_starting_point_sixom=\
	../input/estimates/sixom/estimates_whithisp_mainspec.csv \
	../input/estimates/sixom/estimates_asian_mainspec.csv \
	../input/estimates/sixom/estimates_black_mainspec.csv

##############################################################################
# OUTPUT
##############################################################################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs_mintime=\
	../output/estarrays_JLDs/mintime/estarray_venueFE_whithisp_mintime.jld \
	../output/estarrays_JLDs/mintime/estarray_venueFE_asian_mintime.jld \
	../output/estarrays_JLDs/mintime/estarray_venueFE_black_mintime.jld

JLDs_sixom=\
	../output/estarrays_JLDs/sixom/estarray_venueFE_whithisp_sixom.jld \
	../output/estarrays_JLDs/sixom/estarray_venueFE_asian_sixom.jld \
	../output/estarrays_JLDs/sixom/estarray_venueFE_black_sixom.jld

####################
# Estimates
####################

estimates_mintime=\
	../output/estimates/mintime/estimates_venueFE_whithisp_mintime.csv \
	../output/estimates/mintime/estimates_venueFE_asian_mintime.csv \
	../output/estimates/mintime/estimates_venueFE_black_mintime.csv \

estimates_sixom=\
	../output/estimates/sixom/estimates_venueFE_whithisp_sixom.csv \
	../output/estimates/sixom/estimates_venueFE_asian_sixom.csv \
	../output/estimates/sixom/estimates_venueFE_black_sixom.csv \

#######################
# Tables
#######################

tables = \
	../output/tables/mintime/tab_venueFE_mintime.tex \
	../output/tables/sixom/tab_venueFE_sixom.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs_mintime) $(JLDs_sixom) $(estimates_mintime) $(estimates_sixom) $(tables)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs_mintime): $(estarrays_mintime) $(functions_estarray) gen_estimationarray_FE_calls.jl gen_estimationarray_FE_mintime.sbatch
	sbatch -W gen_estimationarray_FE_mintime.sbatch

$(JLDs_sixom): $(estarrays_sixom) $(functions_estarray) gen_estimationarray_FE_calls.jl gen_estimationarray_FE_sixom.sbatch
	sbatch -W gen_estimationarray_FE_sixom.sbatch

$(estimates_mintime): $(JLDs_mintime) $(estimates_starting_point_mintime) $(functions_estimation) estimation_FE_calls.jl estimation_FE_mintime.sbatch
	sbatch -W estimation_FE_mintime.sbatch

$(estimates_sixom): $(JLDs_sixom) $(estimates_starting_point_sixom) $(functions_estimation) estimation_FE_calls.jl estimation_FE_sixom.sbatch
	sbatch -W estimation_FE_sixom.sbatch

$(tables): $(estimates_mintime) $(estimates_sixom) tables_FE_calls.jl tables_formatting.jl tables_functions_FE.jl tables_FE_calls.sbatch
	sbatch -W tables_FE_calls.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
