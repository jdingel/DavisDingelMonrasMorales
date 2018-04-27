//Created by: Jonathan Dingel
//Date: April 2018

set more off

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "DATA_PREP_estarray_program.do"

cap program drop predvisitsarray_estsmp_generic
program define predvisitsarray_estsmp_generic

	syntax, race(string) saveas(string) [nestidvar(string)] [dropvars(string)]

	if "`dropvars'"!="" local dropvars = "dropvars(`dropvars')"
	if "`nestidvar'"!="" local prepcovariateoptions = "prepcovariateoptions(nestid(`nestidvar'))"

	//Create choice set with all user-venue combinations
	tempfile tf1
	use userid_num asian black whithisp if `race'==1 using "../input/users_est.dta", clear
	cross using "../input/venues.dta" //This file was produced by estarrays_nestedlogit_DTAs.do
	keep userid_num venue_num `nestidvar'
	gen byte tripnumber = 1
	gen byte chosen = 1 //This is necessary given how my prepcovariates.do program checks for colinearity problems
	save `tf1'
	
	//Generate the predicted visits array
	estarray_racespecific using `tf1', saveas(`saveas') `prepcovariateoptions' `dropvars'

end

/***********************
** PROGRAM CALLS
***********************/

//Six origin-mode specification
foreach race in asian black whithisp {
	predvisitsarray_estsmp_generic, race(`race') saveas("../output/estsample_predictarray_`race'_sixom.dta") dropvars(reviews chain)
}

//Minimum-time specification
foreach race in asian black whithisp {
	use "../output/estsample_predictarray_`race'_sixom.dta", clear
	egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
	drop time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log
	save "../output/estsample_predictarray_`race'_mintime.dta", replace 
}

//Nested-logit specifications
foreach race in asian black whithisp {
	forvalues i = 1/2 {
		predvisitsarray_estsmp_generic, race(`race') nestidvar(nest`i') saveas("../output/estsample_predictarray_`race'_nest`i'.dta") dropvars(reviews chain)
	}
}

exit, clear
