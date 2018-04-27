//Dingel, April 2018

foreach package in spmap psmatch2 {
	capture which `package'
	if _rc==111 ssc install `package'
}

qui do "gentrify_DTAs_programs.do"

local counterfactual = "Harlem"
gentrification_mapmaker, counterfactual(`counterfactual') saveas("../output/gentrify_`counterfactual'.pdf") saveas_manhattan("../output/gentrify_`counterfactual'_manhattan.pdf")
gentrification_tracts_DTA, counterfactual(`counterfactual') saveas("../output/tracts_`counterfactual'.dta")
gentrification_venues_DTA, counterfactual(`counterfactual') saveas("../output/venues_`counterfactual'.dta")
gentrification_tractpairs_DTA using "../output/tracts_`counterfactual'.dta", saveas("../output/tractpairs_`counterfactual'.dta")

local counterfactual = "Bedstuy"
gentrification_mapmaker, counterfactual(`counterfactual') saveas("../output/gentrify_`counterfactual'.pdf") saveas_manhattan("../output/gentrify_`counterfactual'_manhattan.pdf")
gentrification_tracts_DTA, counterfactual(`counterfactual') saveas("../output/tracts_`counterfactual'.dta")
gentrification_venues_DTA, counterfactual(`counterfactual') saveas("../output/venues_`counterfactual'.dta")
gentrification_tractpairs_DTA using "../output/tracts_`counterfactual'.dta", saveas("../output/tractpairs_`counterfactual'.dta")

exit, clear
