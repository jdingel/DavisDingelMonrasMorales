
/***********************
** BOOTSTRAP ARRAY MAKER
***********************/

cap program drop estarray_bootstrapdraws
program define estarray_bootstrapdraws

syntax using/, outputfolder(string) instances(integer) [start(integer 1)]

forvalues i = `start'/`instances' {
	foreach race in asian black whithisp {

		tempfile tf0 tf1 tf2

		//Load simulated trips
		use if instance==`i' & `race'==1 using "`using'", clear
		keep instance userid_num tripnumber venue_num
		order instance userid_num tripnumber venue_num
		save `tf0', replace

		//Generate choice sets for this simulation draw
		choiceset using `tf0', choicesetsize(20) saveas(`tf1') seed(`i')
	
		//Generate estimation arrays for this simulation draw
		estarray_racespecific using "`tf1'", saveas(`tf2') dropvars(reviews_log chain)
		use `tf2', clear
		saveold "`outputfolder'/`race'_`i'.dta", replace
	}
}

end 
