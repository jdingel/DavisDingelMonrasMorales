/****
Created by: Jonathan Dingel
Date: April 2018
Description: Gather two objects: the "sample value" for 500 bootstrap estimation samples and the 100-draws confidence intervals associated with each bootstrap
Inputs:
Estimation samples from bootstrap DGP: /project/jdingel/Yelp_parametric_bootstrap_simulation/data/array_`race'users/array_`race'users_instance`i'.csv
Confidence intervals for bootstrapped estimates: /project/jdingel/Yelp2/bootstrap_isoindex/output/isoindices_`i'.dta
****/

clear all
set more off

/**********************
** PROGRAM DEFINITIONS
***********************/

qui do "bootstrap_isoindex_programs.do"

cap program drop gather_isoindices_distros
program define gather_isoindices_distros

	syntax, start(integer) end(integer) outputfile(string)

	tempfile tf0
	forvalues i=`start'/`end' { 
		capture confirm file "../output/isoindices_`i'.dta"
		if _rc==0 {
		qui use "../output/isoindices_`i'.dta", clear
		qui gen int bsdraw = `i'
		if `i'!=1 append using `tf0'
		qui save `tf0', replace
		}
		else {
		     display "The file ../output/isoindices_`i'.dta does not exist"
		}

	}
	save "`outputfile'", replace

end

cap program drop plot_p5p95_densities
program define plot_p5p95_densities

	syntax using/, outputgraphfilename(string) a5(real) a95(real) b5(real) b95(real) wh5(real) wh95(real)

	if inrange(`a5',0,1)==0|inrange(`a5',0,1)==0|inrange(`b5',0,1)==0|inrange(`b95',0,1)==0|inrange(`wh5',0,1)==0|inrange(`wh95',0,1)==0 error 109

	use "`using'", clear
	collapse ///
		(p5) iso_asian_lvout_p5 = iso_asian_lvout iso_black_lvout_p5 = iso_black_lvout iso_whithisp_lvout_p5 = iso_whithisp_lvout ///
		(p95) iso_asian_lvout_p95 = iso_asian_lvout iso_black_lvout_p95 = iso_black_lvout iso_whithisp_lvout_p95 = iso_whithisp_lvout ///
		, by(bsdraw)
	
	twoway (kdensity iso_asian_lvout_p5, lcolor(black)) (kdensity  iso_asian_lvout_p95, lcolor(black)), ///
	xline(`a5', lcolor(black) lpattern(shortdash)) xline(`a95', lcolor(black) lpattern(shortdash)) ///
	graphregion(color(white)) legend(off) name(graph_asian, replace) xtitle("Asian leave-out isolation index") 
	
	twoway (kdensity iso_black_lvout_p5, lcolor(black)) (kdensity  iso_black_lvout_p95, lcolor(black)), ///
	xline(`b5', lcolor(black) lpattern(dash)) xline(`b95', lcolor(black) lpattern(dash)) ///
	graphregion(color(white)) legend(off) name(graph_black, replace) xtitle("Black leave-out isolation index") 
	
	twoway (kdensity iso_whithisp_lvout_p5, lcolor(black)) (kdensity  iso_whithisp_lvout_p95, lcolor(black)), /// 
	xline(`wh5', lcolor(black) lpattern(longdash)) xline(`wh95', lcolor(black) lpattern(longdash)) ///
	graphregion(color(white)) legend(off) name(graph_whithisp, replace) xtitle("White/Hispanic leave-out isolation index")
	
	graph combine graph_asian graph_black graph_whithisp, rows(1) ysize(2)  graphregion(color(white)) iscale(1.4)
	graph export "`outputgraphfilename'", as(pdf) replace
	
	end

/**********************
** PROGRAM CALLS
***********************/

//Draw lines at the values observed in the data
use iso_asian_lvout iso_black_lvout iso_whithisp_lvout instance using "../input/isoindices_sixom_mainspec.dta", clear
	collapse ///
		(p5) a5 = iso_asian_lvout b5 = iso_black_lvout wh5 = iso_whithisp_lvout ///
		(p95) a95 = iso_asian_lvout b95 = iso_black_lvout wh95 = iso_whithisp_lvout
foreach pctile in a5 a95 b5 b95 wh5 wh95 {
	summ `pctile'
	local `pctile'_val = `r(mean)'
}

gather_isoindices_distros, start(1) end(500) outputfile("../output/isoindices_1to500.dta")
plot_p5p95_densities using "../output/isoindices_1to500.dta", ///
	a5(`a5_val') a95(`a95_val') b5(`b5_val') b95(`b95_val') wh5(`wh5_val') wh95(`wh95_val') /// These are the p5 and p95 from the MLE reported in the paper as the 90% CI 
	outputgraphfilename("../output/isoindices_p5p95distros.pdf") 

exit, clear
