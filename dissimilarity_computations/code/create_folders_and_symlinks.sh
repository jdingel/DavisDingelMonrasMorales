#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/predictedvisits/{mintime,sixom}

##OUTPUT
mkdir -p ../output/{mintime,sixom}

##Create symbolic links
for spec in sixom mintime 
do
	for file in ../../predictvisits/output/predictedvisits/${spec}/*.jld
	do 
		ln -s  ../../${file} ../input/predictedvisits/${spec}/
	done 
done 

ln -s   ../../initialdata/output/tract_2010_characteristics_est.dta ../input/tract_2010_characteristics_est.dta
