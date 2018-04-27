/***********************
** PROGRAMS DEFINITIONS
***********************/

cap program drop loadandmerge_dissim_bsdraws
program define loadandmerge_dissim_bsdraws

	syntax , instances(integer) inputcsvstub(string) inputcsvpairstub(string) outputdtafile(string) outputpairsdtafile(string) level(string)

//Load bootstrap results (only need to run once)
forvalues i = 1/`instances' {
	capture confirm file "`inputcsvstub'`i'.csv"
	if _rc==0 {
		tempfile tf`i'
		import delimited using "`inputcsvstub'`i'.csv", clear
		gen int j = 1*(spec=="prob_visit_`level'_standard") + 2*(spec=="prob_visit_`level'_nospatial") + 3*(spec=="prob_visit_`level'_nosocial") + 4*(spec=="prob_visit_`level'_neither") + 5*(spec=="prob_visit_`level'_home_standard") + 6*(spec=="prob_visit_`level'_home_nosocial")
		rename dissimilarityindex dissimilarity_
		drop spec
		reshape wide dissimilarity, i(race) j(j)
		gen instance = `i'
		saveold `tf`i'', replace	
	}
}
clear
forvalues i = 1/`instances' {
	capture confirm file `tf`i''
	if _rc==0 append using `tf`i''
}
saveold "`outputdtafile'", replace

forvalues i = 1/`instances' {
	capture confirm file "`inputcsvpairstub'`i'.csv"
	if _rc==0 {
		tempfile  tf`i'_pair
		import delimited using "`inputcsvpairstub'`i'.csv", clear
		gen int j = 1*(spec=="prob_visit_`level'_standard") + 2*(spec=="prob_visit_`level'_nospatial") + 3*(spec=="prob_visit_`level'_nosocial") + 4*(spec=="prob_visit_`level'_neither") + 5*(spec=="prob_visit_`level'_home_standard") + 6*(spec=="prob_visit_`level'_home_nosocial")
		rename dissimilarityindex dissimilarity_
		drop spec
		reshape wide dissimilarity, i(race1 race2) j(j)
		gen instance = `i'
		saveold `tf`i'_pair', replace
	}
}
clear
forvalues i = 1/`instances' {
	capture confirm file `tf`i'_pair'
	if _rc==0 append using `tf`i'_pair'
}
saveold "`outputpairsdtafile'", replace

end

cap program drop dissim_textable_CIs
program define  dissim_textable_CIs

syntax , inputdtafile(string) inputpairwisedtafile(string) resultfile(string) resultpairwisefile(string) ///
	filename(string) tablecaption(string) tablelabel(string) level(string) ///
	[coeffestimate_source(string)] ///
	[upper_pctile(real 97.5) lower_pctile(real 2.5)]

//Compute bootstrap confidence intervals and combine with main results
use "`inputdtafile'",  clear
qui count if race=="asian"
local numberofdraws = `r(N)'
foreach var of varlist dissimilarity_1-dissimilarity_4 {
	bys race: egen `var'_p_lower = pctile(`var'),p(`lower_pctile')
	by  race: egen `var'_p_upper = pctile(`var'),p(`upper_pctile')
	gen str `var'_2 = "[" + subinstr(strofreal(`var'_p_lower,"%5.3f"),"0.",".",1) + "," + subinstr(strofreal(`var'_p_upper,"%5.3f"),"0.",".",1) + "]"
}
keep race dissimilarity_?_?
duplicates drop
merge 1:1 race using `resultfile', keepusing(dissimilarity_?_1) assert(match) nogen
cap drop dissimilarity_5_?
cap drop dissimilarity_6_?
drop if race=="other"
reshape long dissimilarity_0_ dissimilarity_1_ dissimilarity_2_ dissimilarity_3_ dissimilarity_4_, i(race) j(j)
sort race
replace race = subinstr(race,"asian","Asian",1)
replace race = subinstr(race,"hispanic","Hispanic",1)

	gen str race2 = ""
	replace race = "" if j==2
	listtex race race2 dissimilarity_0_ dissimilarity_1_ dissimilarity_2_ dissimilarity_3_ dissimilarity_4_ using "`filename'", replace  rstyle(tabular) ///
	head("\begin{table}[h!] \centering \caption{`tablecaption'} \label{`tablelabel'}" ///
	"\begin{tabular}{llccccc} \toprule" ///
	"&&Residential   & \multicolumn{4}{c}{Consumption dissimilarity} \\ \cline{4-7}" ///
	"&&dissimilarity & Estimated & No spatial & No social & Neither friction  \\ \hline " ///
	"&&(1)&(2)&(3)&(4)&(5)\\ \midrule" ///
	"\multicolumn{2}{l}{\textit{Dissimilarity index}}\\") ///
	foot("\midrule")

use "`inputpairwisedtafile'", clear
foreach var of varlist dissimilarity_? {
	bys race1 race2: egen `var'_p_lower = pctile(`var'),p(`lower_pctile')
	by  race1 race2: egen `var'_p_upper = pctile(`var'),p(`upper_pctile')
	gen str `var'_2 = "[" + subinstr(strofreal(`var'_p_lower,"%5.3f"),"0.",".",1) + "," + subinstr(strofreal(`var'_p_upper,"%5.3f"),"0.",".",1) + "]"
}
keep race1 race2 dissimilarity_?_?
duplicates drop
merge 1:1 race1 race2 using `resultpairwisefile', keepusing(dissimilarity_?_1) assert(match) nogen
drop dissimilarity_5_? dissimilarity_6_?
reshape long dissimilarity_0_ dissimilarity_1_ dissimilarity_2_ dissimilarity_3_ dissimilarity_4_, i(race1 race2) j(j)
sort race1 race2
replace race1 = subinstr(race1,"asian","Asian",1)
replace race1 = subinstr(race1,"hispanic","Hispanic",1)
replace race2 = subinstr(race2,"asian","Asian",1)
replace race2 = subinstr(race2,"hispanic","Hispanic",1)

	replace race1 = "" if j==2
	replace race2 = "" if j==2
	local CIrange = `upper_pctile' - `lower_pctile'
	listtex race1 race2 dissimilarity_0_ dissimilarity_1_ dissimilarity_2_ dissimilarity_3_ dissimilarity_4_, appendto("`filename'")   rstyle(tabular) ///
	head("\multicolumn{2}{l}{\textit{Pairwise dissimilarity}}&\\") ///
	foot("\bottomrule" "\multicolumn{7}{p{\textwidth}}{\footnotesize{\textsc{Notes}: This table reports dissimilarity indices. The upper panel reports the index for each demographic group's residential/consumption locations compared to members of all other demographic groups. The lower panel reports the index for residential/consumption locations between each pair of demographic groups. The demographic group ''other'' is included in computations but not reported. Column 1 reports indices based on tracts' residential populations. The remaining columns report `level'-level dissimilarity indices based on the coefficient estimates `coeffestimate_source'. Column 2 uses the estimated coefficients. Column 3 sets the coefficients on travel-time covariates to zero. Column 4 sets the coefficients on demographic-difference covariates to zero. Column 5 sets the coefficients on travel-time and demographic-difference covariates to zero. Bootstrapped `CIrange'\% confidence intervals from `numberofdraws' draws reported in brackets.}}" ///
	"\end{tabular}\end{table}")

