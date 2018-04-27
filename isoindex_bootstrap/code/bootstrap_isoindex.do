
//Created by: Jonathan Dingel
//Date: April 2018
//Description: Use P(d_ij=1|X_ij) from 500 bootstrap draws to produce 500 confidence intervals

clear all
set more off

//PROGRAM DEFINITIONS AND PACKAGES

foreach package in sutex2 {
	capture which `package'
	if _rc==111 ssc install `package'
}
qui do "bootstrap_isoindex_programs.do"

/**********************
** PROGRAM CALLS
***********************/

local instances = "`2'"
if "`3'"=="" local 3 = `1' + 10

forvalues i = `1'/`3' {

	tempfile tf`i'a tf`i'b
	load_Pij_csv_dta, outputfile(`tf`i'a') pathstub("../input/") ///
		file1("predictedvisits_asian_mainspec_`i'.csv") ///
		file2("predictedvisits_black_mainspec_`i'.csv") ///
		file3("predictedvisits_whithisp_mainspec_`i'.csv") 
	
	simulatevisits using `tf`i'a', instances(`instances') outputfile(`tf`i'b')
	
	use `tf`i'b', clear
	merge m:1 userid_num using "../input/users_est.dta", assert(using match) keepusing(asian black whithisp) keep(match) nogen
	save `tf`i'b', replace

	isoindices_simulateddraws using `tf`i'b', ///
		dtaoutputfile("../output/isoindices_`i'.dta") draws(`instances')
}

exit, clear
