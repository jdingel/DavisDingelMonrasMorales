#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links
for race in black asian whithisp
do
ln -s  ../../predictvisits_estsmp_arrays/output/estsample_predictarray_${race}_sixom.dta   ../input/
ln -s  ../../estimate_MNL_specs_bootstrap/output/estimates/mainspec/estimates_${race}_mainspec_bootstrap_avg.csv ../input/
done 
