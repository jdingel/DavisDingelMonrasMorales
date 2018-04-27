/***********************
** METADATA
***********************/

/****
Created by: Jonathan Dingel
Date: April 2018
Description: Use P(d_ij=1|X_ij) from main specification to produce leave-out isolation index confidence interval
Notes: 500 instances takes about 8-10 hours for each specification
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


//Compute isolation indices for estimation sample 
tempfile tf0 tf_isolation_estsample
use userid venue_num using "../input/trips_est.dta", clear
merge m:1 userid using "../input/users_est.dta", assert(match) keepusing(asian black whithisp race_nd) nogen
drop if race_nd==1
bys venue_num: egen venue_visits = total(1)
rename venue_num venue //isolation_compute assumes that it is called "venue"
save `tf0', replace
foreach race in black asian whithisp {
	isolation_compute using `tf0', race(`race')
	gen instance = 1
	if "`race'"!="black" merge 1:1 instance using `tf_isolation_estsample', update nogen
	save `tf_isolation_estsample', replace
}
iso_index_varlabels
sutex2 iso_*_lvout, varlabels saving("../output/isolationindex_estsample.tex") tabular replace


//Main specification: Compute model-predicted isolation index confidence interval
tempfile tf1 tf2
load_Pij_csv_dta, outputfile(`tf1') pathstub("../input/") ///
	file1("predictedvisits_asian_mainspec.csv") ///
	file2("predictedvisits_black_mainspec.csv") ///
	file3("predictedvisits_whithisp_mainspec.csv") 

simulatevisits using `tf1', instances(`instances') outputfile(`tf2') trips_path("../input/trips_est.dta") users_path("../input/users_est.dta")

use `tf2', clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
save `tf2', replace
save "../output/simulatedtrips_mainspec.dta", replace

isoindices_simulateddraws using `tf2', draws(`instances') ///
	dtaoutputfile("../output/isoindices_sixom_mainspec.dta") tableoutputfile("../output/isoindices_sixom_mainspec.tex") users_path("../input/users_est.dta")

exit, clear
