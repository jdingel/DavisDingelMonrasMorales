//Author: Joan Monras
//Last revised: Jan 2018

set more off

cap program drop dot_map_residence
program define dot_map_residence
	
	syntax ,  [saveas(string)] [dot_size(integer 1)] [savegraphas(string)]

	tempfile tf_geoid11_database tf_zoomcuts_dest
	use "../input/geoid11_coords.dta", clear
	collapse (firstnm) _ID, by(geoid11)
	save `tf_geoid11_database', replace
	use "../input/dotmap_zoomcuts.dta", clear
	rename geoid11 geoid11_dest
	save `tf_zoomcuts_dest', replace
	

	tempfile tf1 tf2 tf3 tf_v1 tf4 
		
	//Pr(h,r) from population shares by race across Manhattan
	use geoid11 asian black white hispanic other population using "../input/tracts.dta", clear
	rename (asian black hispanic white other population) (pop1 pop2 pop3 pop4 pop5 total_population)
 	qui reshape long pop, i(geoid11) j(race)
 
 
	gen double prob_hr = pop / total_population

 	ren geoid11 geoid11_home

 	label data "The distribution of Manhattan population by race and tract"
	
	keep geoid11_home geoid11 race prob_hr total_pop
	ren geoid11_hom geoid11_dest
	
	tempfile tf_dots tf_centroid tf_random

	clonevar geoid11 = geoid11_dest
	gen byte manhattan = substr(geoid11_dest,1,5)=="36061"

	recode prob_hr .=0
	gen visits = prob_hr * `dot_size'
	
	bysort geoid11_dest: egen tot_visits=sum(visits)
	sum tot_visits
	display "TOTAL NUMBER OF POINTS: `r(mean)'"

	tempfile tf_db
	merge m:1 geoid11 using "`tf_geoid11_database'", nogen
	duplicates drop
	save `tf_db', replace
	save "../output/tf_`savegraphas'", replace


	expand visits
	count

	keep geoid11_dest geoid11 race visits manhattan
	
	tempfile tf_dots tf_centroid tf_random
	save `tf_dots', replace


	use "../input/geoid11_coords.dta", clear
	drop if _X==.	
	bysort geoid11: gen border_point=_n
	save `tf_random', replace

	use "../input/geoid11_coords.dta", clear
	drop if _X==.
	bysort geoid11: gen border_point=_n
	collapse (mean) _X_centroid = _X  _Y_centroid = _Y  (max) border_point, by(geoid11)   //JD: It seems code would be faster if you did gen border_points = 1 and (sum) border_points 
	save `tf_centroid', replace
	
	use `tf_dots'
	merge m:1 geoid11 using `tf_centroid', nogen 
	merge m:1 geoid11 using "`tf_geoid11_database'", nogen
	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen
	gen random_border_point=(round((border_point)*uniform()+1)-1)  //JD: Is this equivalent to floor(uniform()*border_points+1)?
	drop border_point
	ren random_border_point border_point
	
	merge m:1 geoid11 border_point using `tf_random', nogen

	gen _X_jitter= _X_centroid+(_X-_X_centroid)*uniform() 
	gen _Y_jitter= _Y_centroid-((_Y-_Y_centroid)/(_X-_X_centroid))*_X_centroid+((_Y-_Y_centroid)/(_X-_X_centroid))*_X_jitter 
	
	drop if race==5 //dropping others
	duplicates drop
	drop if geoid11_dest==""
	drop border_point _X _Y

	gen code_race1=.
	gen r_uniform=runiform()
	replace code_race1=10*race + 1*(r_uniform<3/4) + 2* (r_uniform>=3/4)  //This creates different layers for the same race

	gen code_race=.
	replace code_race=1 if code_race1==11
	replace code_race=2 if code_race1==21
	replace code_race=3 if code_race1==31
	replace code_race=4 if code_race1==41
	replace code_race=4 if code_race1==42
	replace code_race=5 if code_race1==32
	replace code_race=6 if code_race1==22
	replace code_race=7 if code_race1==12
	save "../output/tf_dots", replace
	
	use `tf_db', clear
	keep geoid11_dest geoid11 _ID manhattan
	duplicates drop
	ren geoid11 geoid11_code
	ren geoid11_dest geoid11
	merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen
	ren geoid11 geoid11_dest
	ren geoid11_code geoid11
	

