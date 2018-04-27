#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/{JLDs,predictedvisitsarray/{2ndAve,slowdown}}

##Create symbolic links
for file in tract_pairs_slowdown.dta tract_pairs_2ndAve.dta
do
ln -s 	../../counterfactuals_DTAs/output/${file}	../input/${file}
done

for file in tract_2010_characteristics_est.dta top_workplaces_5.dta
do
ln -s ../../initialdata/output//${file}	../input/${file}
done

ln -s ../../estarrays_nestedlogit_DTAs/output/venues.dta	../input/venues.dta
