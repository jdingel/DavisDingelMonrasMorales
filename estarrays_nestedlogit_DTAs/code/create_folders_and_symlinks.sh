#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/{sixom,mintime}

##Create symbolic links
ln -s ../../initialdata/output/tract_2010_characteristics_est.dta ../input/tract_characteristics.dta

for file in geoid11_home_work.dta geoid11_work_pair.dta geoid11_home_pair.dta geoid11_home.dta geoid11_dest.dta venues_est.dta tract_pairs_2010_characteristics_est.dta users_est.dta tract_2010_characteristics_est.dta
do
	ln -s ../../initialdata/output/${file} ../input/
done

for file in choiceset_black.dta choiceset_asian.dta choiceset_whithisp.dta
do
	ln -s  ../../estarrays_DTAs/output/choicesets/${file} ../input/
done

ln -s ../../estarrays_DTAs/code/DATA_PREP_estarray_program.do ./

