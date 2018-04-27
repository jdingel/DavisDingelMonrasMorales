

cap program drop tracts_stats
program define tracts_stats

syntax using/, tractid(string) variables(string) [texfilename(string)] [weights(string)] [if(string)]

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
**Produce summary stats table, output to TeX if requested
summ `variables'
if "`texfilename'"~="" sutex `variables' `weights', labels title(Tract-level summary statistics) key(tab:summ_tracts_stats) file(`texfilename') replace

end


cap program drop tractpairs_stats
program define tractpairs_stats

syntax using/, orig_id(string) dest_id(string) variables(string) [texfilename(string)] [if(string)] [extrakeepers(string)]

use `using', clear
**Restrict to tract-pair variables and confirm that these are all tract-pair-level variables
keep `orig_id' `dest_id' `variables' `extrakeepers'
foreach var of varlist `variables' {
	tempvar tv0
	qui bys `orig_id' `dest_id': egen `tv0' = sd(`var')
	qui summ `tv0'
	if r(max)> (10^-6) & r(N)~=0 {
		disp "Error: Some of the specified variables are not tract-pair-level variables"
		disp "Problem with variable: `var'"
		error 109
	}
}

**Impose if conditions specified in program call
if "`if'"~="" keep if `if'
**Drop duplicates since we're working at tract-pair level
qui duplicates drop
**Produce summary stats table, output to TeX if requested
summ `variables'
if "`texfilename'"~="" sutex `variables', labels title(Tract-pair summary statistics) key(tab:summ_tractpairs_stats) file(`texfilename') replace

end


//TRACT CHARACTERISTICS: Should it be if(population~=0) or if(median_household_income~=.)?
tempfile tf_tracts
use geoid11 population spectralsegregationindex robberies_0711_perres using "../input/tract_2010_characteristics_est.dta", clear
label var population "Population"
label var spectralsegregationindex "Spectral segregation index for tract's plurality"
label var robberies_0711_perres "Robberies per resident, 2007-2011 annual average"
save `tf_tracts', replace
tracts_stats using `tf_tracts', tractid(geoid11) variables(population spectralsegregationindex robberies_0711_perres) texfilename("../output/table_A02_upper.tex") 

//TRACT PAIRS:
tempfile tf_tractpairs 
use "../input/tract_pairs_2010_characteristics_est.dta", clear
label variable median_income_percent_difference "Percentage absolute difference in median household income"
label variable med_income_perc_diff_signed "Percentage difference in median household income"
label variable traveltime_public "Travel time by public transport in minutes"
label variable traveltime_car "Travel time by automobile in minutes"
save `tf_tractpairs', replace
tractpairs_stats using `tf_tractpairs', orig_id(geoid11_orig) dest_id(geoid11_dest) if(missing(median_income_percent_difference)==0 & missing(traveltime_car)==0 &  missing(traveltime_public)==0) variables(median_income_percent_difference med_income_perc_diff_signed eucl_demo_distance traveltime_public traveltime_car) texfilename("../output/table_A02_lower.tex") 

exit, clear
