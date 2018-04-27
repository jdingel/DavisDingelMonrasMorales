#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input

##OUTPUT
mkdir -p ../output/

##Create symbolic links
for spec in sixom mintime 
do 
	ln -s ../../dissimilarity_computations/output/${spec}/dissimilarity_index_venue_level_${spec}_mainspec.csv ../input/
done

for files in dissim_venues_mintime_merged.dta dissim_venues_mainspec_merged.dta dissim_tracts_merged.dta dissim_pairwise_venues_mainspec_merged.dta dissim_pairwise_tracts_merged.dta
do 
	ln -s ../../dissimilarity_stderr/output/${files} ../input/
done



