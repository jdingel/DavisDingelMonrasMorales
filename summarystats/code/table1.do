/***********************
** METADATA
***********************/

/****
Created by: Joan Monras
Date: July 2014; Aug 2014; 2018
Project: Yelp
Purpose: Generate (1) tables of summary statistics 
Inputs:	 Data files containing set of users, tracts, or tract pairs, specified at time of program call, and isolation index inputs
Outputs: Tables 1 and A.1. The program also computes a number of intermediate tables. 
****/

/***********************
** COMPUTING RESOURCES
***********************/

clear all
set more off


/***********************
** PROGRAMS
***********************/

cap program drop generate_dummies
program define generate_dummies

gen geoid5 = substr(geoid11,1,5)
keep if geoid5=="36005"|geoid5=="36047"|geoid5=="36061"|geoid5=="36081"|geoid5=="36085"
tab geoid5, gen(d_geoid5_)
tab price, gen(d_price_)
tab cuisinetype_aggregate, gen(d_cuisine_)
drop if avgrating==0
tab avgrating, gen(d_avgrating_)
tab race_plurality, gen(d_race_plurality)

//User race is already dummies in users.dta: whithisp black asian race_nd
//User gender is already dummies in users.dta: male, female, gender_nd

end

program define collapse_with_labels
syntax varlist, stat(string)

if "`stat'"~="sum" & "`stat'"~="mean" break

  foreach v of var * {
 	local l`v' : variable label `v'
        if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
  }
collapse (`stat') `varlist'
foreach v of var * {
	label var `v' "`l`v''"
}

end

cap program drop users_stats
program define users_stats

syntax using/, variables(string) [extravars(string)] [texfilename(string)]  [if(string)] [append] [users_publicationlabels] [title(string)]

if "`append'"=="" local append = "replace"
if "`title'"=="" local title = "User summary statistics"

use `using', clear

**Restrict to user-level variables and confirm that these are all user-level variables
keep userid  `variables' `extravars'		//29 Oct 2014: Stripped out "user *l??_home *l??_work home home*work county_???? census_tract_???? mover"
foreach var of varlist `variables' {    //29 Oct 2014:  Stripped out "county_???? *l??_home *l??_work home home*work census_tract_???? mover"
	tempvar tv0
	qui bys userid: egen `tv0' = sd(`var')
	qui summ `tv0'
	if r(max)> (10^-6) & r(N)~=0 {
		disp "Error: Some of the specified variables are not user-level variables"
		disp "Problem with variable: `var'"
		error 109
	}
}
**Impose if conditions specified in program call
if "`if'"~="" keep if `if'

//option to re-label the variables
`users_publicationlabels'

