
//Created by: Jonathan Dingel
//Date: April 2018

clear all
set more off

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "estarrays_venueFE_programs.do"

cap program drop tripsdata_Taddy
program define tripsdata_Taddy

	syntax, race(string) saveas(string)

	if "`race'"!="asian" & "`race'"!="black" & "`race'"!="whithisp" error 109

	use "../input/trips_est.dta", clear
	merge m:1 userid_num using "../input/users_est.dta", assert(using match) keep(match) nogen keepusing(asian black whithisp)
	keep if `race'==1
	keep userid_num venue_num date
	save "`saveas'", replace
end

cap program drop choiceset_Taddy
program define choiceset_Taddy

	syntax using/, saveas(string)

	//Construct choice sets containing all venues that are reviewed by anyone in data (and not previously reviewed by this user)

	use "`using'", clear
	tempfile tf0 tf1
	//Create data denoting prior reviews by user
	rename date date_firstreview
	save `tf0', replace
	//Organize data suitable for merges
	rename date_firstreview date
	sort userid_num date venue_num
	by userid_num (date): gen tripnumber = _n
	sort userid_num tripnumber
	egen user_trip_id = group(userid_num tripnumber)
	save `tf1', replace
	//Create choice set with all (user-trip)-(venue) combinations
	keep user_trip_id venue_num
	fillin user_trip_id venue_num
	gen byte chosen = (1-_fillin)
	//Merge identifying information
	merge m:1 user_trip_id using `tf1', assert(match) keepusing(userid_num tripnumber date) nogen
	//Drop venues previously reviewed by this user
	merge m:1 userid_num venue_num using `tf0', assert(master match) keepusing(date_firstreview) nogen
	drop if (date > date_firstreview)
	drop _fillin date date_firstreview
	
	keep userid_num tripnumber venue_num chosen
	gsort userid_num tripnumber -chosen venue_num
	order userid_num tripnumber venue_num chosen

	save "`saveas'", replace

end

/***********************
** PROGRAM CALLS
***********************/

foreach race in black asian whithisp {
	tempfile tf1 tf2 tf3
	tripsdata_Taddy, race(`race') saveas(`tf1')
	choiceset_Taddy using `tf1', saveas(`tf2')
	estarray_venueFE_racespecific using `tf2', saveas("../output/estarray_venueFE_Taddy_`race'.dta")
}

exit, clear
