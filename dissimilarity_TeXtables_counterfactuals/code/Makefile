####################
# INPUT
####################

dissimilarity=\
	../input/sixom/dissimilarity_index_venue_level_sixom_mainspec.csv \
	../input/sixom/dissimilarity_index_tract_level_sixom_mainspec.csv \
	../input/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec.csv \
	../input/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec.csv \
	../input/sixom/dissimilarity_index_venue_level_sixom_mainspec_socialchange.csv \
	../input/sixom/dissimilarity_index_venue_level_sixom_mainspec_slowdown.csv \
	../input/sixom/dissimilarity_index_venue_level_sixom_mainspec_2ndAve.csv \
	../input/sixom/dissimilarity_index_tract_level_sixom_mainspec_socialchange.csv \
	../input/sixom/dissimilarity_index_tract_level_sixom_mainspec_slowdown.csv \
	../input/sixom/dissimilarity_index_tract_level_sixom_mainspec_2ndAve.csv \
	../input/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_socialchange.csv \
	../input/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_slowdown.csv \
	../input/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_2ndAve.csv \
	../input/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_socialchange.csv \
	../input/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_slowdown.csv \
	../input/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_2ndAve.csv

######################
# OUTPUT
######################

folders_and_symlinks=create_folders_and_symlinks.txt

#Tex
Tex=\
	../output/sixom/dissimilarity_cftl_tract_level.tex \
	../output/sixom/dissimilarity_cftl_venue_level.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(Tex)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(Tex): dissimilarity_tables_cftl.jl dissimilarity_tables_cftl_functions.jl dissimilarity_tables_cftl.sbatch
	sbatch -W dissimilarity_tables_cftl.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh

 