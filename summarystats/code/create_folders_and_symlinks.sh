#!/bin/bash

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in users_est.dta trips_est.dta venues_est.dta tract_2010_characteristics_est.dta tract_pairs_2010_characteristics_est.dta trips_nonloc.dta users_nonloc.dta venues_alltripsstats.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

ln -s ../../estarrays_DTAs/output/estarrays/sixom/estarray_raceblind.dta ../input/

