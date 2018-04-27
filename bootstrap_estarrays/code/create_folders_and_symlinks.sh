#!/bin/bash

##Create folders

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/{mainspec,mintime,mintime_temp}

##Create symbolic links

for file in geoid11_home_work.dta geoid11_work_pair.dta geoid11_home_pair.dta geoid11_home.dta geoid11_dest.dta users_est.dta tract_pairs_2010_characteristics_est.dta tract_2010_characteristics_est.dta venues_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done


for file in simulatedtrips_mainspec.dta simulatedtrips_mintime.dta
do 

	ln -s ../../isoindex_specs/output/${file} ../input/
done 


for file in DATA_PREP_estarray_program.do
do 
	ln -s ../../estarrays_DTAs/code/${file} ./
done 	


