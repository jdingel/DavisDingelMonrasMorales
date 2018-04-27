#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,mainspec},estsample_predictarray/{mintime,mainspec}}

##OUTPUT
mkdir -p ../output/{mintime/{asian,black,whithisp},mainspec/{asian,black,whithisp}}

##Create symbolic links

for spec in mainspec mintime
do
	for file in ../../estimate_MNL_specs_bootstrap/output/estimates/${spec}/*clean.csv
	do
		ln -s ../../${file}  ../input/estimates/${spec}/
	done
done

for file in ../../predictvisits_estsmp_arrays/output/*sixom.dta
do
	ln -s ../../${file}  ../input/estsample_predictarray/mainspec/
done

for file in ../../predictvisits_estsmp_arrays/output/*mintime.dta
do
	ln -s ../../${file}  ../input/estsample_predictarray/mintime/
done
