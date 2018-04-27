#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links
ln -s ../../initialdata/output/tract_2010_characteristics_est.dta ../input/tract_characteristics.dta

for file in geoid11_home_work.dta geoid11_work_pair.dta geoid11_home_pair.dta geoid11_home.dta geoid11_dest.dta tract_pairs_2010_characteristics_est.dta tract_2010_characteristics_est.dta venues_est.dta users_est.dta choiceset_all_posvis.dta
do
	ln -s ../../initialdata/output/${file} ../input/
done

