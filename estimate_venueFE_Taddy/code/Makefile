####################
# PROGRAMS
####################

PROGS = \
	gen_estimationarray_functions.jl \
	general_functions.jl

#########################
# INPUT
#########################

estarray_stata =\
	../input/estarrays/estarray_venueFE_Taddy_whithisp.dta \
	../input/estarrays/estarray_venueFE_Taddy_black.dta \
	../input/estarrays/estarray_venueFE_Taddy_asian.dta

#########################
# OUTPUT
#########################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# JLD files
####################

JLDs=\
	../output/estarrays_JLDs/estarray_Taddy_black.jld \
	../output/estarrays_JLDs/estarray_Taddy_asian.jld \
	../output/estarrays_JLDs/estarray_Taddy_whithisp.jld

####################
# Estimates
####################

estimates=\
	../output/estimates/estimates_Taddy_black.csv \
	../output/estimates/estimates_Taddy_asian.csv \
	../output/estimates/estimates_Taddy_whithisp.csv

#######################
# Tables
#######################

tables = \
	../output/tables/table_Taddy.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(JLDs) $(estimates) $(tables)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(JLDs): $(PROGS) gen_estimationarray_Taddy_functions.jl gen_estimationarray_Taddy_calls.jl gen_estimationarray_Taddy_calls.sbatch
	sbatch -W gen_estimationarray_Taddy_calls.sbatch

$(estimates): $(JLDs) fit_Taddy.jl estimation_Taddy_functions.jl estimation_Taddy_calls.jl estimation_Taddy_calls.sbatch
	sbatch -W estimation_Taddy_calls.sbatch

$(tables): $(estimates) tables_functions_Taddy.jl tables_formatting.jl tables_Taddy_calls.jl tables_Taddy_calls.sbatch
	sbatch -W tables_Taddy_calls.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
