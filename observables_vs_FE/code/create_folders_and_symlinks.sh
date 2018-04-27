#!/bin/bash


##Create folders
mkdir slurmlogs 

##INPUT
mkdir -p ../input/{estarrays/{mintime,sixom},estimates/{mintime,sixom},estsample_predictarray/{mintime,sixom}}

##OUTPUT
mkdir -p ../output/{results/{mintime,sixom},tables/{mintime,sixom}}

##Create symbolic links
ln -s ../../initialdata/output/trips_est.dta ../input/trips_est.dta

for race in black asian whithisp
do

ln -s ../../../../estarrays_venueFE_DTAs/output/estarray_venueFE_mintime_${race}.dta ../input/estarrays/mintime/
ln -s ../../../../estarrays_venueFE_DTAs/output/estarray_venueFE_${race}.dta ../input/estarrays/sixom/

ln -s ../../../../estimate_venueFE/output/estimates/mintime/estimates_venueFE_${race}_mintime.csv ../input/estimates/mintime/
ln -s ../../../../estimate_MNL_specs/output/estimates/mintime/estimates_${race}_mainspec.csv ../input/estimates/mintime/

ln -s ../../../../estimate_venueFE/output/estimates/sixom/estimates_venueFE_${race}_sixom.csv ../input/estimates/sixom/
ln -s ../../../../estimate_MNL_specs/output/estimates/sixom/estimates_${race}_mainspec.csv ../input/estimates/sixom/

ln -s ../../../../predictvisits_estsmp_arrays/output/estsample_predictarray_${race}_mintime.dta ../input/estsample_predictarray/mintime/
ln -s ../../../../predictvisits_estsmp_arrays/output/estsample_predictarray_${race}_sixom.dta ../input/estsample_predictarray/sixom/

done
