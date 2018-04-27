//Created by: Jonathan Dingel
//Date: August 2017

clear all
set more off

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "DATA_PREP_estarray_program.do"

/***********************
** PROGRAM CALLS
***********************/

//Generate race-specific choice sets 
tempfile tf0 tf1 tf2 tf3

use "../input/choiceset_all.dta", clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
gsort userid_num tripnumber -chosen venue_num
save `tf0', replace
foreach race in asian black whithisp {
	use if `race'==1 using `tf0', clear
	drop asian black whithisp
	save "../output/choicesets/choiceset_`race'.dta", replace
}
use "../input/choiceset_50.dta", clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
gsort userid_num tripnumber -chosen venue_num
save `tf1', replace
foreach race in asian black whithisp {
	use if `race'==1 using `tf1', clear
	drop asian black whithisp
	save "../output/choicesets/choiceset_`race'_50.dta", replace
}
use "../input/choiceset_100.dta", clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
gsort userid_num tripnumber -chosen venue_num
save `tf2', replace
foreach race in asian black whithisp {
	use if `race'==1 using `tf2', clear
	drop asian black whithisp
	save "../output/choicesets/choiceset_`race'_100.dta", replace
}

use "../input/choiceset_droploca.dta", clear
merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
gsort userid_num tripnumber -chosen venue_num
save `tf0', replace
foreach race in asian black whithisp {
	use if `race'==1 using `tf0', clear
	drop asian black whithisp
	save "../output/choicesets/choiceset_`race'_droploca.dta", replace
}

//Generate estimation arrays

foreach race in asian black whithisp {
	//Generate estimation array
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'.dta") prepcovariateoptions(vehicle_avail_hhshare_diff)
	//Generate an array with income-spatial interactions:
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'_spatialincome.dta") prepcovariateoptions(spatial_income) dropvars(chain reviews_log)
	//Generate an array with age-spatial interactions:
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'_spatialage.dta") prepcovariateoptions(spatial_age) dropvars(chain reviews_log)
	//Generate an array with gender-spatial interactions:
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'_spatialgender.dta") prepcovariateoptions(spatial_gender) dropvars(chain reviews_log)
	//Generate an array with gender-specific coefficients:
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'_genderspecific.dta") prepcovariateoptions(gender_specific) dropvars(chain reviews_log)
	//More disaggregated cuisine categories
	estarray_racespecific using "../output/choicesets/choiceset_`race'.dta", saveas("../output/estarrays/sixom/estarray_`race'_disaggcuis.dta") prepcovariateoptions(cuisinetype_midaggregate)
}


foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'_disaggcuis.dta", clear
	drop chain reviews_log d_cuisine_?
	saveold "../output/estarrays/sixom/estarray_`race'_disaggcuis.dta", replace version(11)
}

//Table 2, col 1-3: Spatial frictions + Table A.3: Spatial frictions with home, work, and commuting-path origins
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	drop chain reviews_log eucl_demo* spectralsegregationindex *_percent robberies_0711_perres vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_spatial.dta", replace version(11)
}

//Table 2, col 4-6: Spatial and social frictions
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	drop chain reviews_log vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_mainspec.dta", replace version(11)
}

//Tables A.4 - A.6: Robustness checks for six-origin-mode specifications
//Varying choice set sizes
foreach race in asian black whithisp {
	estarray_racespecific using "../output/choicesets/choiceset_`race'_50.dta", saveas("../output/estarrays/sixom/estarray_`race'_50.dta") dropvars(chain reviews_log)
	estarray_racespecific using "../output/choicesets/choiceset_`race'_100.dta", saveas("../output/estarrays/sixom/estarray_`race'_100.dta") dropvars(chain reviews_log)
}
//Estimates using only users’ early reviews (needs to be first half and first fifth!)
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	by userid_num: egen trips = max(tripnumber)
	keep if inrange(tripnumber,1,trips/2)
	drop chain reviews_log trips vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_half.dta", replace version(11)
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	by userid_num: egen trips = max(tripnumber)
	keep if inrange(tripnumber,1,trips/5)
	drop chain reviews_log trips vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_fifth.dta", replace version(11)
}
//Dropping the 5% of restaurant reviews used to locate users
foreach race in asian black whithisp {
estarray_racespecific using "../output/choicesets/choiceset_`race'_droploca.dta", saveas("../output/estarrays/sixom/estarray_`race'_droploca.dta") dropvars(chain reviews_log)
}

