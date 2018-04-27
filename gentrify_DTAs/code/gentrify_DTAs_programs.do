

cap program drop gentrification_mapmaker
program define gentrification_mapmaker

	syntax, counterfactual(string) saveas(string) saveas_manhattan(string)
	if "`counterfactual'"!="Harlem" & "`counterfactual'"!="Bedstuy" error 100

	tempfile tf0
	use geoid11 _ID using "../input/geoid11_coords.dta", clear
	duplicates drop
	save `tf0', replace
	
	use "../input/tract_2010_characteristics_est.dta", clear
	merge 1:m geoid11 using `tf0', assert(using match) keepusing(_ID) nogen

	gen int group=0
	replace group=2 if area==24
	if "`counterfactual'"=="Harlem" {
		replace group=1 if area==26
		replace group=3 if geoid11=="36061022400"
	}
	if "`counterfactual'"=="Bedstuy" {
		replace group=1 if area==3
		replace group=3 if geoid11=="36047029300"
	}

	spmap group if substr(geoid11,1,5)!="36085" using "../input/geoid11_coords.dta", id(_ID) clmethod(unique) fcolor(stone midgreen orange white) legen(off)
	graph export "`saveas'", replace
	gen manhattan = (substr(geoid11,1,5)=="36061")
	spmap group if manhattan==1 using "../input/geoid11_coords.dta", id(_ID) clmethod(unique) fcolor(stone midgreen orange white) legen(off)
	graph export "`saveas_manhattan'", replace

end

cap program drop gentrification_tracts_DTA
program define gentrification_tracts_DTA

	syntax, counterfactual(string) saveas(string)
	if "`counterfactual'"!="Harlem" & "`counterfactual'"!="Bedstuy" error 100

	use "../input/tract_2010_characteristics_est.dta", clear

	if "`counterfactual'"=="Harlem" {
		gen byte treat = (area==26)
		drop if geoid11=="36061022400" //Reference tract does not change characteristics
	}
	if "`counterfactual'"=="Bedstuy" {
		gen byte treat = (area==3)
		drop if geoid11=="36047029300" //Reference tract does not change characteristics
	}

	keep if treat==1 | area==24

	sort treat geoid11
	set seed 14
	gen random = runiform()
	psmatch2 treat random
	tempfile tf_1
	save `tf_1', replace
	
	use geoid11 _n1 area_dummy_assignment population vehicle_avail_hhshare share_21to39 share_male treat if treat==1 using `tf_1', clear //Load tract and unaltered characteristics
	rename _n1 _id 
	merge m:1 _id using `tf_1', assert(using match) keep(match) keepusing(asian_percent black_percent hispanic_percent white_percent race_plurality spectralsegregationindex median_household_income robberies_0711_perres) nogen //Overwrite characteristics with those from randomly matched control tract
	drop _id treat
	save `tf_1', replace

	use "../input/tract_2010_characteristics_est.dta", clear
	if "`counterfactual'"=="Harlem"  drop if area==26 & geoid11!="36061022400"
	if "`counterfactual'"=="Bedstuy" drop if area==3  & geoid11!="36047029300"
	append using `tf_1'
	save "`saveas'", replace

end

cap program drop gentrification_venues_DTA
program define gentrification_venues_DTA

	syntax, counterfactual(string) saveas(string)
	if "`counterfactual'"!="Harlem" & "`counterfactual'"!="Bedstuy" error 100
	
	use "../input/venues_est.dta", clear
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", assert(using match) keep(match) keepusing(area) nogen

	if "`counterfactual'"=="Harlem" {
		gen byte treat = (area==26)
		drop if geoid11=="36061022400" //Reference tract does not change characteristics
	}
	if "`counterfactual'"=="Bedstuy" {
		gen byte treat = (area==3)
		drop if geoid11=="36047029300" //Reference tract does not change characteristics
	}

	keep if treat==1 | area==24

	sort treat venue
	set seed 14
	gen random = runiform()
	psmatch2 treat random
	tempfile tf_2
	save `tf_2', replace
	
	use venue_num _n1 geoid11 treat if treat==1 using `tf_2', clear //Load venue and unaltered characteristics
	rename _n1 _id 
	merge m:1 _id using `tf_2', assert(using match) keep(match) keepusing(cuisinetype_aggregate cuisinetype_midaggregate reviews avgrating price chain) nogen //Overwrite characteristics with those from randomly matched control venue
	drop _id
	label variable treat "Venue has been gentrified"
	save `tf_2', replace

	use "../input/venues_est.dta", clear
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", assert(using match) keep(match) keepusing(area) nogen
	if "`counterfactual'"=="Harlem"  drop if area==26 & geoid11!="36061022400"
	if "`counterfactual'"=="Bedstuy" drop if area==3  & geoid11!="36047029300"
	drop area
	append using `tf_2'
	recode treat .=0
	save "`saveas'", replace

end

cap program drop gentrification_tractpairs_DTA
program define gentrification_tractpairs_DTA

	syntax using/, saveas(string)

	// Prepare temporary files with "origin" and "destination" tract characteristics
	tempfile tf_orig tf_dest 
	foreach endpoint in orig dest {
		use geoid11 median_household_income asian_percent black_percent white_percent hispanic_percent using "`using'", clear
		gen other_percent = max(0,1 - asian_percent - black_percent - white_percent - hispanic_percent)
		rename (*) (*_`endpoint')
		save `tf_`endpoint'', replace
	}
	
	//Generate tract-pair characteristics from income, racial/ethnic shares, and vehicle data
	use geoid11_orig geoid11_dest physical_distance traveltime_public traveltime_car using "../input/tract_pairs_2010_characteristics_est.dta", clear
	merge m:1 geoid11_orig using `tf_orig', assert(match) nogen
	merge m:1 geoid11_dest using `tf_dest', assert(match) nogen
	gen median_income_percent_difference = abs(median_household_income_orig - median_household_income_dest)/(.5*median_household_income_orig +.5*median_household_income_dest)
	label var median_income_percent_difference "Percentage absolute difference in median incomes between tracts"
	gen med_income_perc_diff_signed = (median_household_income_dest - median_household_income_orig)/(.5*median_household_income_orig +.5*median_household_income_dest)
	label var med_income_perc_diff_signed "Percent difference in median incomes (destination minus origin)"
	gen eucl_demo_distance = (1/sqrt(2))*sqrt((white_percent_orig - white_percent_dest)^2 + (black_percent_orig - black_percent_dest)^2 + (asian_percent_orig - asian_percent_dest)^2 + (hispanic_percent_orig - hispanic_percent_dest)^2 + (other_percent_orig - other_percent_dest)^2)
	label var eucl_demo_distance "Euclidean demographic distance between tracts"
	
	keep geoid11_orig geoid11_dest physical_distance traveltime_public traveltime_car median_income_percent_difference med_income_perc_diff_signed eucl_demo_distance
	save "`saveas'", replace

end


