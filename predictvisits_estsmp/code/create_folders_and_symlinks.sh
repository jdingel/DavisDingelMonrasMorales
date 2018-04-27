#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for race in black asian whithisp
do
 	ln -s ../../estimate_MNL_specs/output/estimates/sixom/estimates_${race}_mainspec.csv ../input/estimates_${race}_mainspec.csv
 	ln -s ../../estimate_MNL_specs/output/estimates/mintime/estimates_${race}_mainspec.csv ../input/estimates_${race}_mintime.csv
done

ln -s ../../estimate_MNL_specs/output/estimates/sixom/estimates_raceblind.csv ../input/

for file in ../../predictvisits_estsmp_arrays/output/*.dta
do 
	ln -s ${file} ../input/
done