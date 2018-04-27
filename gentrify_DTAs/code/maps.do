//Jonathan Dingel, February 2018
//Rewrite of Joan Monras's code

foreach package in spmap  {
	capture which `package'
	if _rc==111 ssc install `package'
}

use "../input/geoid11_coords.dta", clear
collapse (firstnm) _ID, by(geoid11)
merge 1:1 geoid11 using "../input/tract_2010_characteristics_est.dta", keepusing(area_dummy_assignment) nogen

gen group=0
replace group=1 if area_dummy_assignment==26
replace group=2 if area_dummy_assignment==24
replace group=3 if geoid11=="36061022400"

gen manhattan=1 if strpos(geoid11, "36061")
spmap group if manhattan==1 using "../input/geoid11_coords.dta", id(_ID) clmethod(unique) fcolor(white gs11 gs6 gs1) legen(off)

graph export "../output/gentrify_Harlem_manhattan_gray.pdf", replace

exit, clear
