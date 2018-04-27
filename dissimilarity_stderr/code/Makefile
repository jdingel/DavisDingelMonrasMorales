####################
# INPUT
####################

estimates=../input/estimates/estimates_black_mainspec_bootstrap_clean.csv

dissim_residential= \
	../input/dissim_residential.csv \
	../input/dissim_pairwise_residential.csv \
	../input/dissimilarity_index_residential.csv \
	../input/dissimilarity_index_pairwise_residential.csv \
	../input/dissim_pairwise_tracts_mainspec.csv  \
	../input/dissim_tracts_mainspec.csv \
	../input/dissim_pairwise_venues_mainspec.csv \
	../input/dissim_venues_mainspec.csv \
	../input/dissim_pairwise_tracts_mintime.csv  \
	../input/dissim_tracts_mintime.csv \
	../input/dissim_pairwise_venues_mintime.csv \
	../input/dissim_venues_mintime.csv \

dissim_venue_mainspec_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_venue_mainspec_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_pairwise_venue_mainspec_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_pairwise_venue_mainspec_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_tract_mainspec_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_tract_mainspec_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_pairwise_tract_mainspec_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_pairwise_tract_mainspec_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_venue_mintime_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_venue_mintime_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_pairwise_venue_mintime_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_pairwise_venue_mintime_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_tract_mintime_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_tract_mintime_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

dissim_pairwise_tract_mintime_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/dissim_pairwise_tract_mintime_instance"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output = \
	../output/dissim_pairwise_tracts_merged.dta \
	../output/dissim_pairwise_venues_mainspec_merged.dta \
	../output/dissim_tracts_merged.dta \
	../output/dissim_venues_mainspec_merged.dta \
	../output/dissimilarity_tracts_mainspec.tex \
	../output/dissimilarity_venues_mainspec.tex \
	../output/dissim_pairwise_venues_mintime_merged.dta \
	../output/dissim_venues_mintime_merged.dta \
	../output/dissimilarity_venues_mintime.tex \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(estimates) $(dissim_residential) $(dissim_venue_mainspec_bootstrap) $(dissim_pairwise_venue_mainspec_bootstrap) $(dissim_tract_mainspec_bootstrap) $(dissim_pairwise_tract_mainspec_bootstrap) $(dissim_venue_mintime_bootstrap) $(dissim_pairwise_venue_mintime_bootstrap) $(dissim_tract_mintime_bootstrap) $(dissim_pairwise_tract_mintime_bootstrap) dissimilarity_stderr.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
