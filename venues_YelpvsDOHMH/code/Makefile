####################
# INPUT
####################

stata_dta= ../input/YelpvsDOHMH_ZIPs.dta

#####################
# OUTPUT
#####################

folders_and_symlinks=create_folders_and_symlinks.txt

gen_dir_and_sym=create_folders_and_symlinks.txt

figure=../output/figure_A2.pdf

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(figure)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(figure): $(stata_dta) venues_YelpvsDOHMH.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
	