end

/***********************
** PROGRAMS CALLS
***********************/

loadandmerge_dissim_bsdraws, instances(500) level(venue) inputcsvstub("../input/dissim_venue_mainspec_instance") inputcsvpairstub("../input/dissim_pairwise_venue_mainspec_instance") ///
	outputdtafile("../output/dissim_venues_mainspec_merged.dta") outputpairsdtafile("../output/dissim_pairwise_venues_mainspec_merged.dta")

//Load main results
tempfile tf0 tf0_pair
import delimited using "../input/dissim_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf0', replace
import delimited using  "../input/dissim_venues_mainspec.csv", clear
gen int j = 1*(spec=="prob_visit_venue_standard") + 2*(spec=="prob_visit_venue_nospatial") + 3*(spec=="prob_visit_venue_nosocial") + 4*(spec=="prob_visit_venue_neither") + 5*(spec=="prob_visit_venue_home_standard") + 6*(spec=="prob_visit_venue_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf0'
reshape wide dissimilarity, i(race) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
saveold `tf0', replace

import delimited using "../input/dissim_pairwise_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf0_pair', replace
import delimited using  "../input/dissim_pairwise_venues_mainspec.csv", clear
gen int j = 1*(spec=="prob_visit_venue_standard") + 2*(spec=="prob_visit_venue_nospatial") + 3*(spec=="prob_visit_venue_nosocial") + 4*(spec=="prob_visit_venue_neither") + 5*(spec=="prob_visit_venue_home_standard") + 6*(spec=="prob_visit_venue_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf0_pair'
reshape wide dissimilarity, i(race1 race2) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
desc
saveold `tf0_pair', replace

clear
dissim_textable_CIs, inputdtafile("../output/dissim_venues_mainspec_merged.dta") inputpairwisedtafile("../output/dissim_pairwise_venues_mainspec_merged.dta") ///
	resultfile(`tf0') resultpairwisefile(`tf0_pair') ///
	filename("../output/dissimilarity_venues_mainspec.tex") ///
	tablecaption("Residential and consumption segregation") tablelabel("tab:dissimilarity:bootstrap") /// 
	coeffestimate_source("in columns 4-6 of Table \ref{tab:mainestimates}") level(venue) ///
	upper_pctile(97.5) lower_pctile(2.5)

shell sed -i -e 's/whithisp\&/\\multicolumn{2}{l}{white or Hispanic}/' ../output/dissimilarity_venues_mainspec.tex

//Minimum-time specification


//Load and merge bootstrapped results
loadandmerge_dissim_bsdraws, instances(500) level(venue) inputcsvstub("../input/dissim_venue_mintime_instance") inputcsvpairstub("../input/dissim_pairwise_venue_mintime_instance") ///
	outputdtafile("../output/dissim_venues_mintime_merged.dta") outputpairsdtafile("../output/dissim_pairwise_venues_mintime_merged.dta")

//Load minimum-time results
tempfile tf1 tf1_pair
import delimited using "../input/dissim_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf1', replace
import delimited using  "../input/dissim_venues_mintime.csv", clear
gen int j = 1*(spec=="prob_visit_venue_standard") + 2*(spec=="prob_visit_venue_nospatial") + 3*(spec=="prob_visit_venue_nosocial") + 4*(spec=="prob_visit_venue_neither") + 5*(spec=="prob_visit_venue_home_standard") + 6*(spec=="prob_visit_venue_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf1'
reshape wide dissimilarity, i(race) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
saveold `tf1', replace

import delimited using "../input/dissim_pairwise_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf1_pair', replace
import delimited using  "../input/dissim_pairwise_venues_mintime.csv", clear
gen int j = 1*(spec=="prob_visit_venue_standard") + 2*(spec=="prob_visit_venue_nospatial") + 3*(spec=="prob_visit_venue_nosocial") + 4*(spec=="prob_visit_venue_neither") + 5*(spec=="prob_visit_venue_home_standard") + 6*(spec=="prob_visit_venue_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf1_pair'
reshape wide dissimilarity, i(race1 race2) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
desc
saveold `tf1_pair', replace

clear
dissim_textable_CIs, inputdtafile("../output/dissim_venues_mintime_merged.dta") inputpairwisedtafile("../output/dissim_pairwise_venues_mintime_merged.dta") ///
	resultfile(`tf1') resultpairwisefile(`tf1_pair') ///
	filename("../output/dissimilarity_venues_mintime.tex") ///
	tablecaption("Residential and consumption segregation") tablelabel("tab:dissimilarity:bootstrap") /// 
	coeffestimate_source("in column 1 of Tables \ref{tab:asian_robust1_mintime} - \ref{tab:whithisp_robust1_mintime}") level(venue) ///
	upper_pctile(97.5) lower_pctile(2.5)

shell sed -i -e 's/whithisp\&/\\multicolumn{2}{l}{white or Hispanic}/' ../output/dissimilarity_venues_mintime.tex



//TRACT-LEVEL SIXOM SPECIFICATION 

//The "level(venue)" misnomer is due to an upstream mis-naming of the prob_visit_venue variables
loadandmerge_dissim_bsdraws, instances(500) level(venue) inputcsvstub("../input/dissim_tract_mainspec_instance") inputcsvpairstub("../input/dissim_pairwise_tract_mainspec_instance") ///
	outputdtafile("../output/dissim_tracts_merged.dta") outputpairsdtafile("../output/dissim_pairwise_tracts_merged.dta")

local level = "venue"

//Load main results
tempfile tf0 tf0_pair
import delimited using "../input/dissim_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf0', replace
import delimited using  "../input/dissim_tracts_mainspec.csv", clear
gen int j = 1*(spec=="prob_visit_`level'_standard") + 2*(spec=="prob_visit_`level'_nospatial") + 3*(spec=="prob_visit_`level'_nosocial") + 4*(spec=="prob_visit_`level'_neither") + 5*(spec=="prob_visit_`level'_home_standard") + 6*(spec=="prob_visit_`level'_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf0'
reshape wide dissimilarity, i(race) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
saveold `tf0', replace

import delimited using "../input/dissim_pairwise_residential.csv", clear
gen int j = 0
rename dissimilarityindex dissimilarity_
saveold `tf0_pair', replace
import delimited using  "../input/dissim_pairwise_tracts_mainspec.csv", clear
gen int j = 1*(spec=="prob_visit_`level'_standard") + 2*(spec=="prob_visit_`level'_nospatial") + 3*(spec=="prob_visit_`level'_nosocial") + 4*(spec=="prob_visit_`level'_neither") + 5*(spec=="prob_visit_`level'_home_standard") + 6*(spec=="prob_visit_`level'_home_nosocial")
rename dissimilarityindex dissimilarity_
drop spec
append using `tf0_pair'
reshape wide dissimilarity, i(race1 race2) j(j)
foreach var of varlist dissimilarity_? {
	gen str `var'_1 =  strofreal(`var',"%5.3f")
}
desc
saveold `tf0_pair', replace

clear
dissim_textable_CIs, inputdtafile("../output/dissim_tracts_merged.dta") inputpairwisedtafile("../output/dissim_pairwise_tracts_merged.dta") ///
	resultfile(`tf0') resultpairwisefile(`tf0_pair') ///
	filename("../output/dissimilarity_tracts_mainspec.tex") ///
	tablecaption("Tract-level residential and consumption segregation") tablelabel("tab:dissimilarity:bootstrap:tracts") /// 
	coeffestimate_source("in columns 4-6 of Table \ref{tab:mainestimates}") level(tract) ///
	upper_pctile(97.5) lower_pctile(2.5)

shell sed -i -e 's/whithisp\&/\\multicolumn{2}{l}{white or Hispanic}/' ../output/dissimilarity_tracts_mainspec.tex

exit, clear
