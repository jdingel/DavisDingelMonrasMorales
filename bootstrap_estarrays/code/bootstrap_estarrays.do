/***********************
** METADATA
***********************/

/****
Created by: Jonathan Dingel
Date: November 2017
Purpose: Generate estimation arrays for simulated draws from predicted visits
****/

clear all
set more off

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "choiceset_program.do"
qui do "DATA_PREP_estarray_program.do"
qui do "bootstrap_arraymaker_programs.do"

/***********************
** PROGRAM CALLS
***********************/

if "`1'"=="" local start = 1
if "`1'"=="" local instances = 500
if "`1'"!="" local start = `1'
if "`1'"!="" local instances = `1' + 49

estarray_bootstrapdraws using "../input/simulatedtrips_mainspec.dta", ///
	instances(`instances') outputfolder("../output/mainspec") start(`start')

estarray_bootstrapdraws using "../input/simulatedtrips_mintime.dta", ///
	instances(`instances') outputfolder("../output/mintime_temp") start(`start')


forvalues i=`start'/`instances' {
foreach race in asian black whithisp {
	    use "../output/mintime_temp/`race'_`i'.dta", clear
	    egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
	    drop time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log
	    save "../output/mintime/`race'_`i'.dta", replace
     }
}

exit, clear
