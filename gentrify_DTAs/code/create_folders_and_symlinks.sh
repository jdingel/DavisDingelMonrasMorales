#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in tract_pairs_2010_characteristics_est.dta venues_est.dta geoid11_coords.dta tract_2010_characteristics_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