tempfile tf_db2 tf_dots1 tf_dots2 tf_dots3 tf_dots4

save "../output/tf_db_res.dta", replace

use "../output/tf_dots", replace
	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen

keep if zoom==1
save "../output/tf_dots1", replace
use "../output/tf_db_res.dta", clear

	spmap if zoom==1 using "../input/geoid11_coords.dta", id(_ID) ///
	point(data("../output/tf_dots1") xcoord(_X_jitter) ycoord(_Y_jitter)by(code_race) fcolor(red ebblue orange midgreen orange ebblue red) /// shape(o d t s t d o)
        size(*1)) label(data("../input/dotmap_labels_harlem.dta")xcoord(x_coord) ycoord(y_coord) label(label) size(large large large)  angle("horizontal" "75" "-13") by(angle)) 
	graph export "../output/`savegraphas'_zoom1.pdf", replace // width(600) 


use "../output/tf_dots", replace
	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen

keep if zoom==3 | zoom==4

save "../output/tf_dots34", replace
use "../output/tf_db_res.dta", clear
	spmap if zoom==3 | zoom==4 using "../input/geoid11_coords.dta", id(_ID) ///
	point(data("../output/tf_dots34") xcoord(_X_jitter) ycoord(_Y_jitter)by(code_race) fcolor(red ebblue orange midgreen orange ebblue red) /// shape(o d t s t d o)
        size(*.5 *.5 *.5 *.5 *.5 *.5 *.5)) label(data("../input/dotmap_labels_bklyn.dta")xcoord(x_coord) ycoord(y_coord) label(label) size(medium medium medium) angle("horizontal" "75" "-13") by(angle))
	graph export "../output/`savegraphas'_zoom3and4.pdf", replace // width(600) 

	
end

cap program drop dot_map
program define dot_map
	
	syntax using/,  [specification(string)] [saveas(string)] [dot_size(integer 1)] [savegraphas(string)] [zoom(string)] 

	tempfile tf_geoid11_database tf_zoomcuts_dest
	use "../input/geoid11_coords.dta", clear
	collapse (firstnm) _ID, by(geoid11)
	save `tf_geoid11_database', replace
	use "../input/dotmap_zoomcuts.dta", clear
	rename geoid11 geoid11_dest
	save `tf_zoomcuts_dest', replace
	

	tempfile tf1 tf2 tf3 tf_v1 tf4 
	import delimited "`using'", stringcols(1) clear

	keep if specification=="`specification'"
	
	bysort geoid11_dest: egen visits_ct=sum(visits)
	gen double pr_dest_race = visits / visits_ct
	
	drop visits
	gen visits = pr_dest_race * `dot_size' //Re-scaling visits numbers
	
	clonevar geoid11 = geoid11_dest
	gen byte manhattan = substr(geoid11_dest,1,5)=="36061"
	
	egen tot_visits=sum(visits)
	sum tot_visits
	display "TOTAL NUMBER OF POINTS: `r(mean)'"


 	merge m:1 geoid11 using `tf_geoid11_database', keepusing(_ID) assert(using match) keep(match) nogen
	tempfile tf_db
	save `tf_db', replace
	save "../output/tf_`savegraphas'", replace