**Produce summary stats table, output to TeX if requested
summ `variables'

if "`texfilename'"~="" sutex `variables', labels title(`title') key(tab:summ_users_stats) file("`texfilename'") `append' digits(3)
end



cap program drop tracts_stats
program define tracts_stats

syntax using/, tractid(string) variables(string) [texfilename(string)] [weights(string)] [if(string)] [tracts_publicationlabels] 

use `using', clear

**Restrict to tract-level variables and confirm that these are all tract-level variables
keep `tractid' `variables'
foreach var of varlist `variables' {
	tempvar tv0
	qui bys `tractid': egen `tv0' = sd(`var')
	qui summ `tv0'
	if r(max)> (10^-6) & r(N)~=0 {
		disp "Error: Some of the specified variables are not tract-level variables"
		disp "Problem with variable: `var'"
		error 109
	}
}
**Impose if conditions specified in program call
if "`if'"~="" keep if `if'
**Drop duplicates since we're working at tract level
qui duplicates drop
//Change variable labels to the shorter labels requested by Eduardo
`tracts_publicationlabels'
**Produce summary stats table, output to TeX if requested
summ `variables'
if "`texfilename'"~="" sutex `variables' `weights', labels title(Tract-level summary statistics) key(tab:summ_tracts_stats) file(`texfilename') replace

end

cap program drop table1
program define table1


auxiliary_tables //This builds various tables at trips and user level (see code below)

// COMBINATION OF SEVERAL TABLES TO OBTAIN TABLE 1 (Jan 2018). This piece of codes uses .tex tables generated above and combines them

*** User level stats

tempfile t1 t2 t3 t4

import delimited "../output/summ_users_stats.tex", clear delimiter("&")
drop if v2=="" | v2==" \textbf{Mean}" | v2==" \textbf{Std. Dev.} \\ \hline"
drop if v1=="Number of restaurant reviews in estimation sample " | v1==""
replace v3 = subinstr(v3, "\\", "",.) 
replace v2 = subinstr(v2, " \multicolumn{2}{c}{","",.) 
replace v2 = subinstr(v2, "}\\ \hline\end{tabular}","",.)
keep v1 v2
ren (v1 v2) (var_name stat1)
count 
local aux=`r(N)'
replace var_name="Observations" in `aux'
replace var_name="Female" if var_name=="User appears female in profile photo "
replace var_name="Male" if var_name=="User appears male in profile photo "
replace var_name="White or Hispanic" if var_name=="User appears white or Hispanic in profile photo "
replace var_name="Asian" if var_name=="User appears Asian in profile photo "
replace var_name="Black" if var_name=="User appears black in profile photo "
replace var_name="User race indeterminate" if var_name=="User race indeterminate in profile photo "
replace var_name="Median household income (thousands)" if var_name=="Median household income of home census tract (thousands dollars) "
replace var_name="Age 21-39 residents share" if var_name=="Share of home census tract population that is age 21-39 "
destring stat1, gen(aux)
gen aux_str = string(aux,"%6.1f") if var_name=="Median household income (thousands)"
replace stat1=aux_str if var_name=="Median household income (thousands)"
keep var_name stat1
save `t1'.dta, replace //First column of Table 1

*** Tract level stats

local varlist "summ_tracts_MN_stats_weighted.tex summ_tracts_stats_weighted.tex"
local i=2
foreach var of local varlist{
import delimited "../output/`var'", clear delimiter("&") 
drop if v2=="" | v2==" \textbf{Mean}" | v2==" \textbf{Std. Dev.} \\ \hline" 
drop v3
replace v2 = subinstr(v2, " \multicolumn{2}{c}{", "",.) 
replace v2 = subinstr(v2, "}\\ \hline\end{tabular}", "",.) 
replace v1="Observations" if v1=="\multicolumn{1}{c}{N} "
destring(v2), replace
gen aux_str = string(v2,"%6.3f") if v1!="Observations"
replace aux_str = string(v2,"%6.0f") if v1=="Observations"
replace aux_str = string(v2,"%6.1f") if v1=="Median household income (thousands dollars) "
ren (v1 aux_str) (var_name stat`i')
drop v2
replace var_name="Asian" if var_name=="Percent of tract population that is Asian "
replace var_name="Black" if var_name=="Percent of tract population that is black "
replace var_name="\quad Hispanic" if var_name=="Percent of tract population that is Hispanic "
replace var_name="\quad White" if var_name=="Percent of tract population that is white "
gen aux=stat`i' if var_name=="\quad Hispanic" | var_name == "\quad White" 
count 
local aux=`r(N)'+1
set obs `aux'
destring(aux), replace
egen aux2=sum(aux)
replace aux2=round(aux2,.01)
gen aux_str = string(aux2,"%6.3f") 
drop aux aux2
replace stat`i'=aux_str in `aux'
replace var_name="White or Hispanic" in `aux'
drop aux_str
replace var_name="Male" if var_name=="Male share of census tract population "
replace var_name="Age 21-39 residents share" if var_name=="Share of census tract population that is age 21-39 "
replace var_name="Median household income (thousands)" if var_name=="Median household income (thousands dollars) "
drop if var_name=="Population " | var_name=="Average annual robberies per resident in tract, 2007-2011 " | var_name =="Land area (square kilometers) " | var_name =="Tract is plurality Asian " | var_name =="Tract is plurality black " | var_name =="Tract is plurality white " | var_name =="Tract is plurality Hispanic " 
gen aux=stat`i' if var_name=="Male"
destring(aux), replace
replace aux=1-aux
count 
local aux=`r(N)'+1
set obs `aux'
egen aux2=max(aux)
drop aux
gen aux_str = string(aux2,"%6.3f")
replace stat`i'=aux_str in `aux'
replace var_name="Female" in `aux'
drop aux**
save `t`i''.dta, replace //Second and third columns of Table 1
local i=`i'+1
}

*** Isolation index stats

import delimited "../output/residential_isolation_indices.tex", clear delimiter("&")
keep if v1=="Manhattan residential population" | v1=="Estimation sample" | v1=="NYC residential population"
replace v4 = subinstr(v4, "\\", "",.) 
forvalues i=2(1)4 {
destring(v`i'), replace
gen v`i'_str = string(v`i',"%6.3f") 
}
drop v2 v3 v4
sxpose, clear firstnames
ren _var1 stat3
ren _var2 stat2
ren _var3 stat1
gen var_name=""
replace var_name="Asian isolation index" in 1 
replace var_name="Black isolation index" in 2 
replace var_name="White/Hispanic isolation index" in 3 
save `t4'.dta, replace

use `t1'.dta, replace
merge 1:1 var_name using `t2'.dta, nogen
merge 1:1 var_name using `t3'.dta, nogen
append using `t4'.dta
drop if var_name=="Spectral segregation index for tract's plurality "
gen order=1 if var_name=="Female"
replace order=2 if var_name=="Male"
replace order=3 if var_name=="Asian"
replace order=4 if var_name=="Black"
replace order=5 if var_name=="White or Hispanic"
replace order=6 if var_name=="\quad Hispanic"
replace order=7 if var_name=="\quad White"
replace order=8 if var_name=="User race indeterminate"
replace var_name="Reviewer race indeterminate" if var_name=="User race indeterminate"
replace order=9 if var_name=="Median household income (thousands)"
replace order=10 if var_name=="Age 21-39 residents share"
replace order=11 if var_name=="Asian isolation index"
replace order=12 if var_name=="Black isolation index"
replace order=13 if var_name=="White/Hispanic isolation index"
replace var_name="\\ Observations" if var_name=="Observations"

sort order
drop order

gen delimiter1="&"
gen delimiter2="&"
gen delimiter3="&"
gen delimiter4="\\"

order var_name delimiter1 stat1 delimiter2 stat2 delimiter3 stat3 delimiter4

gen order=_n
count 
local aux=`r(N)'+3
local aux1=`r(N)'+2
local aux2=`r(N)'+1
set obs `aux'

replace order=-1 in `aux2'
replace var_name = "\begin{tabular}{l c c c  } \toprule & Estimation sample & Manhattan & NYC \\ & Yelp reviewers & tracts & tracts \\ \midrule \multicolumn{2}{l}{\textit{Reviewer appearance / Tract demographics}} &&  \\" in `aux2'

replace order=8.5 in `aux1'
replace var_name = "\textit{Home tract characteristics} &&& \\" in `aux1'

replace order=100 in `aux'
replace var_name = "\bottomrule \end{tabular} \\  " in `aux'

sort order
drop if var_name=="AREA CHARACTERISTICS - Population Count (100\%) "

drop order

listtex using "../output/sumstats_table1.tex", replace delimiter(" ")

end


cap program drop auxiliary_tables
program define auxiliary_tables


//USER CHARACTERISTICS
//Build a user-level summary statistics table
tempfile tf_users
use "../input/users_est.dta", clear
clonevar geoid11 = geoid11_home
merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", nogen assert(using match) keep(match) keepusing(median_household_income share_21to39) 
replace median_household_income = 10 * median_household_income
label var median_household_income "Median household income of home census tract (thousands dollars)"
//gen whithisp = (white==1|hispanic==1|whiteorhispanic==1)
label var asian        "User appears Asian in profile photo"
label var whithisp     "User appears white or Hispanic in profile photo"
label var share_21to39 "Share of home census tract population that is age 21-39"
label var race_nd      "User race indeterminate in profile photo"
save `tf_users', replace
users_stats using `tf_users', variables(female male whithisp asian black race_nd median_household_income share_21to39) texfilename(../output/summ_users_stats.tex)

//TRACT CHARACTERISTICS: Should it be if(population~=0) or if(median_household_income~=.)?
tempfile tf_tracts tf_tractsMN
use "../input/tract_2010_characteristics_est.dta", clear
replace median_household_income = 10 * median_household_income
label var median_household_income "Median household income (thousands dollars)"
label var share_male "Male share of census tract population"
label var share_21to39 "Share of census tract population that is age 21-39"
save `tf_tracts', replace
keep if substr(geoid11,1,5)=="36061"
save `tf_tractsMN', replace

tracts_stats using `tf_tracts', tractid(geoid11)  weights([w=population])  if(missing(median_household_income)==0) variables(population median_household_income asian_percent  black_percent hispanic_percent white_percent share_male share_21to39 ) texfilename(../output/summ_tracts_stats_weighted.tex) 
tracts_stats using `tf_tractsMN', tractid(geoid11)  weights([w=population]) if(missing(median_household_income)==0) variables(population median_household_income asian_percent  black_percent hispanic_percent white_percent share_male share_21to39 ) texfilename(../output/summ_tracts_MN_stats_weighted.tex) 


/*ISOLATION INDEXES**/


//tempfile to collect results along the way
tempfile tf_results tf0 tf1 
clear
set obs 1
gen str row = "Estimation sample"
gen byte empty = .
save `tf0', replace
replace row = "Yelp users with located residences"
save `tf1', replace

//compute isolation indices for NYC residential population
use geoid11 *percent population using "../input/tract_2010_characteristics_est.dta", clear
gen whithisp_percent = white_percent + hispanic_percent
foreach race in asian black whithisp {
	gen double `race'_pop = `race'_percent * population
	egen double `race'_total = total(`race'_pop)
	egen double `race'_iso = total((`race'_pop / `race'_total) * `race'_percent)
}
keep if _n == 1
list *_iso
gen str row = "NYC residential population"
keep row *_iso
save `tf_results', replace

