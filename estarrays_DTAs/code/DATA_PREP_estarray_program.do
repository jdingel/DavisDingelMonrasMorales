/***********************
** METADATA
***********************/

/****
Created by: Jonathan Dingel
Date: August 2017
Description: Program that builds estimation arrays
****/

/***********************
** PROGRAM DEFINITION
***********************/

//The program "estimationarray" starts with a choice set (chosen-tripnumber-userid-venue) and attaches all the observable characteristics of users, venues, and tracts that could be used in an estimated specification.
cap program drop estarray_racespecific
program define estarray_racespecific
syntax using/,  saveas(string) [prepcovariateoptions(string)] [dropvars(string)] [noworklocation]

//Merge user characteristics, venue characteristics, tract-pair characteristics, etc for every choice
use "`using'", clear
merge m:1 userid_num using "../input/users_est.dta", nogen keep(match) assert(using match)
merge m:1 venue_num using "../input/venues_est.dta", nogen keep(match) assert(using match)
rename geoid11 geoid11_dest
merge m:1 geoid11_dest using  "../input/geoid11_dest.dta", nogen keep(match) assert(using match)
merge m:1 geoid11_home using  "../input/geoid11_home.dta", nogen keep(match) assert(using match)
merge m:1 geoid11_home geoid11_dest using "../input/geoid11_home_pair.dta", nogen keep(match) assert(using match)
merge m:1 geoid11_work geoid11_dest using "../input/geoid11_work_pair.dta", nogen keep(match) assert(using match)
merge m:1 geoid11_home geoid11_work using "../input/geoid11_home_work.dta", nogen keep(match) assert(using match)

//Covariate preparation
prepcovariates_racespecific, `prepcovariateoptions'
if "`dropvars'"!="" drop `dropvars'

//Drop fixed effects that are equal to negative infinity
foreach var of varlist d_area_* d_price_? d_cuisine_?  {
	qui count if chosen==1 & `var'==1
	if `r(N)'==0 {
		tab chosen `var'
		drop if `var'==1
		drop `var'
	}
}

//Drop columns that are entirely zeros
foreach var of varlist d_price_?_income {
	qui count if `var'!=0
	if `r(N)'==0 drop `var'
}

//Save
compress
label data "Estimation array"
saveold "`saveas'", replace

end

//The program "prepcovariates" tranforms many variables into the version that will be used estimation -- the triangle inequality yields the commuting path, logs are taken, dummies are generated for categorical variables, venue and tract characteristics are interacted with demographic and gender dummies, etc.
cap program drop prepcovariates_racespecific
program define prepcovariates_racespecific
syntax, [nestid(string)] [cuisinetype_midaggregate] [vehicle_avail_hhshare_diff] [gender_specific] [spatial_income] [spatial_age] [spatial_gender]


//Transform transit-time variables
gen time_public_path = 0.5 * (time_public_home + time_public_work - time_public_home_work)
gen time_car_path = 0.5 * (time_car_home + time_car_work - time_car_home_work)
replace time_public_path = 0 if time_public_path < 0 
replace time_car_path = 0 if time_car_path < 0 
drop time_public_home_work time_car_home_work
foreach var of varlist time_public_home time_public_work time_public_path time_car_home time_car_work time_car_path {
	gen `var'_log = log(`var' + 1)
	label variable `var'_log "Log of travel time in minutes [ln(t+1)]"
}

gen median_income_log = log(median_household_income*10000)

//Generate dummies
sort price
tab price, gen(d_price_)
sort area_dummy_assignment
tab area_dummy_assignment, gen(d_area_dummy_)
sort cuisinetype_aggregate
tab cuisinetype_aggregate, gen(d_cuisine_)
drop d_price_1 d_area_dummy_1 d_cuisine_8 //Omitted categories: price of $, Bronx, "no_category" of cuisine, white plurality (dropped below)
if "`cuisinetype_midaggregate'"=="cuisinetype_midaggregate" {
	sort cuisinetype_midaggregate
	tab cuisinetype_midaggregate, gen(d_cuisine_m_)
	drop d_cuisine_m_36 //Omitted category: "no category of cuisine for the more detailed version
}

