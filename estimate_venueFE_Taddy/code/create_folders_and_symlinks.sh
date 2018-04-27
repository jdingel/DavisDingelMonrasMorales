#!/bin/bash

##Create SLURMLOGS folder
mkdir slurmlogs

##Create folders
##INPUT
mkdir -p ../input/estarrays/

##OUTPUT
mkdir -p ../output/{estarrays_JLDs,estimates,tables}

##Create symbolic links
for race in black asian whithisp
do
	ln -s ../../../estarrays_venueFE_Taddy_DTAs/output/estarray_venueFE_Taddy_${race}.dta ../input/estarrays/estarray_venueFE_Taddy_${race}.dta
done
