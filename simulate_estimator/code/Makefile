####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output=\
	../output/estimator_simulated.tex \
	../output/estimator_simulated.txt \
	../output/estimator_simulations.tex \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): choicesetconstruction.do run.sbatch tablerefiner.sh
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