/* below we create the various points displayed, in different layers to make it visually good*/

	expand visits
	count

	keep geoid11_dest geoid11 race visits manhattan
	
	tempfile tf_dots tf_centroid tf_random
	save `tf_dots', replace

	use "../input/geoid11_coords.dta", clear
	drop if _X==.	
	bysort geoid11: gen border_point=_n
	save `tf_random', replace

	use "../input/geoid11_coords.dta", clear
	drop if _X==.
	bysort geoid11: gen border_point=_n
	collapse (mean) _X_centroid = _X  _Y_centroid = _Y  (max) border_point, by(geoid11)   //JD: It seems code would be faster if you did gen border_points = 1 and (sum) border_points 
	save `tf_centroid', replace
	
	use `tf_dots'
	merge m:1 geoid11 using `tf_centroid', nogen 
	//merge m:1 geoid11 using "$dropbox/maptiles/geoid11_maptile/US_tract_2010_nyc_nostaten/geoid11_database.dta", nogen
	merge m:1 geoid11 using `tf_geoid11_database', nogen
	ren geoid11 geoid11_num
	ren geoid11_dest geoid11
	merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen
	ren geoid11 geoid11_dest
	ren geoid11_num geoid11
	gen random_border_point=(round((border_point)*uniform()+1)-1)  //JD: Is this equivalent to floor(uniform()*border_points+1)?
	drop border_point
	ren random_border_point border_point
	
	merge m:1 geoid11 border_point using `tf_random', nogen
	 
	gen _X_jitter= _X_centroid+(_X-_X_centroid)*uniform() //This creates the dots
	gen _Y_jitter= _Y_centroid-((_Y-_Y_centroid)/(_X-_X_centroid))*_X_centroid+((_Y-_Y_centroid)/(_X-_X_centroid))*_X_jitter 
	
	duplicates drop
	drop if geoid11_dest==""
	drop border_point _X _Y

	encode(race), gen(race_num)
	gen code_race1=.
	gen r_uniform=runiform()
	replace code_race1=10*race_num + 1*(r_uniform<3/4) + 2* (r_uniform>=3/4)  //This is useful to have different layers for the same race that helps visualize the data

	gen code_race=.
	replace code_race=1 if code_race1==11
	replace code_race=2 if code_race1==21
	replace code_race=3 if code_race1==31
	replace code_race=4 if code_race1==41
	replace code_race=4 if code_race1==42
	replace code_race=5 if code_race1==32
	replace code_race=6 if code_race1==22
	replace code_race=7 if code_race1==12
	save "../output/tf_dots", replace
	
	use `tf_db', clear
	keep geoid11_dest geoid11 _ID manhattan
	duplicates drop

	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen

	
tempfile tf_db2 tf_dots1 tf_dots2 tf_dots3 tf_dots4 tf_dots3and4

merge 1:1 geoid11_dest geoid11 using "../output/tf_db_res.dta", nogen
save `tf_db2', replace
save "../output/tf_db2.dta", replace

/* below are the maps with various zooms*/

use "../output/tf_dots", replace
	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen

keep if zoom==1
save "../output/tf_dots1", replace
use `tf_db2', clear
	spmap if zoom==1 using "../input/geoid11_coords.dta", id(_ID) ///
	point(data("../output/tf_dots1") xcoord(_X_jitter) ycoord(_Y_jitter)by(code_race) fcolor(red ebblue orange midgreen orange ebblue red) /// shape(o d t s t d o)
        size(*1)) label(data("../input/dotmap_labels_harlem.dta")xcoord(x_coord) ycoord(y_coord) label(label) size(large large large) angle("horizontal" "75" "-13") by(angle))
	graph export "../output/`savegraphas'_zoom1.pdf", replace // width(600)

use "../output/tf_dots", clear
	merge m:1 geoid11_dest using `tf_zoomcuts_dest', nogen

keep if zoom==3|zoom==4
save "../output/tf_dots3and4", replace
use `tf_db2', clear
	spmap if zoom==3|zoom==4 using "../input/geoid11_coords.dta", id(_ID) ///
	point(data("../output/tf_dots3and4") xcoord(_X_jitter) ycoord(_Y_jitter)by(code_race) fcolor(red ebblue orange midgreen orange ebblue red) /// shape(o d t s t d o)
        size(*.5 *.5 *.5 *.5 *.5 *.5 *.5)) label(data("../input/dotmap_labels_bklyn.dta")xcoord(x_coord) ycoord(y_coord) label(label) size(medium medium medium) angle("horizontal" "75" "-13") by(angle))
	graph export "../output/`savegraphas'_zoom3and4.pdf", replace // width(600)

end



cap program drop sumstats_brooklyn_neighbors
program define sumstats_brooklyn_neighbors

syntax ,  [filename(string)] pathstub(string)

tempfile t t_pop t t_nospat t_nosoc t_neither

use "../input/tract_2010_characteristics_est.dta", clear
merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen keepusing(area community_board zoom) assert(using match) keep(match)
keep if area==19 | area==2 | area==3 |area==15

collapse (mean) asian_percent black_percent hispanic_percent white_percent [aw=population], by(area) 
rename (asian_percent black_percent hispanic_percent white_percent) (percent1 percent2 percent3 percent4)
reshape long percent, i(area) j(race)

