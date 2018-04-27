global path_input  "../input"
global path_output "../output"

use "$path_input/trips_est.dta", clear

sort userid_num date
bysort userid_num : gen tripnumber = _n
drop date 
saveold "$path_output/tripdata.dta", replace

exit, clear
