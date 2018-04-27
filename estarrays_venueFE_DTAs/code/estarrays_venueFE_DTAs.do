//Created by: Jonathan Dingel
//Date: April 2018

clear all
set more off

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "estarrays_venueFE_programs.do"

/***********************
** PROGRAM CALLS
***********************/

tempfile tf0 tf_choiceset_asian tf_choiceset_black tf_choiceset_whithisp
use "../input/choiceset_all_posvis.dta", clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
gsort userid_num tripnumber -chosen venue_num
save `tf0', replace
foreach race in asian black whithisp {
	use if `race'==1 using `tf0', clear
	drop asian black whithisp
	save `tf_choiceset_`race''
	estarray_venueFE_racespecific using `tf_choiceset_`race'', saveas("../output/estarray_venueFE_`race'.dta") 
}


//Mintime specification

foreach race in asian black whithisp {
	use "../output/estarray_venueFE_`race'.dta", clear
	egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
	drop time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log
	saveold "../output/estarray_venueFE_mintime_`race'.dta", replace version(11)
}

exit, clear
