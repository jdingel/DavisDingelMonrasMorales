###################
# PROGRAMS
###################

functions_estarray=\
	gen_estimationarray_functions.jl \
	general_functions.jl \

functions_estimation=\
	estimation_functions.jl \
	fit_mnl_hessianfree.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \

##############################################################################
# INPUT
##############################################################################

estarrays_mintime=\
	../input/estarrays/mintime/estarray_whithisp_nests_nested2.dta \
	../input/estarrays/mintime/estarray_whithisp_nests_nested1.dta \
	../input/estarrays/mintime/estarray_whithisp_incval_nested2.dta \
	../input/estarrays/mintime/estarray_whithisp_incval_nested1.dta \
	../input/estarrays/mintime/estarray_black_nests_nested2.dta \
	../input/estarrays/mintime/estarray_black_nests_nested1.dta \
	../input/estarrays/mintime/estarray_black_incval_nested2.dta \
	../input/estarrays/mintime/estarray_black_incval_nested1.dta \
	../input/estarrays/mintime/estarray_asian_nests_nested2.dta \
	../input/estarrays/mintime/estarray_asian_nests_nested1.dta \
	../input/estarrays/mintime/estarray_asian_incval_nested2.dta \
	../input/estarrays/mintime/estarray_asian_incval_nested1.dta

estarrays_sixom=\
	../input/estarrays/sixom/estarray_whithisp_nests_nested2.dta \
	../input/estarrays/sixom/estarray_whithisp_nests_nested1.dta \
	../input/estarrays/sixom/estarray_whithisp_incval_nested2.dta \
	../input/estarrays/sixom/estarray_whithisp_incval_nested1.dta \
	../input/estarrays/sixom/estarray_black_nests_nested2.dta \
	../input/estarrays/sixom/estarray_black_nests_nested1.dta \
	../input/estarrays/sixom/estarray_black_incval_nested2.dta \
	../input/estarrays/sixom/estarray_black_incval_nested1.dta \
	../input/estarrays/sixom/estarray_asian_nests_nested2.dta \
	../input/estarrays/sixom/estarray_asian_nests_nested1.dta \
	../input/estarrays/sixom/estarray_asian_incval_nested2.dta \
	../input/estarrays/sixom/estarray_asian_incval_nested1.dta

estimates_mintime_init=\
	../input/estimates/mintime/estimates_asian_mainspec.csv \
	../input/estimates/mintime/estimates_black_mainspec.csv \
	../input/estimates/mintime/estimates_whithisp_mainspec.csv \

estimates_sixom_init=\
	../input/estimates/sixom/estimates_asian_mainspec.csv \
	../input/estimates/sixom/estimates_black_mainspec.csv \
	../input/estimates/sixom/estimates_whithisp_mainspec.csv \

##############################################################################
# OUTPUT
##############################################################################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs_mintime=\
	../output/estarrays_JLDs/mintime/estarray_whithisp_nlogit_nested2.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_nlogit_nested1.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_nlogit_nested1.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_nlogit_nested2.jld \
	../output/estarrays_JLDs/mintime/estarray_black_nlogit_nested1.jld \
	../output/estarrays_JLDs/mintime/estarray_black_nlogit_nested2.jld

JLDs_sixom=\
	../output/estarrays_JLDs/sixom/estarray_whithisp_nlogit_nested1.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_nlogit_nested2.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_nlogit_nested1.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_nlogit_nested2.jld \
	../output/estarrays_JLDs/sixom/estarray_black_nlogit_nested1.jld \
	../output/estarrays_JLDs/sixom/estarray_black_nlogit_nested2.jld

####################
# Estimates
####################

estimates_mintime=\
	../output/estimates/mintime/estimates_whithisp_nlogit_nested1.csv \
	../output/estimates/mintime/estimates_asian_nlogit_nested1.csv \
	../output/estimates/mintime/estimates_whithisp_nlogit_nested2.csv \
	../output/estimates/mintime/estimates_asian_nlogit_nested2.csv \
	../output/estimates/mintime/estimates_black_nlogit_nested1.csv \
	../output/estimates/mintime/estimates_black_nlogit_nested2.csv

estimates_sixom=\
	../output/estimates/sixom/estimates_whithisp_nlogit_nested1.csv \
	../output/estimates/sixom/estimates_asian_nlogit_nested1.csv \
	../output/estimates/sixom/estimates_whithisp_nlogit_nested2.csv \
	../output/estimates/sixom/estimates_asian_nlogit_nested2.csv \
	../output/estimates/sixom/estimates_black_nlogit_nested1.csv \
	../output/estimates/sixom/estimates_black_nlogit_nested2.csv

#######################
# Tables
#######################

tables = \
	../output/tables/mintime/tab_nlogit.tex \
	../output/tables/sixom/tab_nlogit.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs_mintime) $(JLDs_sixom) $(estimates_mintime) $(estimates_sixom) $(tables)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs_mintime): $(functions_estarray) $(estarrays_mintime) gen_estimationarray_nlogit_calls.jl gen_estimationarray_nlogit_mintime.sbatch
	sbatch -W gen_estimationarray_nlogit_mintime.sbatch

$(JLDs_sixom): $(functions_estarray) $(estarrays_sixom) gen_estimationarray_nlogit_calls.jl gen_estimationarray_nlogit_sixom.sbatch
	sbatch -W gen_estimationarray_nlogit_sixom.sbatch

$(estimates_mintime): $(functions_estimation) $(JLDs_mintime) $(estimates_mintime_init) estimation_nlogit_calls.jl estimation_nlogit_mintime.sbatch
	sbatch -W estimation_nlogit_mintime.sbatch

$(estimates_sixom): $(functions_estimation) $(JLDs_sixom) $(estimates_sixom_init) estimation_nlogit_calls.jl estimation_nlogit_sixom.sbatch
	sbatch -W estimation_nlogit_sixom.sbatch

$(tables): $(estimates_mintime) $(estimates_sixom) tables_nlogit_calls.jl tables_formatting.jl tables_nlogit_functions.jl tables_nlogit_calls.sbatch
	sbatch -W tables_nlogit_calls.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
