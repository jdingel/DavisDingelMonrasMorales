/***********************
** METADATA
***********************/

/****
Created by: Jonathan Dingel
Date: April 2018
Description: Use P(d_ij=1|X_ij) from main specification to produce leave-out isolation index confidence interval
****/

/***********************
** COMPUTING RESOURCES
***********************/

clear all
set more off

local instances = 500

/**********************
** PROGRAM DEFINITIONS
***********************/

foreach package in sutex2 {
	capture which `package'
	if _rc==111 ssc install `package'
}
qui do "isoindex_programs.do"

/**********************
** PROGRAM CALLS
***********************/
//Compute isolation indices for 
//Bootstrapped-parameters average: Main specification

tempfile tf7 tf8
load_Pij_csv_dta, outputfile(`tf7') pathstub("../input/") ///
	file1("predictedvisits_asian_bsavg.csv") file2("predictedvisits_black_bsavg.csv") file3("predictedvisits_whithisp_bsavg.csv")

simulatevisits using `tf7', instances(`instances') outputfile(`tf8')  trips_path("../input/trips_est.dta") users_path("../input/users_est.dta")

use `tf8', clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
save `tf8', replace
save "../output/simulatedtrips_bsavg.dta", replace

isoindices_simulateddraws using `tf8', draws(`instances') ///
	dtaoutputfile("../output/isoindices_bsavg.dta") tableoutputfile("../output/isoindices_bsavg.tex") users_path("../input/users_est.dta")

exit, clear
	