//compute isolation indices for Manhattan
use geoid11 *percent population if substr(geoid11,1,5)=="36061" using "../input/tract_2010_characteristics_est.dta", clear
gen whithisp_percent = white_percent + hispanic_percent
foreach race in asian black whithisp {
	gen double `race'_pop = `race'_percent * population
	egen double `race'_total = total(`race'_pop)
	egen double `race'_iso = total((`race'_pop / `race'_total) * `race'_percent)
}

keep if _n == 1
list *_iso
gen str row = "Manhattan residential population"
keep row *_iso
append using `tf_results'
save `tf_results', replace


//estimation sample
foreach race in asian black whithisp {
	use "../input/users_est.dta", clear
	//gen byte whithisp=(white==1|hispanic==1|whiteorhispanic==1)
	keep if `race'==1
	rename (geoid11_home) (geoid11)
	merge m:1 geoid11 using "../input/tract_2010_characteristics_est.dta", assert(using match) keep(match) keepusing(*_percent)
	if "`race'"=="whithisp" gen whithisp_percent = white_percent + hispanic_percent
	collapse (mean) `race'_iso = `race'_percent
	list
	gen str row = "Estimation sample"
	merge 1:1 row using `tf0',  assert(match) nogen
	save `tf0', replace
}
append using `tf_results'
save `tf_results', replace



order row asian_iso black_iso whithisp_iso
recode empty .=1 if regexm(row,"population")==1
recode empty .=2 if regexm(row,"Yelp")==1|regexm(row,"Estimation")==1
gsort empty -black
foreach var of varlist *iso {
	replace `var' = round(`var',.001)
}
listtex row asian_iso black_iso whithisp_iso using "../output/residential_isolation_indices.tex", replace  rstyle(tabular) ///
head("\begin{tabular}{lccc} \toprule"  "& \multicolumn{3}{c}{Isolation indices} \\ \cline{2-4}" "& Asian & Black & White/Hispanic \\ \midrule")  ///
foot("\bottomrule" "\end{tabular}")


end



/***********************
** PROGRAM CALLS
***********************/
//Install all Stata packages required by this replication code
foreach package in sxpose {
	capture which `package'
	if _rc==111 ssc install `package'
}


table1 //This produces Table 1 in the paper. Combining various summary stats tables. 


exit, clear
