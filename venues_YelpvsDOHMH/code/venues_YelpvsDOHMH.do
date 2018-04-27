//Load counts of restaurants by ZIP
use "../input/YelpvsDOHMH_ZIPs.dta", clear

//Prep graphs display
gen mismatch = abs(count_yelp-count_dohmh)/count_dohmh
replace mismatch = abs(count_yelp-count_dohmh)/count_yelp if count_dohmh==0
gen str label1 = ""
replace label1 = zip if mismatch >.5 & count_dohmh~=1 & count_yelp~=1

//Graph
twoway (scatter count_yelp count_dohmh, mlabel(label1)) , graphregion(color(white))  ylab(0(200)800, nogrid) xlab(0(200)800, nogrid)
graph export "../output/figure_A2.pdf", replace

exit, clear
