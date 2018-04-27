#!/bin/bash

##Create folders
##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/{choicesets,estarrays/{mintime,norg,sixom,fastestmode}}

##Create symbolic links

for file in geoid11_home_work.dta geoid11_work_pair.dta geoid11_home_pair.dta geoid11_home.dta geoid11_dest.dta trips_est.dta venues_est.dta choiceset_all.dta choiceset_50.dta choiceset_100.dta choiceset_homeonly.dta tract_pairs_2010_characteristics_est.dta choiceset_droploca.dta users_est.dta users_homeonlysample.dta tract_2010_characteristics_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