//Label variables
label var eucl_demo_distance "Euclidean demographic distance between \$ h\$ and \$ k_j\$"
label var spectralsegregationindex "Spectral segregation index of \$ k_j\$"
forvalues i=2/4 {
	label var d_price_`i' "Dummy for `i'-dollar bin"
}
label var median_income_percent_difference "Percentage absolute difference in median incomes (\$ h - k_j\$)"
label var med_income_perc_diff_signed "Percent difference in median incomes (\$ k_j - h \$)"
label var median_income_log "Log median household income in $ k_j$"
label variable robberies_0711_perres    "Average annual robberies per resident in $ k_j$, 2007-2011"
label var geoid11_home "Census tract (11-digit FIPS) of user's residence"
label var geoid11_work "Census tract (11-digit FIPS) of user's workplace"
label var geoid11_dest "Census tract (11-digit FIPS) of venue"


//Generate demographic interaction terms
gen eucl_demo_distance_ssi = eucl_demo_distance * spectralsegregationindex
label var eucl_demo_distance_ssi "Euclidean demographic distance $\times$ spectral segregation index"

//Generate tract-level bilateral relations
gen other_percent = max(0,1 - asian_percent - black_percent - hispanic_percent - white_percent)
label variable other_percent "Percent of tract population that is other"

//Log of restaurant's number of Yelp reviews
gen reviews_log = log(reviews)
label variable reviews_log "Log number of Yelp reviews"

//Generate income-price, income-rating
foreach var of varlist d_price_? avgrating {
	gen `var'_income = `var' * median_household_income_home
}
label variable d_price_2_income  "Dummy for 2-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_3_income  "Dummy for 3-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_4_income  "Dummy for 4-dollar bin $\times$ home tract median income (10k USD)"
label variable avgrating_income "Average rating of restaurant $\times$ home tract median income"

//Spatial frictions vary with income
if "`spatial_income'"=="spatial_income" {
	foreach var of varlist time_public_home_log time_public_work_log time_public_path_log time_car_home_log time_car_work_log time_car_path_log {
		gen `var'_income = `var' * median_household_income_home
	}
	label var time_public_home_log_income "Log minutes travel time public-home $\times$ home tract median income (10k USD)"
	label var time_public_work_log_income "Log minutes travel time public-work $\times$ home tract median income (10k USD)"
	label var time_public_path_log_income "Log minutes travel time public-path $\times$ home tract median income (10k USD)"
	label var time_car_home_log_income    "Log minutes travel time vehicle-home $\times$ home tract median income (10k USD)"
	label var time_car_work_log_income    "Log minutes travel time vehicle-car $\times$ home tract median income (10k USD)"
	label var time_car_path_log_income    "Log minutes travel time vehicle-path $\times$ home tract median income (10k USD)"
}


//Spatial frictions vary with age
if "`spatial_age'"=="spatial_age" {
	foreach var of varlist time_public_home_log time_public_work_log time_public_path_log time_car_home_log time_car_work_log time_car_path_log {
		gen `var'_21to39 = `var' * share_21to39
	}
	label var time_public_home_log_21to39 "Log minutes travel time public-home $\times$ home tract age share 21 to 39"
	label var time_public_work_log_21to39 "Log minutes travel time public-work $\times$ home tract age share 21 to 39"
	label var time_public_path_log_21to39 "Log minutes travel time public-path $\times$ home tract age share 21 to 39"
	label var time_car_home_log_21to39    "Log minutes travel time vehicle-home $\times$ home tract age share 21 to 39"
	label var time_car_work_log_21to39    "Log minutes travel time vehicle-car $\times$ home tract age share 21 to 39"
	label var time_car_path_log_21to39    "Log minutes travel time vehicle-path $\times$ home tract age share 21 to 39"
}

