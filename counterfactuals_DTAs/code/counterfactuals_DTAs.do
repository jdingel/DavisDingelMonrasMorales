//Dingel, April 2018

//2nd Avenue Subway counterfactual

use "../input/tract_pairs_2010_characteristics_est.dta", clear
merge 1:1 geoid11_orig geoid11_dest using "../input/traveltime_gain_new_line.dta", keep(master match) nogen keepusing(difference_t_line)
replace traveltime_public = max(0,traveltime_public - difference_t_line) //JOAN: bring the counterfactual traveltimes public transport
drop difference_t_line
save "../output/tract_pairs_2ndAve.dta", replace

//20% transit slowdown counterfactual
use "../input/tract_pairs_2010_characteristics_est.dta", clear
replace traveltime_public = 1.2 * traveltime_public  //Counterfactual of 20% travel-time increase
replace traveltime_car    = 1.2 * traveltime_car     //Counterfactual of 20% travel-time increase
save "../output/tract_pairs_slowdown.dta", replace


//20% social-friction reduction counterfactual
foreach race in asian black whithisp {
	import delimited using "../input/estimates_`race'_mainspec.csv", clear varnames(1)
	keep names estimates
	replace estimates = 0.8*estimates if names=="eucl_demo_distance"|names=="eucl_demo_distance_ssi"|names=="asian_percent"|names=="black_percent"|names=="hispanic_percent"|names=="other_percent"
	export delimited using "../output/socialchange_parameters_`race'.csv", replace
}

exit, clear
