//25 Oct 2015: Three densities appearing in "Travel times, demographic differences, and consumer choice"

//Load data
use userid_num venue_num chosen time* eucl_demo_distance using "../input/estarray_raceblind.dta", clear

//Convert travel times
gen time_public_home = exp(time_public_home_log) + 1
gen time_public_work = exp(time_public_work_log) + 1

//Identify 99-percentile upper bounds of plots
summ time_public_home, d
local time_public_home_p99 = r(p99)
summ time_public_work, d
local time_public_work_p99 = r(p99)

//Produce kernel density plots
twoway (kdensity time_public_home if chosen==1 & time_public_home<`time_public_home_p99', bw(3)) (kdensity time_public_home if chosen==0 & time_public_home<`time_public_home_p99', bw(3) lpattern(dash)),  graphregion(color(white)) legend(label(1 "Reviewed") label(2 "Unreviewed")) ytitle("Density", size(large)) xtitle("Minutes of travel time from home by public transit", size(large)) xlabel(,labsize(large)) ylabel(,nogrid) legend(region(style(none)) size(large))
graph export "../output/rdfm_timehome_density.pdf", as(pdf) replace
twoway (kdensity time_public_work if chosen==1 & time_public_work<`time_public_work_p99', bw(3)) (kdensity time_public_work if chosen==0 & time_public_work<`time_public_work_p99', bw(3) lpattern(dash)),  graphregion(color(white)) legend(label(1 "Reviewed") label(2 "Unreviewed")) ytitle("Density", size(large)) xtitle("Minutes of travel time from work by public transit", size(large)) xlabel(,labsize(large)) ylabel(,nogrid) legend(region(style(none)) size(large))
graph export "../output/rdfm_timework_density.pdf", as(pdf) replace
twoway (kdensity eucl_demo_distance if chosen==1, bw(.1)) (kdensity eucl_demo_distance if chosen==0, bw(.1) lpattern(dash)),  graphregion(color(white)) legend(label(1 "Reviewed") label(2 "Unreviewed")) ytitle("Density") xtitle("Euclidean demographic distance", size(large)) xlabel(,labsize(large)) ylabel(,nogrid) legend(region(style(none)) size(large))
graph export "../output/rdfm_eucl_density.pdf", as(pdf) replace

exit, clear
