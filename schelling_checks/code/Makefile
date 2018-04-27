####################
# INPUT
####################

stata_dta_inputs = ../input/observationallyequivalentvenuesdata.dta

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output = \
	../output/racegapvsnull.pdf	\
	../output/schelling_ttest_sentence.tex	\
	../output/schelling_isoindexelements.pdf	\
	../output/schelling_ttest_appendix_sentence.tex	

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(stata_dta_inputs) schelling_isoindexelements.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
