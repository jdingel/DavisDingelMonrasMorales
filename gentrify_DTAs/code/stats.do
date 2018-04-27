//Dingel, April 2018

	foreach package in sutex {
		capture which `package'
		if _rc==111 ssc install `package'
	}

	cap program drop DeltaX_variables_labels
	program define DeltaX_variables_labels
	cap label var D_asian_percent "Asian residential share"
	cap label var D_black_percent "Black residential share"
	cap label var D_hispanic_percent "Hispanic residential share"
	cap label var D_white_percent "White residential share"
	cap label var D_robberies_0711_perres "Robberies per resident"
	cap label var D_spectralsegregationindex "Spectral segregation index"
	cap label var D_median_household_income "Median household income (thousands)"
	//Venue chars
	cap label var D_avgrating "Yelp rating"
	cap label var D_price "Price (\$ to \$\$\$\$)"
	//Tract-pair chars
	cap label var D_eucl_demo_distance "Euclidean demographic distance"
	end

	cap program drop gentrify_covariate_changes
	program define gentrify_covariate_changes

	syntax, counterfactual(string) tablesaveas(string) dtasaveas(string) tractcovars(string) venuecovars(string) tractpaircovars(string)
	if "`counterfactual'"!="Harlem" & "`counterfactual'"!="Bedstuy" error 100

	//Compare tract characteristics
	tempfile tf_tract_0 tf_tract
	use "../input/tract_2010_characteristics_est.dta", clear

	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11!="36061022400" //Reference tract does not change characteristics
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11!="36047029300" //Reference tract does not change characteristics
	
	if strpos("`tractcovars'","median_household_income")!=0 replace median_household_income = 10 * median_household_income
	summ `tractcovars'
	foreach var of varlist `tractcovars' {
		rename `var' `var'0
	}
	save `tf_tract_0', replace
	
	use "../output/tracts_`counterfactual'.dta", clear

	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11!="36061022400" //Reference tract does not change characteristics
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11!="36047029300" //Reference tract does not change characteristics

	if strpos("`tractcovars'","median_household_income")!=0 replace median_household_income = 10 * median_household_income
	summ `tractcovars'
	foreach var of varlist `tractcovars' {
		rename `var' `var'1
	}
	merge 1:1 geoid11 using `tf_tract_0', assert(match) nogen
	foreach var in `tractcovars' {
		gen  D_`var' = `var'1 - `var'0
	}
	keep geoid11 D_*
	save `tf_tract', replace

	tempfile tf_venue_0 tf_venue
	use "../input/venues_est.dta", clear
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keepusing(area) assert(using match) keep(match) nogen
		
	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11!="36061022400" //Reference tract does not change characteristics
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11!="36047029300" //Reference tract does not change characteristics

	summ `venuecovars'
	foreach var of varlist `venuecovars' {
		rename `var' `var'0
	}
	save `tf_venue_0', replace
	
	use "../output/venues_`counterfactual'.dta", clear
	merge m:1 geoid11 using "../output/tracts_`counterfactual'.dta", keepusing(area) assert(using match) keep(match) nogen
	
	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11!="36061022400" //Reference tract does not change characteristics
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11!="36047029300" //Reference tract does not change characteristics

	summ `venuecovars'
	foreach var of varlist `venuecovars' {
		rename `var' `var'1
	}
	merge 1:1 venue using `tf_venue_0', assert(match) nogen
	foreach var in `venuecovars' {
		gen  D_`var' = `var'1 - `var'0
	}
	keep venue geoid11 D_*
	save `tf_venue', replace

	tempfile tf_tractpairs_0 tf_tractpairs
	if "`counterfactual'"=="Bedstuy" local geoid11_home = "36047029300" 
	if "`counterfactual'"=="Harlem" local geoid11_home = "36061022400"  
	use if geoid11_orig=="`geoid11_home'" using "../input/tract_pairs_2010_characteristics_est.dta", clear
	gen geoid11 = geoid11_dest
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keepusing(area) assert(using match) keep(match) nogen
	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11_dest!="36061022400"
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11_dest!="36047029300"
	drop geoid11
	foreach var of varlist `tractpaircovars' {
		rename `var' `var'0
	}
	save `tf_tractpairs_0', replace

	use if geoid11_orig=="`geoid11_home'" using "../output/tractpairs_`counterfactual'.dta", clear
	gen geoid11 = geoid11_dest
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keepusing(area) assert(using match) keep(match) nogen
	if "`counterfactual'"=="Harlem"  keep if (area==26) & geoid11_dest!="36061022400"
	if "`counterfactual'"=="Bedstuy" keep if (area==3)  & geoid11_dest!="36047029300"
	drop geoid11
	foreach var of varlist `tractpaircovars' {
		rename `var' `var'1
	}
	merge 1:1 geoid11_orig geoid11_dest using `tf_tractpairs_0', assert(match) nogen
	gen D_eucl_demo_distance = eucl_demo_distance1 - eucl_demo_distance0
	keep geoid11_???? D_*
	save `tf_tractpairs', replace
	
	use `tf_venue', clear
	merge m:1 geoid11 using `tf_tract', assert(using match) keep(match) nogen
	rename geoid11 geoid11_dest
	merge m:1 geoid11_dest using `tf_tractpairs', assert(using match) keep(match) nogen

	
	DeltaX_variables_labels
	sutex D_asian_percent D_black_percent D_hispanic_percent D_white_percent D_robberies_0711_perres D_spectralsegregationindex D_avgrating D_price D_median_household_income D_eucl_demo_distance, ///
	file(`tablesaveas') replace labels title("Changes in covariates for `counterfactual' gentrification")

	collapse (mean) D_asian_percent D_black_percent D_hispanic_percent D_white_percent D_robberies_0711_perres D_spectralsegregationindex D_avgrating D_price D_median_household_income D_eucl_demo_distance
	save "`dtasaveas'", replace

	end

	gentrify_covariate_changes, counterfactual(Harlem) tablesaveas("../output/gentrify_covars_Harlem_preprocess.tex")  dtasaveas("../output/gentrify_avgcovars_Harlem.dta") ///
		tractcovars(asian_percent black_percent hispanic_percent white_percent robberies_0711_perres spectralsegregationindex median_household_income) venuecovars(avgrating price) tractpaircovars(eucl_demo_distance)

	gentrify_covariate_changes, counterfactual(Bedstuy) tablesaveas("../output/gentrify_covars_Bedstuy_preprocess.tex") dtasaveas("../output/gentrify_avgcovars_Bedstuy.dta")  ///
		tractcovars(asian_percent black_percent hispanic_percent white_percent robberies_0711_perres spectralsegregationindex median_household_income) venuecovars(avgrating price) tractpaircovars(eucl_demo_distance)

	exit, clear
