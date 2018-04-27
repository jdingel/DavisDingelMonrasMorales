#!/bin/bash

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/

##Create symbolic links
for file in users_est.dta trips_est.dta
do 
	ln -s ../../initialdata/output/${file} ../input/
done

for race in asian black whithisp 
do 
	ln -s ../../predictvisits_estsmp/output/predictedvisits_${race}_mainspec.csv ../input/

	ln -s  ../../predictvisits_estsmp/output/predictedvisits_${race}_pooled.csv  ../input/

	ln -s  ../../predictvisits_estsmp/output/predictedvisits_${race}_mintime.csv ../input/
done 








