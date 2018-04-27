
//The program "estimationarray" starts with a choice set (chosen-tripnumber-userid-venue) and attaches all the observable characteristics of users, venues, and tracts that could be used in an estimated specification.
cap program drop estarray_venueFE_racespecific
program define estarray_venueFE_racespecific
syntax using/,  saveas(string) [dropvars(string)]

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
prepcovariates_venueFE
if "`dropvars'"!="" drop `dropvars'

//Save
compress
label data "Estimation array"
saveold "`saveas'", replace

end

//This program is directory-specific! It is different than that found in the observables specifications' directory.

//The program "prepcovariates" tranforms many variables into the version that will be used estimation -- the triangle inequality yields the commuting path, logs are taken, dummies are generated for categorical variables, venue and tract characteristics are interacted with demographic and gender dummies, etc.
cap program drop prepcovariates_venueFE
program define prepcovariates_venueFE

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

//Label variables
label var eucl_demo_distance "Euclidean demographic distance between \$ h\$ and \$ k_j\$"
label var median_income_percent_difference "Percentage absolute difference in median incomes (\$ h - k_j\$)"
label var med_income_perc_diff_signed "Percent difference in median incomes (\$ k_j - h \$)"

//Generate demographic interaction terms
gen eucl_demo_distance_ssi = eucl_demo_distance * spectralsegregationindex
label var eucl_demo_distance_ssi "Euclidean demographic distance $\times$ spectral segregation index"

//Generate dummies
sort price
tab price, gen(d_price_)

//Generate income-price, income-rating
foreach var of varlist d_price_? avgrating {
	gen `var'_income = `var' * median_household_income_home
}
label variable d_price_2_income  "Dummy for 2-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_3_income  "Dummy for 3-dollar bin $\times$ home tract median income (10k USD)"
label variable d_price_4_income  "Dummy for 4-dollar bin $\times$ home tract median income (10k USD)"
label variable avgrating_income "Average rating of restaurant $\times$ home tract median income"

//Keep the identifying information and 14 covariates
keep  userid_num tripnumber venue_num chosen time*log eucl_demo_distance eucl_demo_distance_ssi d_price_2_income d_price_3_income d_price_4_income avgrating_income median_income_percent_difference med_income_perc_diff_signed
order userid_num tripnumber venue_num chosen time*log eucl_demo_distance eucl_demo_distance_ssi d_price_2_income d_price_3_income d_price_4_income avgrating_income median_income_percent_difference med_income_perc_diff_signed
gsort userid_num tripnumber -chosen venue_num

end

