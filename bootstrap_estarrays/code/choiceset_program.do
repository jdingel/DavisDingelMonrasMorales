//The program "choiceset" generates a choice set for each user-trip observation that 
//contains the chosen venue and N-1 unchosen venues randomly drawn from the set of venues in venues_est.dta,
//where N is the command option "choicesetsize". 
//The resulting choice set is saved in a file named in "saveas".

cap program drop choiceset
program define choiceset
syntax using/, choicesetsize(integer) seed(integer) [keepuniform(real 1.1)] saveas(string)

//Assign venues numbers to venues
tempfile tf_venues
use "../input/venues_est.dta", clear    
egen randomvenueid = group(venue_num)
save `tf_venues', replace
summ randomvenueid
local randomvenuesupport = r(max)

//Identify venues chosen by a user at some point
tempfile tf_chosenbyuser
use userid_num venue_num tripnumber using `using', clear
collapse (min) tripnumber_firsttrip = tripnumber, by(userid_num venue_num)
save `tf_chosenbyuser', replace
rename tripnumber_firsttrip tripnumber

//Create choice sets
local expander = round(`choicesetsize' * 1.3)
expand `expander'
bys userid_num tripnumber: gen case_obs = _n
replace venue = . if case_obs~=1
set seed `seed'
gen randomvenueid= ceil(`randomvenuesupport'*uniform()) if case_obs~=1
merge m:1 randomvenueid using `tf_venues', nogen assert(master using match_update) keep(master match_update) update keepusing(venue_num)
merge m:1 userid_num venue_num using `tf_chosenbyuser', gen(chosenbyuser) assert(master match) keepusing(tripnumber_firsttrip)
recode chosenbyuser 1=0 3=1
bys userid_num tripnumber venue_num: egen chosen = max(case_obs==1)
	count if chosen==1 & (tripnumber > tripnumber_firsttrip)  
	if `r(N)'>0 error 451 //Not correct error code, but I want to stop if the trips are in wrong order
	drop if chosenbyuser==1 & (tripnumber > tripnumber_firsttrip) // Dropping due to previously reviewed
duplicates drop	userid_num venue_num tripnumber chosen, force		//Random sampling will occasionally result in duplicates (with low but non-zero probability)
gsort userid_num tripnumber -chosen case_obs
by userid_num tripnumber: gen choiceelement = _n	//The gsort in the previous line is needed so that we retain the chosen venue
drop if choiceelement > `choicesetsize'

//Label variables
label var tripnumber "The number of trip under consideration by this userid"
label var chosen "Venue chosen by the user for this tripnumber"

//Check output
summ chosen
if r(mean)~=1/`choicesetsize' disp "THIS HAS GONE WRONG: Choice sets aren't correct size"
if r(mean)==1/`choicesetsize' {
	//Save
	keep userid userid_num venue_num tripnumber chosen
	order userid userid_num venue_num tripnumber chosen
	compress
	label data "Choice set"
	saveold "`saveas'", replace
}

end

