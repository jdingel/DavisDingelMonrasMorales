//Jonathan Dingel, Jan 2018

cap program drop compute_race_gaps
program define compute_race_gaps

	//This program presumes that there are variables of the names
	//asian_identifiedshare black_identifiedshare whithisp_identifiedshare

	syntax , [venuevars(varlist)] [pairvars(varlist)]
	
	sort pairing venue_num
	by pairing: gen j = _n
	keep pairing j race_nd *_identifiedshare venue_num `pairvars' `venuevars'
	reshape wide race_nd *_identifiedshare venue_num `venuevars', i(pairing) j(j)
	gen race_gap = (1/sqrt(2))*sqrt((asian_identifiedshare1 - asian_identifiedshare2)^2 + (black_identifiedshare1 - black_identifiedshare2)^2 + (whithisp_identifiedshare1 - whithisp_identifiedshare2)^2)


end

cap program drop compute_isoindexelements
program define compute_isoindexelements

	//This program presumes that there are variables of the names
	//"pairing venue asian black whitehispanic race_nd venue_trips"
	//It will compute, for each race, the within-pair difference in
	// [(v_gj/v_g)*((v_gj-1)/(v_j-1)) - (v_-gj/v_-g)*((v_-gj)/(v_j-1))]
	// where v_j is venue_trips - race_nd, 
	// venue_gj is "asian", "black", or "whitehispanic"
	// v_g is defined as "total(asian)", "total(black)", or "total(whitehispanic)"
	// we need to comptue v_-gj and v_-g

	sort pairing venue_num
	gen v_j = venue_trips - race_nd
	foreach var of varlist asian black whithisp {
		egen `var'_g = total(`var')
		gen `var'_notgj = v_j - `var'
		egen `var'_notg = total(`var'_notgj)
		gen element_`var' = (`var'/`var'_g)*((`var'-1)/(v_j-1)) - (`var'_notgj/`var'_notg )*((`var'_notgj)/(v_j-1))
	}
	by pairing: gen j = _n
	keep pairing venue_num j asian black whithisp element_asian element_black element_whithisp
	reshape wide venue_num asian black whithisp element_asian element_black element_whithisp, i(pairing) j(j)
	foreach race in asian black whithisp {
		gen diff_element_`race' = abs(element_`race'1 - element_`race'2)
	}

end



tempfile tf_data tf_shuffle
use "../input/observationallyequivalentvenuesdata.dta", clear
save `tf_shuffle'
collapse (sum) asian black whithisp race_nd (firstnm) pairing venue_trips, by(venue_num)
qui compute_isoindexelements
summ diff*
keep pairing venue_num? diff*
gen byte data = 1
save `tf_data', replace

//Shuffle and compute gaps for random allocation
tempfile tf_shuffle_venuelist tf_shuffle_firstvenueshare
use venue_num pairing venue_trips using `tf_shuffle', clear
duplicates drop
sort pairing venue_num
by pairing: gen venue_countwithinpair = _n 
save `tf_shuffle_venuelist', replace
by pairing: egen firstvenuecount = total((venue_countwithinpair==1)*venue_trips)
keep pairing firstvenuecount
duplicates drop
save `tf_shuffle_firstvenueshare', replace
use `tf_shuffle', clear
keep pairing black asian whithisp race_nd whithisp
merge m:1 pairing using `tf_shuffle_firstvenueshare', nogen assert(match) keepusing(firstvenuecount)

tempfile tf_snapshot tf_draw1 tf_draw2 tf_draw3 tf_draw4 tf_draw5 tf_draw6 tf_draw7 tf_draw8 tf_draw9
save `tf_snapshot', replace

forvalues i = 1/9 {
	use `tf_snapshot', clear
	sort pairing black asian whithisp //Needed to make the procedure deterministic conditional on seed.
	local seed = real(substr("987654321",1,`i'))
	display "`seed'"
	quietly {
	set seed `seed'
	sort pairing
	gen uniform = runiform()
	}

	quietly {
	sort pairing uniform
	by pairing: gen venue_countwithinpair = 2 - inrange(_n,1,firstvenuecount)
	merge m:1 pairing venue_countwithinpair using `tf_shuffle_venuelist', nogen assert(match) keepusing(venue_num)  //Are m:1 merges deterministic?
	gen venue_trips = 1
	collapse (sum) asian black whithisp race_nd venue_trips (firstnm) pairing, by(venue_num)
	}
qui compute_isoindexelements
summ diff*
keep pairing venue_num? diff*
gen byte data = 0
	qui save `tf_draw`i'', replace

}

//Plot a figure comparing data to null hypothesis
use `tf_data', clear
forvalues i=1/9 {
	append using `tf_draw`i''
}

foreach var of varlist diff_element_* {
	ttest `var', by(data)
}

foreach race in asian black whithisp {
	qui ttest diff_element_`race', by(data)
	//display "The data size should be 125:  `r(N_2)'"
	local data_mean_`race' = substr(string(`r(mu_2)'),1,5)
	local null_mean_`race' = substr(string(`r(mu_1)'),1,5)
	display "The mean of the difference in the data is `data_mean_`race'' and under the null is `null_mean_`race'' for `race'."
	local pvalue_`race' = substr(string(`r(p_l)'),1,5)
	display "The p-value for the one-sided test of equal means is `pvalue_`race''."
}

display "The mean of the difference for Asian consumers in the data is `data_mean_asian' and under the null is `null_mean_asian', `data_mean_black' and `null_mean_black' for black consumers, and `data_mean_whithisp' and `null_mean_whithisp' for white/Hispanic consumers. The p-values for the one-sided tests of equal means are `pvalue_asian', `pvalue_black', and `pvalue_whithisp', respectively."

shell echo "The mean of the difference for Asian consumers in the data is `data_mean_asian' and under the null is `null_mean_asian', `data_mean_black' and `null_mean_black' for black consumers, and `data_mean_whithisp' and `null_mean_whithisp' for white/Hispanic consumers. The p-values for the one-sided tests of equal means are `pvalue_asian', `pvalue_black', and `pvalue_whithisp', respectively." > ../output/schelling_ttest_appendix_sentence.tex


twoway (kdensity diff_element_asian if data==1 & inrange(diff_element_asian,0,.01), lpattern(solid) lcolor(red)) (kdensity diff_element_asian if data==0 & inrange(diff_element_asian,0,.01), lpattern(dash) lcolor(red))  ///
(kdensity diff_element_black if data==1 & inrange(diff_element_black,0,.01), lpattern(solid) lcolor(black)) (kdensity diff_element_black if data==0 & inrange(diff_element_black,0,.01), lpattern(dash) lcolor(black))  ///
(kdensity diff_element_whithisp if data==1 & inrange(diff_element_whithisp,0,.01), lpattern(solid) lcolor(blue)) (kdensity diff_element_whithisp if data==0 & inrange(diff_element_whithisp,0,.01), lpattern(dash) lcolor(blue)), ///
ytitle(Density) xtitle(Within-pair difference in isolation index contribution) graphregion(color(white)) ///
legend(label(1 "Data (Asian)") label(2 "Null hypothesis (Asian)") ///
label(3 "Data (black)") label(4 "Null hypothesis (black)") ///
label(5 "Data (white/Hispanic)") label(6 "Null hypothesis (white/Hispanic)") region(style(none))) 

graph export "../output/schelling_isoindexelements.pdf", replace as(pdf)



tempfile tf_data tf_shuffle
use "../input/observationallyequivalentvenuesdata.dta", clear
save `tf_shuffle'

//2a. Quadruplet computations: Compute venue-level race shares based on trips and user
collapse (mean) black asian whithisp race_nd (firstnm) pairing venue_trips, by(venue_num)
foreach var of varlist black asian whithisp {
	gen `var'_identifiedshare = `var' / (1-race_nd)
}

//2b. Quadruplet computations: Look for gaps within pairs in their race shares
compute_race_gaps, venuevars(venue_trips)
keep pairing venue_num1 venue_num2 race_gap
save `tf_data', replace

//2c. Shuffle and compute gaps for random allocation
tempfile tf_shuffle_venuelist tf_shuffle_firstvenueshare
use venue_num pairing venue_trips using `tf_shuffle', clear
duplicates drop
sort pairing venue_num
by pairing: gen venue_countwithinpair = _n 
save `tf_shuffle_venuelist', replace
by pairing: egen firstvenuecount = total((venue_countwithinpair==1)*venue_trips)
keep pairing firstvenuecount
duplicates drop
save `tf_shuffle_firstvenueshare', replace
use `tf_shuffle', clear
keep pairing black asian whithisp race_nd
merge m:1 pairing using `tf_shuffle_firstvenueshare', nogen assert(match) keepusing(firstvenuecount)

	tempfile tf_snapshot tf_draw1 tf_draw2 tf_draw3 tf_draw4 tf_draw5 tf_draw6 tf_draw7 tf_draw8 tf_draw9
	
	save `tf_snapshot', replace


	forvalues i = 1/9 {
		use `tf_snapshot', clear
		sort pairing asian black whithisp //Needed to make the procedure deterministic conditional on seed.
		local seed = real(substr("987654321",1,`i'))
		display "`seed'"
		quietly {
		set seed `seed'
		sort pairing
		gen uniform = runiform()
		}

		quietly {
		sort pairing uniform
		by pairing: gen venue_countwithinpair = 2 - inrange(_n,1,firstvenuecount)
		merge m:1 pairing venue_countwithinpair using `tf_shuffle_venuelist', nogen assert(match) keepusing(venue_num)  //Are m:1 merges deterministic?
		collapse (mean) black asian whithisp race_nd (firstnm) pairing, by(venue_num)
		foreach var of varlist black asian whithisp {
			gen `var'_identifiedshare = `var' / (1-race_nd)
		}
		compute_race_gaps
		keep pairing venue_num1 venue_num2 *gap*
		rename race_gap race_gap_null
		}
		qui save `tf_draw`i'', replace

	}
	

//2d. Compare gaps
use `tf_draw1', clear
merge 1:1 pairing venue_num1 venue_num2 using `tf_data', gen(mergeresult) update keepusing(*gap*)
list if mergeresult!=3
forvalues i = 2/9 {
	append using `tf_draw`i''
}

ttest race_gap == race_gap_null, unpaired
local num1 = round(`r(mu_1)',.001)
local num2 = round(`r(mu_2)',.001)
local num3 = round(`r(p_u)',.001)
display "The mean of the race gap for the observed data is `num1'. The mean for the random distribution is `num2'. The p-value for the one-sided test of equal means is `num3'."
shell echo "The mean of the race gap for the observed data is `num1'. The mean for the random distribution is `num2'. The p-value for the one-sided test of equal means is `num3'." > ../output/schelling_ttest_sentence.tex

twoway (kdensity race_gap, bw(.03)) (kdensity race_gap_null, bw(.03) lpattern(dash)), xtitle("Race gap")   ytitle(Density) graphregion(color(white)) legend(label(1 "Observed") label(2 "Null hypothesis (uniform distribution)") region(style(none)))
graph export "../output/racegapvsnull.pdf", replace as(pdf)

exit, clear
