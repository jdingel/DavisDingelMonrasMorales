#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in traveltime_gain_new_line.dta tract_pairs_2010_characteristics_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done


for race in asian black whithisp
do 
	ln -s ../../estimate_MNL_specs/output/estimates/sixom/estimates_${race}_mainspec.csv ../input/
done 
