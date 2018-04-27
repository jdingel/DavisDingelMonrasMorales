#!/bin/bash


##Create folders
mkdir slurmlogs
##INPUT
mkdir -p ../input/{estimates,predvisitsarray}

##OUTPUT
mkdir -p ../output/{JLDs,predictedvisits,predvisitsarray,tables}

##Create symbolic links

for file in ../../predictvisits_array/output/JLDs/*.jld
do
	ln -s 	${file} ../input/
done

for file in ../../gentrify_DTAs/output/*.dta
do
	ln -s ${file} ../input/
done

ln -s ../../../estimate_MNL_specs/output/estimates/sixom/estimates_black_mainspec.csv  ../input/estimates/estimates_black_mainspec.csv

for file in ../../predictvisits_array/output/predictedvisitsarray/*.jld
do
	ln -s ../${file}  ../input/predvisitsarray/
done
