//Created by: Jonathan Dingel
//Date: April 2018

/***********************
** PROGRAM DEFINITIONS
***********************/

qui do "estarray_nested_programs.do"

cap program drop definenests
program define definenests

	syntax, nestvars(string) nestidvar(string) saveas(string)
	use "../input/venues_est.dta", clear
	merge m:1 geoid11 using "../input/tract_characteristics.dta", nogen assert(using match) keep(match) keepusing(area_dummy_assignment)
	egen `nestidvar' = group(`nestvars')
	keep venue_num `nestidvar'
	compress 
	label data "Venues' nest identifiers"
	save "`saveas'", replace

end

cap program drop makenestarray
program define makenestarray

//This program assumes you've already generated the choice set (that this can be done regardless of nest definitions)

syntax using/ , nestidvar(string) choicesetsaveas(string) nestcharsaveas(string)

	//Add nest identifiers to choice set file
	use "`using'", clear  //This choicest file contains: userid, venue, tripnumber, chosen
	merge m:1 venue_num using "../output/venues.dta", assert(using match) keep(match) keepusing(`nestidvar') nogen
	compress
	save "`choicesetsaveas'", replace

	//Create trip-level nest-members file
	tempfile tf_nest_rows tf_nest_totals
	use venue_num `nestidvar' using "../output/venues.dta", clear
	bys `nestidvar': gen nest_element = _n
	save "`tf_nest_rows'", replace
	bys `nestidvar': egen nest_members = total(1)
	collapse (firstnm) nest_members, by(`nestidvar')
	save `tf_nest_totals', replace

	//Create inclusive values file that mimics choice set structure
	use "`choicesetsaveas'", clear
	keep userid_num `nestidvar'
	duplicates drop
	merge m:1 `nestidvar' using `tf_nest_totals', assert(using match) keep(match) keepusing(nest_members) nogen
	expand nest_members
	bys userid_num `nestidvar': gen nest_element = _n
	merge m:1 `nestidvar' nest_element using "`tf_nest_rows'", assert(using match) keep(match) keepusing(venue_num) nogen
	gen tripnumber = 0
	gen chosen = 1
	compress
	sort userid_num `nestidvar' nest_element
	save "`nestcharsaveas'", replace	

end


/***********************
** PROGRAM CALLS
***********************/


tempfile tf_nestid_1 tf_nestid_2
definenests, saveas(`tf_nestid_1') nestidvar(nest1) nestvars(area_dummy_assignment cuisinetype_midaggregate avgrating) 
definenests, saveas(`tf_nestid_2') nestidvar(nest2) nestvars(geoid11 cuisinetype_midaggregate price)
use "../input/venues_est.dta", clear
merge 1:1 venue_num using `tf_nestid_1', assert(match) nogen keepusing(nest1)
merge 1:1 venue_num using `tf_nestid_2', assert(match) nogen keepusing(nest2)
save "../output/venues.dta", replace


foreach race in asian black whithisp {
	tempfile tf_choiceset_1 tf_nestchar_1
	makenestarray using "../input/choiceset_`race'.dta", nestidvar(nest1) choicesetsaveas(`tf_choiceset_1') nestcharsaveas(`tf_nestchar_1')
	estarray_racespecific using `tf_choiceset_1', prepcovariateoptions("nestid(nest1)") saveas("../output/sixom/estarray_`race'_nests_nested1.dta") dropvars(chain reviews_log)
	estarray_racespecific using `tf_nestchar_1', prepcovariateoptions("nestid(nest1)") saveas("../output/sixom/estarray_`race'_incval_nested1.dta") dropvars(chain reviews_log)

	tempfile tf_choiceset_2 tf_nestchar_2
	makenestarray using "../input/choiceset_`race'.dta", nestidvar(nest2) choicesetsaveas(`tf_choiceset_2') nestcharsaveas(`tf_nestchar_2')
	estarray_racespecific using `tf_choiceset_2', prepcovariateoptions("nestid(nest2)") saveas("../output/sixom/estarray_`race'_nests_nested2.dta") dropvars(chain reviews_log)
	estarray_racespecific using `tf_nestchar_2', prepcovariateoptions("nestid(nest2)") saveas("../output/sixom/estarray_`race'_incval_nested2.dta") dropvars(chain reviews_log)

	forvalues i=1/2 {
		foreach name in nests incval {
			use "../output/sixom/estarray_`race'_`name'_nested`i'.dta", clear
			egen time_minimum_log = rowmin(time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log)
			drop time_public_home_log time_car_home_log time_public_work_log time_car_work_log time_public_path_log time_car_path_log
			save "../output/mintime/estarray_`race'_`name'_nested`i'.dta", replace
		}
	}
}

exit, clear