//Spatial frictions vary with gender 
if "`spatial_gender'"=="spatial_gender" {
	foreach var of varlist time_public_home_log time_public_work_log time_public_path_log time_car_home_log time_car_work_log time_car_path_log {
		gen `var'_female = `var' * female if gender_nd==0
	}
	label var time_public_home_log_female "Log minutes travel time public-home $\times$ female"
	label var time_public_work_log_female "Log minutes travel time public-work $\times$ female"
	label var time_public_path_log_female "Log minutes travel time public-path $\times$ female"
	label var time_car_home_log_female    "Log minutes travel time vehicle-home $\times$ female"
	label var time_car_work_log_female    "Log minutes travel time vehicle-car $\times$ female"
	label var time_car_path_log_female    "Log minutes travel time vehicle-path $\times$ female"
}

//Gender-specific coefficients on spatial frictions, social frictions, and tastes
if "`gender_specific'"=="gender_specific" {
	foreach var of varlist time_public_home_log time_public_work_log time_public_path_log time_car_home_log time_car_work_log time_car_path_log {
		gen `var'_female = `var' * female if gender_nd==0
		label variable `var'_female "Log travel time $\times$ female"
	}
	foreach var of varlist  ///
	eucl_demo_distance spectralsegregationindex eucl_demo_distance_ssi ///
	asian_percent black_percent hispanic_percent other_percent {
		gen `var'_female = `var' * female if gender_nd==0
	}
	foreach var of varlist d_price_? avgrating d_cuisine_? {
		gen `var'_female = `var' * female if gender_nd==0
	}
}


gen user_weight = 1
label variable user_weight "User weight"

if "`nestid'"!="" local nest_id = "nestid(`nestid')"

if "`cuisinetype_midaggregate'"=="cuisinetype_midaggregate" local d_cuisine_m = "d_cuisine_m"
if "`gender_specific'"!="gender_specific" covariates_racespecific, command(keep) `nest_id' `d_cuisine_m' `vehicle_avail_hhshare_diff' `spatial_income' `spatial_age' `spatial_gender'
if "`gender_specific'"!="gender_specific" covariates_racespecific, command(order) `nest_id' `d_cuisine_m' `vehicle_avail_hhshare_diff' `spatial_income' `spatial_age' `spatial_gender'
if "`gender_specific'"=="gender_specific" covariates_genderspecific, command(keep)
if "`gender_specific'"=="gender_specific" covariates_genderspecific, command(order)

gsort userid_num tripnumber -chosen venue_num


end


cap program drop covariates_racespecific
program define   covariates_racespecific

syntax, command(string) [nestid(string)] [d_cuisine_m] [vehicle_avail_hhshare_diff spatial_income spatial_age spatial_gender]

if "`d_cuisine_m'" == "d_cuisine_m" local d_cuisine_m_vars = "d_cuisine_m_*"
if "`spatial_income'" == "spatial_income" local spatial_income_vars = "time_public_home_log_income time_car_home_log_income time_public_work_log_income time_car_work_log_income time_public_path_log_income time_car_path_log_income"
if "`spatial_age'" == "spatial_age" local spatial_age_vars = "time_public_home_log_21to39 time_car_home_log_21to39 time_public_work_log_21to39 time_car_work_log_21to39 time_public_path_log_21to39 time_car_path_log_21to39"
if "`spatial_gender'" == "spatial_gender" local spatial_gender_vars = "time_public_home_log_female time_car_home_log_female time_public_work_log_female time_car_work_log_female time_public_path_log_female time_car_path_log_female"

`command' tripnumber chosen userid_num venue_num user_weight `nestid'	/// //Variables describing the trip; I'm dropping userid and venue because this is the estimation array itself and Matlab hates strings
geoid11_???? female asian black whithisp gender_nd race_nd /// //Informative info, but not actually used by Matlab code
time_*_home_log time_*_work_log time_*_path_log 	/// //Spatial frictions X1
`spatial_income_vars'`spatial_age_vars' `spatial_gender_vars' /// //Robustness check covariate
eucl_demo_distance spectralsegregationindex eucl_demo_distance_ssi /// //Social frictions: X2
asian_percent black_percent hispanic_percent other_percent ///
d_price_?_income avgrating_income /// //User-restaurant interactions: Z2
median_income_percent_difference med_income_perc_diff_signed median_income_log  /// Income differences 
d_price_? avgrating d_cuisine_? /// //Basic restaurant characteristics: Z1
robberies_0711_perres d_area_dummy*  /// //Robberies from NYPD microdata, area dummies/FEs
reviews_log chain `d_cuisine_m_vars' /// //Optional restaurant characteristics used in robustness checks
`vehicle_avail_hhshare_diff' //Robustness check covariate

