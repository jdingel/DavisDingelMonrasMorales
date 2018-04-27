/****
Created by: Jonathan Dingel
Date:  June 2016; July 2016
Purpose: To generate logit-model behavior in order to look at properties of esimator (extensive margin and choice-set sampling)
****/

clear all
set more off

//PARAMETERS DEFINING THE DGP
//The following involves 16 million observations and takes about an hour to run on JD's 6-core Mac Pro
local numberusers = 400
local numbertrips = 40
local numbervenues = 1000
local choicesetsize = 20   //For choice-set construction
local disutilitydistance = -1
local reviewprobability = 0.5

//COMPUTING RESOURCES
set matsize 1000

//GENERATE DATA 
set seed 123456789
set sortseed 33
tempfile tf_venues tf_users tf_array

//Generate venue data (location and rating)
clear 
set obs `numbervenues'
gen venue_id = _n
gen latitude = 40.75 + uniform()     	//Random coordinates similar to scope of NYC
gen longitude = -74.25 + uniform()		//Random coordinates similar to scope of NYC
gen rating = uniform()*4 + 1			//A venue characteristic common to all users
save `tf_venues'

//Generate user data (home location)
clear
set obs `numberusers'
gen user_id = _n
gen latitude_home = 40.75 + uniform()   //Random coordinates similar to scope of NYC
gen longitude_home = -74.25 + uniform() //Random coordinates similar to scope of NYC 
save `tf_users'

//Generate user-venue data (distance)
use `tf_users'
expand `numbertrips'
bys user_id: gen trip = _n
expand `numbervenues'
bys user_id trip: gen venue_id = _n
qui merge m:1 venue_id using `tf_venues', assert(match) nogen
geodist latitude_home longitude_home latitude longitude, gen(distance)		//A venue-user characteristic
gen distance_log = log(distance)
label variable distance_log "$ \ln $ (distance)"

//Generate choices (logit errors)
gen error = -ln(-ln(uniform()))					//CDF is F(x) = exp(-exp(-x)) and iid  //Invert: if U~uniform(0,1) ln U = -exp(-x) so x=-ln(-ln(U)) 
gen utility = error + `disutilitydistance' * distance_log + rating
bys user_id trip: egen utility_max = max(utility)
gen chosen = (utility>=utility_max)   //The outcome variable used for estimators 1 and 2 
bys user_id venue: egen total = total(chosen)
qui summ total,d
if `r(max)' <= 1 error 148  //Confirm that some users visit some venues more than once so that intensive margin matters

//Generate review writing (censoring of choices)
gen wouldreview = uniform()<=`reviewprobability' * chosen   //User would write a review of their choice in the sense that uniform()<=`reviewprobability'
sort user_id venue_id trip
by  user_id venue_id: gen wouldreviewsum = sum(wouldreview) //Cumulative sum of instances this user would review this venue
gen reviewed = (wouldreview==1) & (wouldreviewsum==1)       //User writes their first review of the venue, never writes a second review
gen alreadyreviewed = (wouldreview==0 & wouldreviewsum==1) | wouldreviewsum>1
drop total wouldreview wouldreviewsum

//Generate estimation array
egen case = group(user_id trip)									//Identifies an observation for the "asclogit" estimator
bys user_id venue_id: egen everreviewed = max(reviewed)			//Identifying repeat visits for extensive vs intensive margin
bys case: egen reviewwritten = total(reviewed) 					//Identifies an observation in which a review was written
gen uniform_random = uniform()    								//Random number at choice-element level for choice-set construction

//Conserve memory by not saving unnecessary stuff when _N > 1,000,000
compress
count
if `r(N)' > 10e5 keep user_id trip venue_id rating distance_log chosen reviewed case everreviewed reviewwritten alreadyreviewed uniform_random
tempfile tf_full
save `tf_full', replace

//ESTIMATOR 1: Use complete data (no choice-set construction, includes intensive margin)
use `tf_full', clear
asclogit chosen distance_log rating, case(case) alternatives(venue) noconstant
qui count if chosen==1
local observations = `r(N)'
qui count 
local choicesetsizereg = round(`r(N)' / `observations' ,.1)
outreg2 using "../output/estimator_simulated.tex", replace tex(frag) noaster noobs dec(2) ctitle("Visit") label addtext("Outcome","Visit","Choice set","All","drawn from","restaurants","Math","$ J$","Obs","`observations'","Choice set size","`choicesetsizereg'")

//ESTIMATOR 2: Use reviews, not choices, with full choice set
use `tf_full', clear
	drop if reviewwritten == 0
asclogit reviewed distance_log rating, case(case) alternatives(venue) noconstant
qui count if reviewed==1
local observations = `r(N)'
qui count 
local choicesetsizereg = round(`r(N)' / `observations')
outreg2 using "../output/estimator_simulated.tex", append tex(frag) noaster noobs dec(2) ctitle("Review") addtext("Outcome","Review","Choice set","All","drawn from","restaurants","Math","$ J$","Obs","`observations'","Choice set size","`choicesetsizereg'")

//ESTIMATOR 3: Use reviews, not choices, with choice set of never-reviewed venues
use `tf_full', clear
	drop if reviewwritten == 0
	drop if reviewed==0 & everreviewed==1 
asclogit reviewed distance_log rating, case(case) alternatives(venue) noconstant
qui count if reviewed==1
local observations = `r(N)'
qui count 
local choicesetsizereg = round(`r(N)' / `observations')
outreg2 using "../output/estimator_simulated.tex", append tex(frag) noaster noobs dec(2) ctitle("Review") addtext("Outcome","Review","Choice set","Never","drawn from","reviewed","Math","$ J'_{iT_{i}}$","Obs","`observations'","Choice set size","$ i$-specific")

//ESTIMATOR 4: Use reviews, not choices, with choice of not-previously-reviewed venues 
use `tf_full', clear
	drop if reviewwritten == 0
	drop if alreadyreviewed == 1
asclogit reviewed distance_log rating, case(case) alternatives(venue) noconstant
qui count if reviewed==1
local observations = `r(N)'
qui count 
local choicesetsizereg = round(`r(N)' / `observations')
outreg2 using "../output/estimator_simulated.tex", append tex(frag) noaster noobs dec(2) ctitle("Review") addtext("Outcome","Review","Choice set","Not previously","drawn from","reviewed","Math","$ J'_{it}$","Obs","`observations'","Choice set size","$ it$-specific")


//ESTIMATOR 5: Use reviews, not choices, with  sampled choice set (sampled from not-previously-reviewed venues)
use `tf_full', clear
quietly {
	drop if reviewwritten == 0
	drop if alreadyreviewed == 1
	gsort user_id trip -chosen uniform_random 
	by user_id trip: gen element = _n
	drop if element>`choicesetsize'				//Randomly sample choice set
}
asclogit reviewed distance_log rating, case(case) alternatives(venue) noconstant
qui count if reviewed==1
local observations = `r(N)'
qui count 
local choicesetsizereg = round(`r(N)' / `observations')
outreg2 using "../output/estimator_simulated.tex", append tex(frag) noaster noobs dec(2) ctitle("Review") label addtext("Outcome","Review","Choice set","Not previously","drawn from","reviewed","Math","$ S_{it} \in J'_{it}$","Obs","`observations'","Choice set size","`choicesetsizereg'")


exit, clear
