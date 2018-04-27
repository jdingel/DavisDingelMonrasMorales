#!/bin/bash

##Create folders
mkdir slurmlogs
##INPUT
mkdir -p ../input/predictedvisits

##OUTPUT
mkdir -p ../output/

##Create symbolic links

for file in ../../predictvisits/output/predictedvisits/sixom/*sixom_mainspec.jld
do
	ln -s   ../${file}  ../input/predictedvisits/
done

for file in tracts.dta geoid11_coords.dta tract_2010_characteristics_est.dta dotmap_zoomcuts.dta dotmap_labels_harlem.dta dotmap_labels_bklyn.dta
do 
ln -s ../../initialdata/output/${file}	../input/${file}
done 
