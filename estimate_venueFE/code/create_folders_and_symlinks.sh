#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/{estarrays/{mintime,sixom},estimates/{mintime,sixom}}

##OUTPUT
mkdir -p ../output/{estarrays_JLDs/{mintime,sixom},estimates/{mintime,sixom},tables/{mintime,sixom}}

##Create symbolic links
for race in black asian whithisp
do
##SIXOM
	ln -s ../../../../estarrays_venueFE_DTAs/output/estarray_venueFE_${race}.dta ../input/estarrays/sixom/estarray_venueFE_${race}.dta 
	ln -s ../../../../estimate_MNL_specs/output/estimates/sixom/estimates_${race}_mainspec.csv ../input/estimates/sixom/estimates_${race}_mainspec.csv

##MINTIME
	ln -s ../../../../estarrays_venueFE_DTAs/output/estarray_venueFE_mintime_${race}.dta ../input/estarrays/mintime/estarray_venueFE_mintime_${race}.dta
	ln -s ../../../../estimate_MNL_specs/output/estimates/mintime/estimates_${race}_mainspec.csv ../input/estimates/mintime/estimates_${race}_mainspec.csv
done


