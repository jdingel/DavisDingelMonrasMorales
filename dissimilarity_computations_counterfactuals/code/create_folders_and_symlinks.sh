#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/predictedvisits/{mintime,sixom}

##OUTPUT
mkdir -p ../output/{mintime,sixom}

##Create symbolic links

for file in ../../predictvisits_counterfactuals/output/predictedvisits/sixom/*.jld
do 
	ln -s  ../../${file} ../input/predictedvisits/sixom/
done 

ln -s   ../../initialdata/output/tract_2010_characteristics_est.dta ../input/tract_2010_characteristics_est.dta


