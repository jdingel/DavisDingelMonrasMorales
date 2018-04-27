//Author: Joan Monras
//Date: July 2014; Aug 2014; 2018

/***********************
** COMPUTING RESOURCES
***********************/

clear all
set more off

/***********************
** PROGRAMS
***********************/

cap program drop generate_dummies
program define generate_dummies

gen geoid5 = substr(geoid11,1,5)
keep if geoid5=="36005"|geoid5=="36047"|geoid5=="36061"|geoid5=="36081"|geoid5=="36085"
tab geoid5, gen(d_geoid5_)
tab price, gen(d_price_)
tab cuisinetype_aggregate, gen(d_cuisine_)
drop if avgrating==0
tab avgrating, gen(d_avgrating_)
tab race_plurality, gen(d_race_plurality)

//User race is already dummies in users.dta: whithisp black asian race_nd
//User gender is already dummies in users.dta: male, female, gender_nd

end

program define collapse_with_labels
syntax varlist, stat(string)

if "`stat'"~="sum" & "`stat'"~="mean" break

  foreach v of var * {
 	local l`v' : variable label `v'
        if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
  }
collapse (`stat') `varlist'
foreach v of var * {
	label var `v' "`l`v''"
}

end

cap program drop users_stats
program define users_stats

syntax using/, variables(string) [extravars(string)] [texfilename(string)]  [if(string)] [append] [users_publicationlabels] [title(string)]

if "`append'"=="" local append = "replace"
if "`title'"=="" local title = "User summary statistics"

use `using', clear

**Restrict to user-level variables and confirm that these are all user-level variables
keep userid  `variables' `extravars'		//29 Oct 2014: Stripped out "user *l??_home *l??_work home home*work county_???? census_tract_???? mover"
foreach var of varlist `variables' {    //29 Oct 2014:  Stripped out "county_???? *l??_home *l??_work home home*work census_tract_???? mover"
	tempvar tv0
	qui bys userid: egen `tv0' = sd(`var')
	qui summ `tv0'
	if r(max)> (10^-6) & r(N)~=0 {
		disp "Error: Some of the specified variables are not user-level variables"
		disp "Problem with variable: `var'"
		error 109
	}
}
**Impose if conditions specified in program call
if "`if'"~="" keep if `if'

//option to re-label the variables
`users_publicationlabels'

