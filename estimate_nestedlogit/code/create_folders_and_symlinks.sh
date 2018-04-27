#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estarrays/{mintime,sixom},estimates/{mintime,sixom}}

##OUTPUT
mkdir -p ../output/{estarrays_JLDs/{mintime,sixom},estimates/{mintime,sixom},tables/{mintime,sixom}}

##Create symbolic links

for spec in mintime sixom
do
	for file in ../../estarrays_nestedlogit_DTAs/output/${spec}/*.dta
	do 
		ln -s ../../${file} ../input/estarrays/${spec}/
	done 
done

for spec in mintime sixom
do
	for file in ../../estimate_MNL_specs/output/estimates/${spec}/*mainspec.csv
	do 
		ln -s ../../${file} ../input/estimates/${spec}/
	done 
done
