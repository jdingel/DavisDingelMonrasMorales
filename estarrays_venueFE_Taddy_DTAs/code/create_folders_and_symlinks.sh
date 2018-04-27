#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in geoid11_work_pair.dta geoid11_home_work.dta geoid11_home_pair.dta geoid11_home.dta geoid11_dest.dta venues_est.dta tract_pairs_2010_characteristics_est.dta tract_2010_characteristics_est.dta users_est.dta trips_est.dta
do
	ln -s ../../initialdata/output/${file} ../input/
done


ln -s ../../estarrays_venueFE_DTAs/code/estarrays_venueFE_programs.do ./


