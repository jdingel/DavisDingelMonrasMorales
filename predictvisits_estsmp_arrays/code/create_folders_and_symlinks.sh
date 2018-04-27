#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

ln -s ../../estarrays_nestedlogit_DTAs/output/venues.dta ../input/

for file in  geoid11_home.dta geoid11_dest.dta geoid11_work_pair.dta geoid11_home_work.dta geoid11_home_pair.dta venues_est.dta users_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

ln -s ../../estarrays_DTAs/code/DATA_PREP_estarray_program.do ./