save `t_pop', replace

use "`pathstub'est.dta", clear
	ren geoid11 geoid11_num
	ren geoid11_dest geoid11
	merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen
	ren geoid11 geoid11_dest
	ren geoid11_num geoid11
drop if pr_dest_race==.

keep if area==19 | area==2 | area==3 |area==15

encode(race), gen(race_num)
drop race
ren race_num race

keep geoid11_dest race pr_dest_race area
ren geoid11 geoid11

reshape wide pr_dest_race, i(geoid11) j(race)
merge 1:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keep(3) nogen

collapse (mean) pr_dest_race** [aw=population], by(area)

reshape long pr_dest_race, i(area) j(race)

ren pr_dest_race pr_dest_race_estimated

save `t', replace

local varlist "nospat nosoc neither"

foreach var of local varlist {

	display "starting `var' specification"

use "`pathstub'`var'.dta", clear
	ren geoid11 geoid11_num
	ren geoid11_dest geoid11
	merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen
	ren geoid11 geoid11_dest
	ren geoid11_num geoid11
drop if pr_dest_race==.

keep if area==19 | area==2 | area==3 |area==15
keep geoid11_dest race pr_dest_race area geoid11_dest

ren geoid11 geoid11

encode(race), gen(race_num)
drop race
ren race_num race

reshape wide pr_dest_race, i(geoid11) j(race)
merge 1:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keep(3) nogen

collapse (mean) pr_dest_race** [aw=population], by(area)


reshape long pr_dest_race, i(area) j(race)

ren pr_dest_race pr_dest_race_`var'

save `t_`var'', replace
}

use `t_pop', clear
merge 1:1 area race using `t', nogen
merge 1:1 area race using `t_nospat', nogen
merge 1:1 area race using `t_nosoc', nogen
merge 1:1 area race using `t_neither', nogen

