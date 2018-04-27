/***********************
** META DATA
***********************/

/*
Author: Jonathan Dingel
Date: June 2017
Required packages: "ssc install sutex2"
*/

/***********************
** PROGRAM DEFINITIONS
***********************/


cap program drop load_Pij_csv_dta
program define load_Pij_csv_dta

	syntax , outputfile(string) pathstub(string) file1(string) file2(string) file3(string)

	tempfile tf0
	forvalues i = 1/3 {
		import delimited using "`pathstub'`file`i''", clear varnames(1)
		keep userid_num venue_num prob_visit_venue
		if `i'!=1 append using `tf0'
		save `tf0', replace
	}
	save "`outputfile'", replace

end

cap program drop simulatevisits
program define simulatevisits

	syntax using/, outputfile(string) instances(integer) trips_path(string) users_path(string)

tempfile tf_collect tf_user_trips tf_predvisits
use userid venue using "`trips_path'", clear
duplicates drop
gen int trip = 1
collapse (sum) trips_user = trip, by(userid)
merge 1:1 userid using "`users_path'", assert(using match) keep(match) keepusing(userid_num race_nd) nogen
keep if race_nd==0
label data "Number of trips per user"
save "`tf_user_trips'", replace 

use "`using'", clear
bys userid_num (venue_num): generate double runsum = sum(prob_visit_venue) 
label data "Predicted visits: Pr(j|X_i)"
merge m:1 userid_num using "`tf_user_trips'", assert(match) keep(match) keepusing(trips_user) nogen
save `tf_predvisits', replace

clear
set obs 1
gen userid_num = .
save `tf_collect', replace

forvalues j = 1/`instances' {
display "Starting instance `j'"
use "`tf_user_trips'", clear
expand trips_user
bys userid (userid_num): gen tripnumber = _n
set seed `j'
gen double draw = runiform()
tempfile tf0
label data "User + trips + randomly drawn value determining choice"
save `tf0', replace

clear
tempfile tf2
set obs 1
gen float userid_num = .
save `tf2', replace


forvalues i = 1/220 {   
	if floor(`i'/50) == `i'/50 display "Starting trip number `i'"
	quietly {
	use if trips_user >= `i' using `tf_predvisits', clear
	gen tripnumber = `i' 
	merge m:1 userid_num tripnumber using `tf0', assert(using match) keep(match) keepusing(draw) nogen
	keep if inrange(draw,runsum - prob_visit_venue, runsum)
	append using `tf2'
	save `tf2', replace
	}
}

use `tf2', clear
drop if missing(userid_num)==1 & missing(venue_num)==1 & _n == _N
gen instance = `j' 
append using `tf_collect'
save `tf_collect', replace
}

drop if missing(userid_num)==1 & missing(venue_num)==1 & _n == _N

keep instance userid_num tripnumber venue_num
order instance userid_num tripnumber venue_num

save "`outputfile'", replace

end

cap program drop isolation_compute
program define isolation_compute

	syntax using/, race(string) 

	use if venue_visits!=1 using `using', clear
	egen trips_`race'    = total(`race'==1)
	egen trips_non`race' = total(`race'==0)
	sort venue `race'
	by venue (`race'): egen venue_`race' = total(`race'==1)
	by venue (`race'): egen venue_non`race' = total(`race'==0)
	by venue  `race' : egen venue_`race'share = mean((venue_`race' - `race')/(venue_visits - 1))
	
	collapse (firstnm) trips_* venue_*, by(venue `race')
	reshape wide venue_`race'share, i(venue) j(`race')
	recode venue_`race'share1 .=0 if venue_`race'==0 & inrange(venue_visits,2,.)
	recode venue_`race'share0 .=1 if venue_`race'==venue_visits & inrange(venue_visits,2,.)	

	gen iso_`race' = (venue_`race' / trips_`race') * (venue_`race' / venue_visits) - (venue_non`race' / trips_non`race') * (venue_`race' / venue_visits)
	gen iso_`race'_lvout = (venue_`race' / trips_`race') * (venue_`race'share1) - (venue_non`race' / trips_non`race') * (venue_`race'share0)

	collapse (sum) iso_*
	
end

cap program drop iso_index_varlabels
program define iso_index_varlabels

	label variable iso_whithisp_lvout 	"White/Hispanic isolation index"
	label variable iso_asian_lvout 		"Asian isolation index"
	label variable iso_black_lvout 		"Black isolation index"	
	order iso_asian* iso_black* iso_whithisp*

end

//A DGP for race-specific venue-visit behavior to test the "isolation_compute" program

cap program drop visit_isolation_DGP
program define visit_isolation_DGP

	syntax, black_usershare(real) venues(integer) tripspervenue(integer) seed(integer) venues_blackonly(integer) venues_nonblackonly(integer)

	if `venues' < `venues_blackonly' + `venues_nonblackonly' display "Your venue values are invalid. Can't have venues_nonblackonly + venues_blackonly > venues!"
	
	clear
	local obs_param = `tripspervenue' * `venues'
	set obs `obs_param'
	gen black = inrange(_n,1,floor(`black_usershare'*_N))
	set seed `seed'
	
	gen venue = (black==1) * ceil((`venues'-`venues_nonblackonly')*runiform()) + (black==0) * ceil(`venues_blackonly' + (`venues'-`venues_blackonly')*runiform())
	bys venue: egen venue_visits = total(1)

end

cap program drop isoindices_simulateddraws
program define isoindices_simulateddraws

	syntax using/, [tableoutputfile(string)] [dtaoutputfile(string)] draws(integer) users_path(string)

	//Load simulated trips, merge with user-level racial data, throw out second+ reviews
	tempfile tf_draws_clean tf_cumulate
	use "`using'", clear
	merge m:1 userid_num using "`users_path'", assert(using match) keep(match) keepusing(asian black whithisp) nogen
	bys userid_num venue_num instance: egen total = total(1)
	by  userid_num venue_num instance: egen tripnumber_min = min(tripnumber)
	drop if total>1 & tripnumber>tripnumber_min
	drop total tripnumber_min
	save `tf_draws_clean', replace
	
	//Given simulated reviews, compute resulting isolation indices, draw-by-draw and write to TeX table
	forvalues j = 1/`draws' {
		quietly {
			use if instance==`j' using `tf_draws_clean', clear
			rename venue_num venue  //Variable naming assumption in isolation_compute
			bys venue: egen venue_visits = total(1)
			tempfile tf3
			save `tf3', replace
			foreach race in black asian whithisp {
				isolation_compute using `tf3', race(`race')
				gen instance = `j'
				list
				if `j'!=1 | "`race'"!="black" merge 1:1 instance using `tf_cumulate', update nogen
				save `tf_cumulate', replace
			}
		}
	}
	iso_index_varlabels
	summ iso_*_lvout
	if "`tableoutputfile'"!="" sutex2 iso_*_lvout, percentiles(5 95) varlabels saving(`tableoutputfile') tabular replace
	if "`dtaoutputfile'"!="" save "`dtaoutputfile'", replace
end

