#!/bin/bash

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

ln -s ../../isoindex_venueFE/code/isoindex_programs.do ./

for file in users_est.dta trips_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

ln -s ../../isoindex_specs/output/isolationindex_estsample.tex ../input/

for race in asian black whithisp 
do 
	ln -s ../../predictvisits_estsmp_betabsavg/output/predictedvisits_${race}_bsavg.csv ../input/
done





