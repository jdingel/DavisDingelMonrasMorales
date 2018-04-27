#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estimates/{mintime,sixom},JLDs,predictedvisitsarray}

##OUTPUT
mkdir -p ../output/predictedvisits/{mintime,sixom}

##Create symbolic links
for file in ../../predictvisits_array/output/JLDs/*.jld
do
	ln -s ../${file} ../input/JLDs/
done

for file in ../../predictvisits_array/output/predictedvisitsarray/*.jld
do
	ln -s ../${file}  ../input/predictedvisitsarray/
done

for spec in sixom mintime
do
for file in ../../estimate_MNL_specs/output/estimates/${spec}/*.csv
do
	ln -s ../../${file} ../input/estimates/${spec}/
done

for file in ../../estimate_nestedlogit/output/estimates/${spec}/*.csv
do
	ln -s ../../${file} ../input/estimates/${spec}/
done
done
