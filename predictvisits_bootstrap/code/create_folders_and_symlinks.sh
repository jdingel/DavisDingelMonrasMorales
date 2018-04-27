#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,mainspec},JLDs,predictedvisitsarray}

##OUTPUT
mkdir -p ../output/predictedvisits/{mintime,mainspec}

##Create symbolic links
ln -s   ../../../predictvisits_array/output/JLDs/top_workplaces_5.jld ../input/JLDs/


for spec in mainspec mintime 
do 
	for file in ../../estimate_MNL_specs_bootstrap/output/estimates/${spec}/*clean.csv
	do 
		ln -s ../../${file}  ../input/estimates/${spec}/		
	done 
done 

for file in ../../predictvisits_array/output/predictedvisitsarray/*.jld
do
	ln -s ../${file}  ../input/predictedvisitsarray/
done

