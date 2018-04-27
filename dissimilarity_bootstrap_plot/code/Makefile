####################
# INPUT
####################

dissim_stata = \
	../input/dissim_pairwise_tracts_merged.dta \
	../input/dissim_pairwise_venues_mainspec_merged.dta \
	../input/dissim_tracts_merged.dta \
	../input/dissim_venues_mainspec_merged.dta \
	../input/dissim_venues_mintime_merged.dta 

dissim_csv=\
	../input/dissimilarity_index_venue_level_mintime_mainspec.csv \
	../input/dissimilarity_index_venue_level_sixom_mainspec.csv \

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output_stata=\
	../output/dissimilarity_bootstrap_table.tex \
	../output/dissimilarity_bootstrap_plot.pdf \


#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output_stata)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt
	
$(output_stata): $(dissim_stata) $(dissim_csv) dissimilarity_bootstrap_plot.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
	
