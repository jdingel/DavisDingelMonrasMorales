#!/bin/bash

##Create folders
mkdir slurmlogs

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in users_est.dta trips_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

ln -s ../../isoindex_specs/output/isoindices_sixom_mainspec.dta ../input/isoindices_sixom_mainspec.dta

ln -s ../../estimate_MNL_specs_bootstrap/output/estimates/mainspec/estimates_black_mainspec_bootstrap_clean.csv	../input/

temp=`awk -F,  '{print $5}' ../input/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p`

for i in $temp
do 
	for race in asian black whithisp
	do 
		ln -s  ../../predictvisits_estsmp_bootstrap/output/mainspec/${race}/predictedvisits_${race}_mainspec_${i}.csv   ../input/
	done 
done 



