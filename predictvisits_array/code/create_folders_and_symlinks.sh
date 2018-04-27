#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/{JLDs,predictedvisitsarray}/

##Create symbolic links
for file in top_workplaces_5.dta tract_pairs_2010_characteristics_est.dta tract_2010_characteristics_est.dta
do
ln -s  ../../initialdata/output/${file} ../input/
done

ln -s ../../estarrays_nestedlogit_DTAs/output/venues.dta ../input/