end



cap program drop covariates_genderspecific
program define   covariates_genderspecific

syntax, command(string)

`command' tripnumber chosen userid_num venue_num user_weight /// //Variables describing the trip; I'm dropping userid and venue because this is the estimation array itself and Matlab hates strings
geoid11_???? female asian black whithisp gender_nd race_nd /// //Informative info, but not actually used by Matlab code
time_*_home_log time_*_work_log time_*_path_log 	/// //Spatial frictions X1
time_*_home_log_female time_*_work_log_female time_*_path_log_female 	/// //Spatial frictions X1
eucl_demo_distance spectralsegregationindex eucl_demo_distance_ssi /// //Social frictions: X2
eucl_demo_distance_female spectralsegregationindex_female eucl_demo_distance_ssi_female /// //Social frictions: X2
asian_percent black_percent hispanic_percent other_percent ///
asian_percent_female black_percent_female hispanic_percent_female other_percent_female ///
d_price_?_income avgrating_income /// //User-restaurant interactions: Z2
median_income_percent_difference med_income_perc_diff_signed median_income_log  /// Income differences 
d_price_? avgrating d_cuisine_? /// //Basic restaurant characteristics: Z1
d_price_?_female avgrating_female d_cuisine_?_female /// //Basic restaurant characteristics: Z1
robberies_0711_perres d_area_dummy*  /// //Robberies from NYPD microdata, area dummies/FEs
reviews_log chain

end


//The program "estimationarray" starts with a choice set (chosen-tripnumber-userid-venue) and attaches all the observable characteristics of users, venues, and tracts that could be used in an estimated specification.
cap program drop estarray_noworklocation
program define estarray_noworklocation
syntax using/,  saveas(string) [dropvars(string)] 

//Tract and tract-pair characteristics
tempfile tf_geoid11_dest tf_geoid11_home tf_geoid11_home_pair
use geoid11 *_percent spectral* robberies* median_household_income area_dummy_assignment using "../input/tract_2010_characteristics_est.dta", clear
rename geoid11 geoid11_dest
save `tf_geoid11_dest', replace
use geoid11 median_household_income share_21to39 using "../input/tract_2010_characteristics_est.dta", clear
rename (geoid11 median_household_income) (geoid11_home median_household_income_home)
save `tf_geoid11_home', replace
use geoid11_???? median_income_percent_difference med_income_perc_diff_signed eucl_demo_distance traveltime_car traveltime_public vehicle_avail_hhshare_diff using "../input/tract_pairs_2010_characteristics_est.dta", clear
rename (geoid11_orig traveltime_public traveltime_car) (geoid11_home time_public_home time_car_home)
save `tf_geoid11_home_pair', replace

//Merge user characteristics, venue characteristics, tract-pair characteristics, etc for every choice
use "`using'", clear
merge m:1 userid_num using "../input/users_homeonlysample.dta", nogen keep(match) assert(using match)
merge m:1 venue_num using "../input/venues_est.dta", nogen keep(match) assert(using match)
rename geoid11 geoid11_dest
merge m:1 geoid11_dest using  `tf_geoid11_dest', nogen keep(match) assert(using match)
merge m:1 geoid11_home using  `tf_geoid11_home', nogen keep(match) assert(using match)
merge m:1 geoid11_home geoid11_dest using `tf_geoid11_home_pair', nogen keep(match) assert(using match)

//Covariate preparation
prepcovariates_noworklocation
if "`dropvars'"!="" drop `dropvars'