foreach var of varlist percent pr_dest_race_estimated pr_dest_race_nospat pr_dest_race_nosoc pr_dest_race_neither { 
	generate `var'_str = string(`var',"%8.3f")
	replace `var'_str = "" if `var'_str=="."
	drop `var'
}


gen race_str=""
replace race_str="Asian" if race==1
replace race_str="black" if race==2
replace race_str="Hispanic" if race==3
replace race_str="white" if race==4

drop race
order area race
gen order=_n

set obs 20
replace order=order+1 if order>4
replace order=order+1 if order>9
replace order=order+1 if order>14

replace order=0 in 17
replace order=5 in 18
replace order=10 in 19
replace order=15 in 20

sort order

replace race_str="\\ & \multicolumn{5}{c}{\textit{Community District 2, Brooklyn: Williamsburg}} \\ \midrule % " if order == 0
replace race_str="\hline \\  & \multicolumn{5}{c}{\textit{Community District 3, Brooklyn: Bedford-Stuyvesant}} \\ \midrule % " if order == 5
replace race_str="\hline \\  & \multicolumn{5}{c}{\textit{Community District 1, Brooklyn: Greenpoint}} \\ \midrule % " if order == 10
replace race_str="\hline \\  & \multicolumn{5}{c}{\textit{Community District 3, Manhattan}} \\ \midrule % " if order == 15


listtex race_str percent_str pr_dest_race_estimated_str pr_dest_race_nospat_str pr_dest_race_nosoc_str pr_dest_race_neither_str using "../output/sums_stats_neighbors_brooklyn.tex", replace ///
rstyle(tabular) head("\begin{tabular}{lccccc} \toprule" "  &  & \multicolumn{4}{c}{Consumption share} \\  \cline{3-6} & Residential share & Estimated & No Spatial & No Social & Neither  \\ \midrule") foot("\bottomrule \end{tabular}")


end



cap program drop sumstats_dotmap_UES
program define sumstats_dotmap_UES

	syntax, pathstub(string)

tempfile t_pop t_est t_nospat t_nosoc t_neither

	tempfile tf_geoid11_database tf_zoomcuts_dest
	use "../input/dotmap_zoomcuts.dta", clear
	rename geoid11 geoid11_dest
	save `tf_zoomcuts_dest', replace

use "../input/tract_2010_characteristics_est.dta", clear
merge m:1 geoid11 using "../input/dotmap_zoomcuts.dta", nogen keepusing(community_board zoom) assert(using match) keep(match)
keep if community_board == 8 | community_board == 10 | community_board == 11
collapse (mean) asian_percent black_percent hispanic_percent white_percent [aw=population], by(community_board)
rename (asian_percent black_percent hispanic_percent white_percent) (percent1 percent2 percent3 percent4)
reshape long percent, i(community_board) j(race)
save `t_pop', replace

foreach spec in est nospat nosoc neither {
	
	display "starting `spec' specification"

	use "`pathstub'`spec'.dta", clear
	merge m:1 geoid11_dest using "`tf_zoomcuts_dest'", nogen keepusing(community_board zoom) assert(using match) keep(match)

	keep if community_board == 8 | community_board == 10 | community_board == 11
	keep geoid11_dest race pr_dest_race community_board geoid11_dest zoom
	rename geoid11_dest geoid11

	encode(race), gen(race_num)
	drop race
	ren race_num race
	drop if race==.

	reshape wide pr_dest_race, i(geoid11) j(race)
	merge 1:1 geoid11 using "../input/tracts.dta", assert(using match) keep(match) keepusing(population) nogen
	collapse (mean) pr_dest_race** [aw=population], by(community_board)  //JD says: I don't understand this line of code. Why do you average pr_dest_race weighting by the population of the destination tract?
	reshape long pr_dest_race, i(community_board) j(race)
	ren pr_dest_race pr_dest_race_`spec'
	save `t_`spec'', replace
}

use `t_pop', clear
foreach spec in est nospat nosoc neither {
	merge 1:1 community_board race using `t_`spec'',  nogen assert(match)
}

keep if community_board == 8 | community_board == 10 | community_board == 11

foreach var of varlist percent pr_dest_race_est pr_dest_race_nospat pr_dest_race_nosoc pr_dest_race_neither { 
	generate `var'_str = string(`var',"%8.3f")
	replace `var'_str = "" if `var'_str=="."
	drop `var'
}

gen race_str=""
replace race_str="Asian" if race==1
replace race_str="black" if race==2
replace race_str="Hispanic" if race==3
replace race_str="white" if race==4

gen order = community_board
set obs 15
recode order .=7.5 in 13
recode order .=9.5 in 14
recode order .=10.5 in 15
replace race_str="\\ & \multicolumn{5}{c}{\textit{Community District 8: Upper East Side}} \\ \midrule % " if order == 7.5
replace race_str="\hline \\  & \multicolumn{5}{c}{\textit{Community District 10: Central Harlem}} \\ \midrule % " if order == 9.5
replace race_str="\hline \\  & \multicolumn{5}{c}{\textit{Community District 11: East Harlem}} \\ \midrule % " if order == 10.5
sort order race_str

listtex race_str percent_str pr_dest_race_est_str pr_dest_race_nospat_str pr_dest_race_nosoc_str pr_dest_race_neither_str using "../output/sumstats_dotmap_UES_racespcfc.tex", replace ///
rstyle(tabular) head("\begin{tabular}{lccccc} \toprule" "  &  & \multicolumn{4}{c}{Consumption share} \\  \cline{3-6} & Residential share & Estimated & No Spatial & No Social & Neither  \\ \midrule") foot("\bottomrule \end{tabular}")

end

/***********************
** PROGRAM CALLS
***********************/

set seed 14

dot_map_residence, dot_size(20) savegraphas(dotmap_res)

dot_map using "../output/pr_dest_race_tract_level_sixom_mainspec.csv", specification(standard)  savegraphas(dotmap_est)     dot_size(20) 
dot_map using "../output/pr_dest_race_tract_level_sixom_mainspec.csv", specification(nospatial) savegraphas(dotmap_nospat)  dot_size(20)
dot_map using "../output/pr_dest_race_tract_level_sixom_mainspec.csv", specification(nosocial)  savegraphas(dotmap_nosoc)   dot_size(20) 
dot_map using "../output/pr_dest_race_tract_level_sixom_mainspec.csv", specification(neither)   savegraphas(dotmap_neither) dot_size(20)  

sumstats_dotmap_UES, pathstub("../output/tf_dotmap_") // This program assumes that all dot maps have been built
sumstats_brooklyn_neighbors, pathstub("../output/tf_dotmap_") // This programs assumes dot_maps created. 

shell rm ../output/tf_*.dta

exit, clear
