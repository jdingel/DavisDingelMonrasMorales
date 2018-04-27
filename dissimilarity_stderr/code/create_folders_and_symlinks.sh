#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/estimates

##OUTPUT
mkdir -p ../output/

##Create symbolic links
ln -s ../../dissimilarity_computations/output/dissimilarity_index_residential.csv ../input/dissim_residential.csv
ln -s ../../dissimilarity_computations/output/dissimilarity_index_pairwise_residential.csv ../input/dissim_pairwise_residential.csv
ln -s ../../dissimilarity_computations/output/dissimilarity_index_residential.csv ../input/dissimilarity_index_residential.csv
ln -s ../../dissimilarity_computations/output/dissimilarity_index_pairwise_residential.csv ../input/dissimilarity_index_pairwise_residential.csv

ln -s ../../dissimilarity_computations/output/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec.csv ../input/dissim_pairwise_tracts_mainspec.csv 
ln -s ../../dissimilarity_computations/output/sixom/dissimilarity_index_tract_level_sixom_mainspec.csv ../input/dissim_tracts_mainspec.csv
ln -s ../../dissimilarity_computations/output/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec.csv ../input/dissim_pairwise_venues_mainspec.csv
ln -s ../../dissimilarity_computations/output/sixom/dissimilarity_index_venue_level_sixom_mainspec.csv ../input/dissim_venues_mainspec.csv

ln -s ../../dissimilarity_computations/output/mintime/dissimilarity_index_pairwise_tract_level_mintime_mainspec.csv ../input/dissim_pairwise_tracts_mintime.csv 
ln -s ../../dissimilarity_computations/output/mintime/dissimilarity_index_tract_level_mintime_mainspec.csv ../input/dissim_tracts_mintime.csv
ln -s ../../dissimilarity_computations/output/mintime/dissimilarity_index_pairwise_venue_level_mintime_mainspec.csv ../input/dissim_pairwise_venues_mintime.csv
ln -s ../../dissimilarity_computations/output/mintime/dissimilarity_index_venue_level_mintime_mainspec.csv ../input/dissim_venues_mintime.csv

ln -s ../../../estimate_MNL_specs_bootstrap/output/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv ../input/estimates/

temp_black_mainspec=`awk -F,  '{print $5}' ../input/estimates/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p|  tr "\n" " "`

for i in $temp_black_mainspec
do 
	ln -s ../../dissimilarity_computations_bootstrap/output/mainspec/dissimilarity_index_venue_level_instance${i}_mainspec.csv ../input/dissim_venue_mainspec_instance${i}.csv
	ln -s ../../dissimilarity_computations_bootstrap/output/mainspec/dissimilarity_index_pairwise_venue_level_instance${i}_mainspec.csv ../input/dissim_pairwise_venue_mainspec_instance${i}.csv

	ln -s ../../dissimilarity_computations_bootstrap/output/mainspec/dissimilarity_index_tract_level_instance${i}_mainspec.csv ../input/dissim_tract_mainspec_instance${i}.csv
	ln -s ../../dissimilarity_computations_bootstrap/output/mainspec/dissimilarity_index_pairwise_tract_level_instance${i}_mainspec.csv ../input/dissim_pairwise_tract_mainspec_instance${i}.csv
done

ln -s ../../../estimate_MNL_specs_bootstrap/output/estimates/mintime/estimates_black_mintime_bootstrap_clean.csv ../input/estimates/

temp_black_mintime=`awk -F,  '{print $5}' ../input/estimates/estimates_black_mintime_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p|  tr "\n" " "`

for i in $temp_black_mintime
do 
	ln -s ../../dissimilarity_computations_bootstrap/output/mintime/dissimilarity_index_venue_level_instance${i}_mintime.csv ../input/dissim_venue_mintime_instance${i}.csv
	ln -s ../../dissimilarity_computations_bootstrap/output/mintime/dissimilarity_index_pairwise_venue_level_instance${i}_mintime.csv ../input/dissim_pairwise_venue_mintime_instance${i}.csv

	ln -s ../../dissimilarity_computations_bootstrap/output/mintime/dissimilarity_index_tract_level_instance${i}_mintime.csv ../input/dissim_tract_mintime_instance${i}.csv
	ln -s ../../dissimilarity_computations_bootstrap/output/mintime/dissimilarity_index_pairwise_tract_level_instance${i}_mintime.csv ../input/dissim_pairwise_tract_mintime_instance${i}.csv
done