**Produce summary stats table, output to TeX if requested
summ `variables'

if "`texfilename'"~="" sutex `variables', labels title(`title') key(tab:summ_users_stats) file("`texfilename'") `append' digits(2)
end



cap program drop tracts_stats
program define tracts_stats

syntax using/, tractid(string) variables(string) [texfilename(string)] [weights(string)] [if(string)] [tracts_publicationlabels] 

use `using', clear

**Restrict to tract-level variables and confirm that these are all tract-level variables
keep `tractid' `variables'
foreach var of varlist `variables' {
	tempvar tv0
	qui bys `tractid': egen `tv0' = sd(`var')
	qui summ `tv0'
	if r(max)> (10^-6) & r(N)~=0 {
		disp "Error: Some of the specified variables are not tract-level variables"
		disp "Problem with variable: `var'"
		error 109
	}
}
**Impose if conditions specified in program call
if "`if'"~="" keep if `if'
**Drop duplicates since we're working at tract level
qui duplicates drop
//Change variable labels to the shorter labels requested by Eduardo
`tracts_publicationlabels'
**Produce summary stats table, output to TeX if requested
summ `variables'
if "`texfilename'"~="" sutex `variables' `weights', labels title(Tract-level summary statistics) key(tab:summ_tracts_stats) file(`texfilename') replace

end

cap program drop trips_statistics
program define trips_statistics 
syntax, saveas(string) cuisine(integer) race_plurality(integer) [race_selection(string)]

tempfile tf0 tf1 tf1_asian tf1_black tf1_whithisp tf_col1 tf_col2 tf_col3 tf_col4 tf_col5 tf_col6


//Estimation sample columns will be tf_col1 and tf_col2
use "../input/trips_est.dta", clear //Data set of trips used for estimation
keep userid venue
merge m:1 userid using "../input/users_est.dta", nogen keep(3) keepusing(whithisp black asian race_nd male female gender_nd)
merge m:1 venue using "../input/venues_est.dta", nogen keep(3) keepusing(price avgrating geoid11 cuisinetype_aggregate)
merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keep(3) nogen keepusing(race_plurality)
drop if race_plurality=="empty"

//Generate dummy variables
generate_dummies
save `tf0', replace

local varlist "asian black whithisp"
foreach var of local varlist{
use `tf0', clear
keep if `var'==1
save `tf1_`var'', replace
}

use `tf0', clear

if "`race_selection'" == "asian" {
keep if asian==1
}
if "`race_selection'" == "black" {
keep if black==1
}
if "`race_selection'" == "whithisp" {
keep if whithisp==1
}

save `tf1', replace

 //Collapse while preserving the labels
use `tf1', clear
collapse_with_labels  d_* whithisp black asian race_nd male female gender_nd, stat(mean)
gen int column = 2
save `tf_col1', replace

//All visits column will be tf_col3
use "../input/venues_alltripsstats.dta", clear
save `tf_col2', replace
foreach var of varlist d_* {
	replace `var' = .
}
replace column = 3
save `tf_col3', replace


//Collapse while preserving the labels
use `tf1_asian', clear
collapse_with_labels  d_* whithisp black asian race_nd male female gender_nd, stat(mean)
gen int column = 1
save `tf_col4', replace

 //Collapse while preserving the labels
use `tf1_black', clear
collapse_with_labels  d_* whithisp black asian race_nd male female gender_nd, stat(mean)
gen int column = 2
save `tf_col5', replace


 //Collapse while preserving the labels
use `tf1_whithisp', clear
collapse_with_labels  d_* whithisp black asian race_nd male female gender_nd, stat(mean)
gen int column = 3
save `tf_col6', replace


//Join the columns and tranpose
use `tf_col1', clear
append using `tf_col2',
append using `tf_col3',
append using `tf_col4', 
append using `tf_col5',
append using `tf_col6',

drop asian black whithisp race_nd male female gender_nd  
order d_price* d_avg*   ///
    	d_cuisine_2 d_cuisine_3 d_cuisine_4 d_cuisine_6 d_cuisine_8 d_cuisine_5 d_cuisine_7 d_cuisine_9 d_cuisine_1 ///
    	d_geoid5_3 d_geoid5_2 d_geoid5_4 d_geoid5_1 d_geoid5_5

if `cuisine'==0 {
drop d_cuisine**
}

if `race_plurality'==0 {
drop d_race_plurality**
}

xpose, clear varname

gen str varname=""
replace varname="Rating of 1 stars"           if  _varname=="d_avgrating_1"
replace varname="Rating of 1.5 stars"         if  _varname=="d_avgrating_2"
replace varname="Rating of 2 stars"           if  _varname=="d_avgrating_3"
replace varname="Rating of 2.5 stars"         if  _varname=="d_avgrating_4"
replace varname="Rating of 3 stars"           if  _varname=="d_avgrating_5"
replace varname="Rating of 3.5 stars"         if  _varname=="d_avgrating_6"
replace varname="Rating of 4 stars"           if  _varname=="d_avgrating_7"
replace varname="Rating of 4.5 stars"         if  _varname=="d_avgrating_8"
replace varname="Rating of 5 stars"           if  _varname=="d_avgrating_9"

replace varname="Price of \\$"              if  _varname=="d_price_1"
replace varname="Price of \\$\\$"           if  _varname=="d_price_2"
replace varname="Price of \\$\\$\\$"        if  _varname=="d_price_3"
replace varname="Price of \\$\\$\\$\\$"     if  _varname=="d_price_4"

replace varname="Located in Manhattan"            if  _varname=="d_geoid5_3" 
replace varname="Located in Brooklyn"             if  _varname=="d_geoid5_2" 
replace varname="Located in Queens"               if  _varname=="d_geoid5_4" 
replace varname="Located in Bronx"                if  _varname=="d_geoid5_1"  
replace varname="Located in Staten Island"        if  _varname=="d_geoid5_5"

if `race_plurality'==1 {
replace varname="Located in plurality Asian"            if  _varname=="d_race_plurality1" 
replace varname="Located in plurality black"            if  _varname=="d_race_plurality2" 
replace varname="Located in plurality Hispanic"            if  _varname=="d_race_plurality3" 
replace varname="Located in plurality white"            if  _varname=="d_race_plurality4" 
}

if `cuisine'==1 {
replace varname="Cuisine: African"            if  _varname=="d_cuisine_1" 
replace varname="Cuisine: American"             if  _varname=="d_cuisine_2" 
replace varname="Cuisine: Asian"               if  _varname=="d_cuisine_3" 
replace varname="Cuisine: European"                if  _varname=="d_cuisine_4"  
replace varname="Cuisine: Indian"        if  _varname=="d_cuisine_5"
replace varname="Cuisine: Latin American"        if  _varname=="d_cuisine_6"
replace varname="Cuisine: Middle Eastern"        if  _varname=="d_cuisine_7"
replace varname="Cuisine: No Category"        if  _varname=="d_cuisine_8"
replace varname="Cuisine: Veggie"        if  _varname=="d_cuisine_9"
}