//Drop fixed effects that are equal to negative infinity
foreach var of varlist d_area_* d_price_? d_cuisine_?  {
	qui count if chosen==1 & `var'==1
	if `r(N)'==0 {
		tab chosen `var'
		drop if `var'==1
		drop `var'
	}
}

//Drop columns that are entirely zeros
foreach var of varlist d_price_?_income {
	qui count if `var'!=0
	if `r(N)'==0 drop `var'
}

//Save
compress
label data "Estimation array"
saveold "`saveas'", replace version (11)

end




cap program drop prepcovariates_noworklocation
program define prepcovariates_noworklocation

//Transform transit-time variables
foreach var of varlist time_public_home time_car_home {
	gen `var'_log = log(`var' + 1)
	label variable `var'_log "Log of travel time in minutes [ln(t+1)]"
}

gen median_income_log = log(median_household_income*10000)

//Generate dummies
sort price
tab price, gen(d_price_)
sort area_dummy_assignment
tab area_dummy_assignment, gen(d_area_dummy_)
sort cuisinetype_aggregate
tab cuisinetype_aggregate, gen(d_cuisine_)
drop d_price_1 d_area_dummy_1 d_cuisine_8 //Omitted categories: price of $, Bronx, "no_category" of cuisine, white plurality (dropped below)

//Label variables
label var eucl_demo_distance "Euclidean demographic distance between \$ h\$ and \$ k_j\$"
label var spectralsegregationindex "Spectral segregation index of \$ k_j\$"
forvalues i=2/4 {
	label var d_price_`i' "Dummy for `i'-dollar bin"
}
label var median_income_percent_difference "Percentage absolute difference in median incomes (\$ h - k_j\$)"
label var med_income_perc_diff_signed "Percent difference in median incomes (\$ k_j - h \$)"
label var median_income_log "Log median household income in $ k_j$"
label variable robberies_0711_perres    "Average annual robberies per resident in $ k_j$, 2007-2011"
label var geoid11_home "Census tract (11-digit FIPS) of user's residence"
label var geoid11_dest "Census tract (11-digit FIPS) of venue"

//Generate demographic interaction terms
gen eucl_demo_distance_ssi = eucl_demo_distance * spectralsegregationindex
label var eucl_demo_distance_ssi "Euclidean demographic distance $\times$ spectral segregation index"

//Generate tract-level bilateral relations
gen other_percent = max(0,1 - asian_percent - black_percent - hispanic_percent - white_percent)
label variable other_percent "Percent of tract population that is other"

//Generate income-price, income-rating
foreach var of varlist d_price_? avgrating {
	gen `var'_income = `var' * median_household_income_home
}
label variable d_price_2_income  "Dummy for 2-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_3_income  "Dummy for 3-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_4_income  "Dummy for 4-dollar bin $\times$ home tract median income (10k USD)"
label variable avgrating_income "Average rating of restaurant $\times$ home tract median income"

gen user_weight = 1
label variable user_weight "User weight"

covariates_noworklocation, command(keep)
covariates_noworklocation, command(order)

gsort userid_num tripnumber -chosen venue_num

end


cap program drop covariates_noworklocation
program define   covariates_noworklocation

syntax, command(string)

`command' tripnumber chosen userid_num venue_num user_weight /// //Variables describing the trip; I'm dropping userid and venue because this is the estimation array itself and Matlab hates strings
geoid11_???? female asian black whithisp gender_nd race_nd /// //Informative info, but not actually used by Matlab code
time_*_home_log  /// //Spatial frictions X1
eucl_demo_distance spectralsegregationindex eucl_demo_distance_ssi /// //Social frictions: X2
asian_percent black_percent hispanic_percent other_percent ///
d_price_?_income avgrating_income /// //User-restaurant interactions: Z2
median_income_percent_difference med_income_perc_diff_signed median_income_log  /// Income differences 
d_price_? avgrating d_cuisine_? /// //Basic restaurant characteristics: Z1
robberies_0711_perres d_area_dummy*  //Robberies from NYPD microdata, area dummies/FEs

end
