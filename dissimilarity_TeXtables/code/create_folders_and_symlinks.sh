#!/bin/bash


##Create folders
mkdir slurmlogs

##INPUT
mkdir -p ../input/{mintime,sixom}

##OUTPUT
mkdir -p ../output/{mintime,sixom}

##Create symbolic links

##RESIDENTIAL 
ln -s  ../../dissimilarity_computations/output/*.csv ../input/

for spec in sixom mintime 
do
	for file in ../../dissimilarity_computations/output/${spec}/*.csv
	do
		ln -s  ../${file} ../input/${spec}/
	done 
done	


