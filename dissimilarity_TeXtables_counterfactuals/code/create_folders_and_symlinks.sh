#!/bin/bash

##Create folders
mkdir slurmlogs
##INPUT
mkdir -p ../input/{mintime,sixom}

##OUTPUT
mkdir -p ../output/{mintime,sixom}

##Create symbolic links
for file in ../../dissimilarity_computations_counterfactuals/output/sixom/*.csv
do
	ln -s  ../${file} ../input/sixom/
done


for file in ../../dissimilarity_computations/output/sixom/*mainspec*.csv
do 
	ln -s  ../${file} ../input/sixom/
done 

