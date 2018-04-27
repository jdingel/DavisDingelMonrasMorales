#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,mainspec},predictedvisits/{mintime,mainspec}}

##OUTPUT
mkdir -p ../output/{mintime,mainspec}

##Create symbolic links
ln -s   ../../initialdata/output/tract_2010_characteristics_est.dta ../input/tract_2010_characteristics_est.dta

for spec in mainspec mintime
do
	for file in ../../predictvisits_bootstrap/output/predictedvisits/${spec}/*.jld
	do
		ln -s  ../../${file} ../input/predictedvisits/${spec}/
	done
done

for spec in mainspec mintime
do
	for file in ../../estimate_MNL_specs_bootstrap/output/estimates/${spec}/*clean.csv
	do
		ln -s ../../${file}  ../input/estimates/${spec}/
	done
done
