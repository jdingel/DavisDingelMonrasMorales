#!/bin/bash

##Create folders
##OUTPUT
mkdir -p ../output/

##Create symbolic links
for file in ../input/*dta 
do 
	ln -s  ${file}   ../output/
done 

