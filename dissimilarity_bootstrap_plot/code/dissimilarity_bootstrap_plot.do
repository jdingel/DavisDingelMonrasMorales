clear all

//Values from Table 6
import delimited using "../input/dissimilarity_index_venue_level_sixom_mainspec.csv", clear
keep if spec=="prob_visit_venue_standard"
foreach race in asian black hispanic white whithisp {
	summ dissimilarityindex if race=="`race'"
	local estimate_`race' = `r(mean)'
}
local asian_title = "Asian"
local black_title = "black"
local hispanic_title = "Hispanic"
local white_title = "white"
local whithisp_title = "white or Hispanic"

use "../input/dissim_venues_mainspec_merged.dta", clear

foreach race in asian black hispanic white whithisp {
	twoway (kdensity dissimilarity_1 if race=="`race'", lcolor(black) bwidth(.001)) , ///
	xline(`estimate_`race'', lcolor(black) lpattern(shortdash)) ///
	graphregion(color(white)) legend(off) name(graph_`race', replace) xtitle("``race'_title' consumption dissimilarity") ytitle(Density)
}

graph combine graph_asian graph_black graph_hispanic graph_white graph_whithisp, cols(2) name(graph_001_nonotes) ///
	graphregion(color(white)) 
graph export "../output/dissimilarity_bootstrap_plot.pdf", replace

//Values from Table 6
import delimited using "../input/dissimilarity_index_venue_level_sixom_mainspec.csv", clear
keep if spec=="prob_visit_venue_standard"
foreach race in asian black hispanic white whithisp {
	summ dissimilarityindex if race=="`race'"
	local estimate_`race' = `r(mean)'
}

use "../input/dissim_venues_mainspec_merged.dta", clear
matrix collect = J(5,3,.)
local i=0
foreach race in asian black hispanic white whithisp {
	local i = `i' + 1
	qui summ dissimilarity_1 if race=="`race'"
	local bias = round(`estimate_`race'' - `r(mean)',.001)
	local stddev = round(`r(sd)',.001)
	display "For `race', the estimate minus the average bootstrapped value is `bias' and the standard deviation of bootstrapped values is `stddev'."
	mat collect[`i',1] = round(`estimate_`race'',.001)
	mat collect[`i',2] = `bias'
	mat collect[`i',3] = `stddev'
}
matrix rownames collect  = asian black hispanic white whithisp
matrix colnames collect = estimate diff stddev
mat list collect

clear
svmat collect, names(col)
gen str race = ""
local i=0
foreach race in asian black hispanic white whithisp {
	local i = `i' + 1
	replace race = "``race'_title'" if _n==`i'
}
listtex race estimate diff stddev using "../output/dissimilarity_bootstrap_table.tex", replace  rstyle(tabular) ///
	head("\begin{table}[!h] \caption{Bootstrapped dissimilarity indices} \label{tab:dissimilaritybootstrap}" "\vspace{-3mm} \begin{center} \begin{tabular}{lccc} \toprule" ///
	"Race & Estimate & Difference & Standard deviation \\ \hline") ///
	foot("\bottomrule \end{tabular} \\" "\begin{minipage}{.65\textwidth} {\footnotesize \textsc{Notes}: First column reports estimate from Table \ref{tab:dissimilarity:bootstrap}. Second column reports estimate minus the average of the bootstrapped distribution of dissimilarity indices. The third column reports the standard deviation of the bootstrapped distribution.\par} \end{minipage}" "\end{center}\end{table}")

exit, clear