//generate v1_str = string(v1)
foreach var of varlist v1 v2 v3 v4 v5 v6 { 
	generate `var'_str = string(`var',"%6.3f")
	replace `var'_str = "" if `var'_str=="."
	replace `var'_str = subinstr(`var'_str,"0.",".",1)
}
replace varname = "\hline " + varname  if _varname=="d_avgrating_1"|_varname=="d_geoid5_3"|_varname=="d_cuisine_2"|_varname=="d_race_plurality1"
drop if _varname=="column"
drop if _varname=="d_race_plurality5" //This is other/empty neighborhood

order varname v3_str v2_str v1_str v4_str v5_str v6_str  

drop v3_str 
append using "../output/edd_phdist_users.dta"

listtex varname v?_str using "../output/`saveas'", replace ///
rstyle(tabular) head("\begin{tabular}{lcccccc} \toprule" "& Share of all & \multicolumn{4}{c}{Share of estimation-sample reviews} \\ \cline{3-6}" "Restaurant characteristic &  NYC Yelp reviews & all races & Asian & black &  white/Hispanic \\ \midrule") foot("\bottomrule \end{tabular}") 

import delimited "../output/`saveas'", clear delimiter("&")

keep v1 v2 v3 v4 v5 v6
forvalues i=1(1)5 {
gen d`i'="&"
}

order v1 d1 v2 d2 v3 d3 v4 d4 v5 d5 v6

forvalues i=1(1)5 {
replace d`i'=" " if v1=="\begin{tabular}{lcccccc} \toprule" | v1=="\bottomrule \end{tabular}" 
}
forvalues i=3(1)5 {
replace d`i'=" " if v3==" \multicolumn{4}{c}{Share of estimation-sample reviews} \\ \cline{3-6}" | v3==" \multicolumn{4}{c}{Mean for} \\ \cline{3-6}"
}

listtex v1 d1 v2 d2 v3 d3 v4 d4 v5 d5 v6 using "../output/`saveas'", replace delimiter(" ")

end 


cap program drop located_vs_nonlocated 
program define located_vs_nonlocated

//Step 1: Build a file that has userid, venue1, venue2 for all combinations of venues visited by the user
//Step 2: Merge venue1 and venue2 with census tract characteristics 
//Step 3: Collapse to user-level, computing average distance (physical, EDD, etc) between visited venues 
//Step 4: Compare across user groups (those in estimation sample and those not)
//Step 5: Output tests into a .tex Table. For this, 2 steps:  first indivdual tables by race group, and then merge of the tables. 


tempfile tf_venues_1 tf_venues_2 tf_trips_1 tf_trips_2 tf_users

//Prepare the file of user characteristics (which sample they're in) for step 4
use "../input/users_nonloc.dta", clear
gen byte estimation_sample=0
append using "../input/users_est.dta"
recode estimation_sample .=1
keep userid_num estimation_sample gender_nd black asian whithisp
save `tf_users', replace

//Prepare venue information for tracts merging in step 2
use venue geoid11 using "../input/venues_est.dta", clear
rename (venue geoid11) (venue_1 geoid11_1)
save `tf_venues_1', replace
use venue geoid11 using "../input/venues_est.dta", clear
rename (venue geoid11) (venue_2 geoid11_2)
save `tf_venues_2', replace

//Step 1: Build a file that has userid, venue1, venue2 for all combinations of venues visited by the user
use userid_num venue_num using "../input/trips_nonloc.dta", clear // This data contains all trips to venues in our estimation sample
append using "../input/trips_est.dta"
drop date
merge m:1 userid_num using `tf_users', assert(using match) keep(match) keepusing(userid_num estimation_sample) nogen
bys userid: gen tripnumber_1 = _n
rename (venue tripnumber_1) (venue_2 tripnumber_2)
save `tf_trips_2', replace
rename  (venue_2 tripnumber_2) (venue_1 tripnumber_1)
by  userid: egen triptotal = total(1)
gen random = uniform()
keep if random <= min(1,100/triptotal)   //To reduce computational burden, keep at most 100 venues per user 
expand triptotal
bys userid tripnumber_1: gen tripnumber_2 = _n
drop if tripnumber_1 == tripnumber_2     //Don't compare a venue to itself 
merge m:1 userid tripnumber_2 using `tf_trips_2', nogen keepusing(venue_2)

//Step 2: Merge venue1 and venue2 with census tract characteristics 
merge m:1 venue_1 using `tf_venues_1', nogen keepusing(geoid11_1) keep(master match)
merge m:1 venue_2 using `tf_venues_2', nogen keepusing(geoid11_2) keep(master match)
rename (geoid11_1 geoid11_2) (geoid11_orig geoid11_dest)
merge m:1 geoid11_orig geoid11_dest using "../input/tract_pairs_2010_characteristics_est.dta", nogen keep(master match) keepusing(physical_distance eucl_demo_distance)

//Step 3: Collapse to user-level, computing average distance (physical, EDD, etc) between visited venues 
drop if physical_distance==. | eucl_demo_distance==.
collapse (mean) physical_distance eucl_demo_distance (firstnm) triptotal, by(userid)
merge m:1 userid using `tf_users', nogen

//Step 4: Output tests into a .tex Table. For this, 2 steps:  first indivdual tables by race group, and then merge of the tables. 

keep if triptotal>=2 //This restriction eliminates 6 reviewers that only made 1 trip with complete venue characteristics information. 

label define estimation_sample_labels 0 "Non-located reviewers" 1 "Located reviewers"
label values estimation_sample estimation_sample_labels

forvalues i=1(1)3 {
gen eucl_demo_distance`i'= eucl_demo_distance 
gen physical_distance`i'=physical_distance
}
replace eucl_demo_distance1=. if asian!=1
replace eucl_demo_distance2=. if black!=1
replace eucl_demo_distance3=. if whithisp!=1
replace physical_distance1=. if asian!=1
replace physical_distance2=. if black!=1
replace physical_distance3=. if whithisp!=1


collapse (mean) eucl_demo_distance** physical_distance**, by(estimation_sample)

tempfile t_1 t_2
save `t_1', replace
keep estimation_sample eucl_demo_distance**
ren (eucl_demo_distance eucl_demo_distance1 eucl_demo_distance2 eucl_demo_distance3) (var var1 var2 var3)

save `t_2', replace

use `t_1', clear
keep estimation_sample physical_distance**
ren (physical_distance physical_distance1 physical_distance2 physical_distance3) (var var1 var2 var3)

gen stat="Physical distance"

append using `t_2'
replace stat="Euclidean demographic distance" if stat!="Physical distance"

keep stat var var1 var2 var3 estimation_sample
order stat var var1 var2 var3 
foreach var of varlist var var1 var2 var3 { 
	generate `var'_str = string(`var',"%6.2f") if stat=="Physical distance"
	replace `var'_str = string(`var',"%6.3f") if stat=="Euclidean demographic distance"
	replace `var'_str = "" if `var'_str=="."
	replace `var'_str = subinstr(`var'_str,"0.",".",1)
}

