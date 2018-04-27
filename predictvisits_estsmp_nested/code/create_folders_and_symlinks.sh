#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,sixom},estsample_predictarray}

##OUTPUT
mkdir -p ../output/predictedvisits/{mintime,sixom}

##Create symbolic links

for spec in sixom mintime 
do 
	for file in ../../estimate_nestedlogit/output/estimates/${spec}/*nest*.csv
	do 
		ln -s ../../${file}  ../input/estimates/${spec}/		
	done 
done 

for file in ../../predictvisits_estsmp_arrays/output/*nest*.dta
do
	ln -s ../${file}  ../input/estsample_predictarray/
done

