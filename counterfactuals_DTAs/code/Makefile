####################
# INPUT
####################

input = \
	../input/estimates_whithisp_mainspec.csv \
	../input/estimates_black_mainspec.csv \
	../input/estimates_asian_mainspec.csv \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/traveltime_gain_new_line.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output=\
	../output/socialchange_parameters_whithisp.csv \
	../output/socialchange_parameters_black.csv \
	../output/socialchange_parameters_asian.csv \
	../output/tract_pairs_slowdown.dta \
	../output/tract_pairs_2ndAve.dta 

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(input) counterfactuals_DTAs.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