replace stat="\multicolumn{2}{l}{EDD, non-located reviewers}" if stat=="Euclidean demographic distance" & estimation_sample==0
replace stat="\multicolumn{2}{l}{EDD, estimation sample}" if stat=="Euclidean demographic distance" & estimation_sample==1
replace stat="\multicolumn{2}{l}{Distance (km), non-located reviewers}" if stat=="Physical distance" & estimation_sample==0
replace stat="\multicolumn{2}{l}{Distance (km), estimation sample}" if stat=="Physical distance" & estimation_sample==1


gen var0_str=""
keep stat var_str var0_str var1_str var2_str var3_str 

count
local aux=`r(N)'+2
set obs `aux'
gen order=_n

replace stat="\midrule &  & \multicolumn{4}{c}{Mean for} \\ \cline{3-6}" if order==5
replace stat="\multicolumn{2}{l}{Within-reviewer across-review dispersion}& & all races & Asian & black &  white/Hispanic \\ \midrule" if order==6
replace order=-2 if order==5
replace order=-1 if order==6
sort order 
drop order
order stat var0_str var_str  var1_str var2_str var3_str 
ren (stat  var0_str var_str var1_str var2_str var3_str ) (varname v2_str v1_str v4_str v5_str v6_str )
save "../output/edd_phdist_users.dta", replace

end


/***********************
** PROGRAM CALLS
***********************/


located_vs_nonlocated
trips_statistics, saveas(table_A01.tex) cuisine(1) race_plurality(1) //This generates Table A.1



exit, clear
