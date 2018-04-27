####################
# PROGRAMS
####################

PROGS=fit_mnl_newton.jl

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

Tex=../output/estimates_persistent_preferences_MLE.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(Tex)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(Tex): $(PROGS) DGP_permanent_shocks_calls.jl DGP_permanent_shocks_functions.jl DGP_permanent_shocks_calls.sbatch
	sbatch -W DGP_permanent_shocks_calls.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
