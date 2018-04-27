#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,sixom},JLDs,predictedvisitsarray/{socialchange,2ndAve,slowdown}}

##OUTPUT
mkdir -p ../output/predictedvisits/{mintime,sixom}

##Create symbolic links
for file in ../../predictvisits_counterfactuals_arrays/output/JLDs/*.jld
do
	ln -s ../${file} ../input/JLDs/
done

for cftl in 2ndAve slowdown
do
	for file in ../../predictvisits_counterfactuals_arrays/output/predictedvisitsarray/${cftl}/*.jld
	do
		ln -s ../../${file}  ../input/predictedvisitsarray/${cftl}/
	done
done

for file in ../../predictvisits_array/output/predictedvisitsarray/*.jld
do
	ln -s ../../${file}  ../input/predictedvisitsarray/socialchange/
done


for spec in sixom mintime
do
for file in ../../estimate_MNL_specs/output/estimates/${spec}/*mainspec.csv
do
	ln -s ../../${file} ../input/estimates/${spec}/
done
done

for file in ../../counterfactuals_DTAs/output/*.csv
do
	ln -s  ../../${file} ../input/estimates/sixom/
done
