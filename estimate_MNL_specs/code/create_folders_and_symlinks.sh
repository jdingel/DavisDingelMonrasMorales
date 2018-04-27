#!/bin/bash

##Create folders
mkdir slurmlogs
##INPUT
mkdir -p ../input/estarrays/{mintime,sixom,norg}

##OUTPUT
mkdir -p ../output/{estarrays_JLDs/{mintime,sixom,norg},estimates/{mintime,sixom,norg},tables/{mintime,sixom,norg}}

##Create symbolic links 
##SIXOM
for race in asian black whithisp
do
	ln -s ../../../../estarrays_DTAs/output/estarrays/sixom/estarray_${race}.dta ../input/estarrays/sixom/estarray_${race}.dta
	for array in spatial mainspec 100 50 carshare disaggcuis droploca fifth genderspecific half lateadopt locainfo1 locainfo2 revchain spatialage spatialgender spatialincome
	do
		ln -s ../../../../estarrays_DTAs/output/estarrays/sixom/estarray_${race}_${array}.dta ../input/estarrays/sixom/estarray_${race}_${array}.dta
	done
done

ln -s ../../../../estarrays_DTAs/output/estarrays/sixom/estarray_raceblind.dta ../input/estarrays/sixom/estarray_raceblind.dta

##NORG
for race in asian black whithisp
do
	ln -s ../../../../estarrays_DTAs/output/estarrays/norg/estarray_${race}_homeonly.dta ../input/estarrays/norg/estarray_${race}_homeonly.dta
	ln -s ../../../../estarrays_DTAs/output/estarrays/norg/estarray_${race}_homeonlysample.dta ../input/estarrays/norg/estarray_${race}_homeonlysample.dta
done

##MINTIME
for race in asian black whithisp
do
	for array in mainspec 100 50 carshare disaggcuis droploca fifth half lateadopt locainfo1 locainfo2 revchain spatialage spatialgender spatialincome
	do
		ln -s ../../../../estarrays_DTAs/output/estarrays/mintime/estarray_${race}_${array}.dta ../input/estarrays/mintime/estarray_${race}_${array}.dta
	done
done
