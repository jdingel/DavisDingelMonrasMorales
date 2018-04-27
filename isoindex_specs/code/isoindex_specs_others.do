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

//Minimum-time specification: Compute model-predicted isolation index confidence interval
tempfile tf3 tf4
load_Pij_csv_dta, outputfile(`tf3') pathstub("../input/") ///
	file1("predictedvisits_asian_mintime.csv") ///
	file2("predictedvisits_black_mintime.csv") ///
	file3("predictedvisits_whithisp_mintime.csv") 

simulatevisits using `tf3', instances(`instances') outputfile(`tf4') trips_path("../input/trips_est.dta") users_path("../input/users_est.dta")

use `tf4', clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
save `tf4', replace
save "../output/simulatedtrips_mintime.dta", replace

isoindices_simulateddraws using `tf4', draws(`instances') ///
	dtaoutputfile("../output/isoindices_mintime.dta") tableoutputfile("../output/isoindices_mintime.tex") users_path("../input/users_est.dta")

//Pooled specification: Compute model-predicted isolation index confidence interval
tempfile tf5 tf6
load_Pij_csv_dta, outputfile(`tf5') pathstub("../input/") ///
	file1("predictedvisits_asian_pooled.csv") ///
	file2("predictedvisits_black_pooled.csv") ///
	file3("predictedvisits_whithisp_pooled.csv") 

simulatevisits using `tf5', instances(`instances') outputfile(`tf6') trips_path("../input/trips_est.dta") users_path("../input/users_est.dta")

use `tf6', clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
save `tf6', replace
save "../output/simulatedtrips_sixom_pooled.dta", replace

isoindices_simulateddraws using `tf6', draws(`instances') ///
	dtaoutputfile("../output/isoindices_sixom_pooled.dta") tableoutputfile("../output/isoindices_sixom_pooled.tex") users_path("../input/users_est.dta")


//Nested-logit specifications
forvalues i = 1/2 {
tempfile tf9_`i' tf10_`i'
load_Pij_csv_dta, outputfile(`tf9_`i'') pathstub("../input/") ///
	file1("predictedvisits_asian_sixom_nlogit_nest`i'.csv") ///
	file2("predictedvisits_black_sixom_nlogit_nest`i'.csv") ///
	file3("predictedvisits_whithisp_sixom_nlogit_nest`i'.csv") 

simulatevisits using `tf9_`i'', instances(`instances') outputfile(`tf10_`i'') trips_path("../input/trips_est.dta") users_path("../input/users_est.dta")

use `tf10_`i'', clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
save `tf10_`i'', replace
save "../output/simulatedtrips_sixom_nest`i'.dta", replace

isoindices_simulateddraws using `tf10_`i'', draws(`instances') ///
	dtaoutputfile("../output/isoindices_sixom_nest`i'.dta") tableoutputfile("../output/isoindices_sixom_nest`i'.tex") users_path("../input/users_est.dta")
}


exit, clear
