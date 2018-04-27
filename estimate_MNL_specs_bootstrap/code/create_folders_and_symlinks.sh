#!/bin/bash

##Create folders
mkdir slurmlogs

##INPUT
mkdir -p ../input/{estarrays/{mainspec,mintime},estimates/{mainspec,mintime}}

##OUTPUT
mkdir -p ../output/{estarrays_JLDs/{mintime,mainspec},estimates/{mintime,mainspec},tables/{mintime,mainspec},figures/{mintime,mainspec}}

##Create symbolic links

##################
#	Mainspec
##################

##Links to estimates
for file in ../../estimate_MNL_specs/output/estimates/sixom/*mainspec.csv
do
	ln -s  ../../${file}    ../input/estimates/mainspec/
done


##Links to estarrays
for file in ../../bootstrap_estarrays/output/mainspec/*.dta
do
	ln -s  ../../${file}    ../input/estarrays/mainspec/
done


##################
#	Mintime
##################

##Links to estimates
for file in ../../estimate_MNL_specs/output/estimates/mintime/*mainspec.csv
do
	ln -s  ../../${file}    ../input/estimates/mintime/
done


##Links to estarrays
for file in ../../bootstrap_estarrays/output/mintime/*.dta
do
	ln -s  ../../${file}    ../input/estarrays/mintime/
done

