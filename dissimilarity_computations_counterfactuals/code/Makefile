###################
# Programmes
###################

PROGS = dissimilarity_functions.jl \
	general_functions.jl

####################
# INPUT
####################

stata_dta = ../input/tract_2010_characteristics_est.dta

predictedvisits_cftl=$(shell awk 'BEGIN { print "2ndAve\nslowdown\nsocialchange" }'|awk '$$0="predictedvisits_collapsed_over_workplace_black_sixom_mainspec_"$$0' |awk '$$0="../input/predictedvisits/sixom/"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_cftl+=$(shell awk 'BEGIN { print "2ndAve\nslowdown\nsocialchange" }'|awk '$$0="predictedvisits_collapsed_over_workplace_asian_sixom_mainspec_"$$0' |awk '$$0="../input/predictedvisits/sixom/"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")
predictedvisits_cftl+=$(shell awk 'BEGIN { print "2ndAve\nslowdown\nsocialchange" }'|awk '$$0="predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec_"$$0' |awk '$$0="../input/predictedvisits/sixom/"$$0'|awk '$$0=$$0".jld"'| tr "\n" " ")


####################
# OUTPUT
#################### 

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# Dissimilarities
####################

dissim_cftl =\
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_slowdown.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_mainspec_slowdown.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_slowdown.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_mainspec_slowdown.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_2ndAve.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_mainspec_2ndAve.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_2ndAve.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_mainspec_2ndAve.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec_socialchange.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_mainspec_socialchange.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec_socialchange.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_mainspec_socialchange.csv

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(dissim_cftl)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(dissim_cftl): $(PROGS) $(stata_dta) $(predictedvisits_cftl) dissimilarity_venueandtract_originmode_specification_cftl.jl dissimilarity_venueandtract_originmode_specification_cftl.sbatch
	sbatch -W dissimilarity_venueandtract_originmode_specification_cftl.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
