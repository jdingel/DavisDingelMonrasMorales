//Install all Stata packages required by this replication code
foreach package in outreg2 spmap listtex {
	capture which `package'
	if _rc==111 ssc install `package'
}

// Prepare temporary files with "origin" and "destination" tract characteristics
tempfile tf_orig tf_dest 
foreach endpoint in orig dest {
	use geoid11 median_household_income asian black white hispanic other population vehicle* using "../input/tracts.dta", clear
	rename (*) (*_`endpoint')
	save `tf_`endpoint'', replace
}

//Generate tract-pair characteristics from income, racial/ethnic shares, and vehicle data
use geoid11_orig geoid11_dest physical_distance traveltime_public traveltime_car using "../input/tractpairs.dta", clear
merge m:1 geoid11_orig using `tf_orig', assert(match) nogen
merge m:1 geoid11_dest using `tf_dest', assert(match) nogen
gen median_income_percent_difference = abs(median_household_income_orig - median_household_income_dest)/(.5*median_household_income_orig +.5*median_household_income_dest)
label var median_income_percent_difference "Percentage absolute difference in median incomes between tracts"
gen med_income_perc_diff_signed = (median_household_income_dest - median_household_income_orig)/(.5*median_household_income_orig +.5*median_household_income_dest)
label var med_income_perc_diff_signed "Percent difference in median incomes (destination minus origin)"
gen eucl_demo_distance = (1/sqrt(2))*sqrt((white_orig/population_orig - white_dest/population_dest)^2 + (black_orig/population_orig - black_dest/population_dest)^2 + (asian_orig/population_orig - asian_dest/population_dest)^2 + (hispanic_orig/population_orig - hispanic_dest/population_dest)^2 + (other_orig/population_orig - other_dest/population_dest)^2)
label var eucl_demo_distance "Euclidean demographic distance between tracts"
gen vehicle_avail_hhshare_diff = abs(vehicle_avail_hhshare_orig - vehicle_avail_hhshare_dest)
label variable vehicle_avail_hhshare_diff "Absolute difference in vehicle availability"

keep geoid11_orig geoid11_dest physical_distance traveltime_public traveltime_car median_income_percent_difference med_income_perc_diff_signed eucl_demo_distance vehicle_avail_hhshare_diff
save "../output/tract_pairs_2010_characteristics_est.dta", replace

//CSV files for map-making in ArcGIS: figure3_example1.jpg, figure3_example2.jpg
use geoid11_orig geoid11_dest eucl_demo_distance if geoid11_orig=="36061021100" using "../output/tract_pairs_2010_characteristics_est.dta", clear
export delimited using "../output/figure3_example1.csv", replace
use geoid11_orig geoid11_dest eucl_demo_distance if geoid11_orig=="36061000800" using "../output/tract_pairs_2010_characteristics_est.dta", clear
export delimited using "../output/figure3_example2.csv", replace

//Save tract characteristics file
use "../input/tracts.dta", clear
drop asian black hispanic white other other_percent
save "../output/tract_2010_characteristics_est.dta", replace

//Prepare tract and tract-pair characteristics files that will be used by estimation arrays
use geoid11 asian_percent black_percent hispanic_percent white_percent spectral* robberies* median_household_income area_dummy_assignment using "../input/tracts.dta", clear
rename geoid11 geoid11_dest
save "../output/geoid11_dest.dta", replace
use geoid11 median_household_income share_21to39 using "../input/tracts.dta", clear
rename (geoid11 median_household_income) (geoid11_home median_household_income_home)
save "../output/geoid11_home.dta", replace
use geoid11_???? median_income_percent_difference med_income_perc_diff_signed eucl_demo_distance traveltime_car traveltime_public vehicle_avail_hhshare_diff using "../output/tract_pairs_2010_characteristics_est.dta", clear
rename (geoid11_orig traveltime_public traveltime_car) (geoid11_home time_public_home time_car_home)
save "../output/geoid11_home_pair.dta", replace
use geoid11_???? traveltime_car traveltime_public using "../output/tract_pairs_2010_characteristics_est.dta", clear
rename (geoid11_orig traveltime_public traveltime_car) (geoid11_work time_public_work time_car_work)
save "../output/geoid11_work_pair.dta", replace
rename (geoid11_work geoid11_dest time_public_work time_car_work) (geoid11_home geoid11_work time_public_home_work time_car_home_work)
save "../output/geoid11_home_work.dta", replace


exit, clear