//Split subsamples of users that differ in the number of Yelp reviews revealing their locational information yields similar estimates across these subsamples
foreach race in asian black whithisp {
	tempfile tf_`race'
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) keepusing(home_venues) nogen
	save `tf_`race'', replace
	keep if inrange(home_venues,1,2)
	drop chain reviews_log vehicle_avail_hhshare_diff home_venues
	saveold "../output/estarrays/sixom/estarray_`race'_locainfo1.dta", replace version(11)
	use `tf_`race'', clear
	keep if inrange(home_venues,3,.)
	drop chain reviews_log vehicle_avail_hhshare_diff home_venues
	saveold "../output/estarrays/sixom/estarray_`race'_locainfo2.dta", replace version(11)
}
//Late-adopters subsample
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) keepusing(firstreviewdate) nogen
	drop if inrange(firstreviewdate,1,17836.5)
	drop chain reviews_log firstreviewdate vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_lateadopt.dta", replace version(11)
}
//Controlling for tract-pair differences in vehicle ownership
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	drop chain reviews
	saveold "../output/estarrays/sixom/estarray_`race'_carshare.dta", replace version(11)
}
//Controlling for number of reviews and chain establishments
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	drop vehicle_avail_hhshare_diff
	saveold "../output/estarrays/sixom/estarray_`race'_revchain.dta", replace version(11)
}


//Tables A.7 – A.9: Minimum-time specifications robustness checks
foreach race in asian black whithisp {
	foreach spec in mainspec 50 100 disaggcuis lateadopt half fifth revchain carshare droploca locainfo1 locainfo2 { 
		use "../output/estarrays/sixom/estarray_`race'_`spec'.dta", clear
		egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
		drop time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log
		saveold "../output/estarrays/mintime/estarray_`race'_`spec'.dta", replace version(11)
	}
}

//Table A.10: Robustness of spatial frictions
foreach race in asian black whithisp {
	foreach spec in spatialincome spatialage spatialgender {
		if "`spec'"=="spatialincome" local suffix "income"
		if "`spec'"=="spatialage" local suffix "21to39"
		if "`spec'"=="spatialgender" local suffix = "female"
		use "../output/estarrays/sixom/estarray_`race'_`spec'.dta", clear
		egen time_minimum_log = rowmin(time_*_????_log)
		egen time_minimum_log_`suffix' = rowmin(time_*_????_log_`suffix')
		drop time_*_????_log time_*_????_log_`suffix'
		saveold "../output/estarrays/mintime/estarray_`race'_`spec'.dta", replace version(11)
	}
}


//Table A.11: Estimates with home as only origin
//Larger home-only sample
foreach race in asian black whithisp {
	tempfile tf_choiceset_`race' tf_estarray_`race'
	use if `race'==1 using "../input/choiceset_homeonly.dta", clear
	drop asian black whithisp
	save "`tf_choiceset_`race''", replace
	estarray_noworklocation using "`tf_choiceset_`race''", saveas("../output/estarrays/norg/estarray_`race'_homeonlysample.dta")
}
//Estimation-sample specifications
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	drop chain reviews_log time*_work_log time*path_log vehicle_avail_hhshare_diff
	saveold "../output/estarrays/norg/estarray_`race'_homeonly.dta", replace version(11)
}

//Table A.13. Specification employing only tract-level covariates
estarray_racespecific using "../input/choiceset_all.dta", saveas("../output/estarrays/sixom/estarray_raceblind.dta") dropvars(chain reviews_log)


//Minimum-travel-time specification
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
	drop chain reviews_log time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log vehicle_avail_hhshare_diff
	saveold "../output/estarrays/mintime/estarray_`race'.dta", replace version(11)
}

//Fastest-mode specification
foreach race in asian black whithisp {
	use "../output/estarrays/sixom/estarray_`race'.dta", clear
	foreach orig in home work path {
		egen time_`orig'_log = rowmin(time_public_`orig'_log time_car_`orig'_log)
	}
	drop chain reviews_log time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log vehicle_avail_hhshare_diff
	saveold "../output/estarrays/fastestmode/estarray_`race'_fastestmode.dta", replace version(11)
}

exit, clear
