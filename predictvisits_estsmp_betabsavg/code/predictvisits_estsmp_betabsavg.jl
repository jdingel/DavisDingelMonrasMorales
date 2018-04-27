## Author: Jonathan Dingel
## Date: April 2018
## Purpose: Produce predicted visits for estimation-sample users with six origin mode or minimum-time specification
## Julia version: 0.6.2

#Packages
using DataFrames, JLD, FileIO, StatFiles, StatsFuns, CSV

#Imported functions
include("general_functions.jl")
include("compute_predvisits_racespecific_functions.jl")

##Program definitions
function compute_predvisits_estsample(norg::Int64,estimates_filepath,predictarray_filepath,output_filepath;mintime::Int64=0)

#Load estimates
data_estimates = CSV.read(string(estimates_filepath),allowmissing=:none,weakrefstrings=false)

#Specification
spec_covariates= map(i->Symbol(i),convert(Array{String},data_estimates[:names]))

#Load array
df = read_stata(string(predictarray_filepath))

#convert string to numeric format
df = convert_string_numeric(df,[:geoid11_home,:geoid11_work,:geoid11_dest])

#compute predicted visits
df_predvisits = compute_prob_visit_venue(norg,df,data_estimates,spec_covariates;mintime=mintime)
CSV.write(string(output_filepath),df_predvisits)

end

##Program calls
compute_predvisits_estsample(6,"../input/estimates_black_mainspec_bootstrap_avg.csv","../input/estsample_predictarray_black_sixom.dta","../output/predictedvisits_black_bsavg.csv")
compute_predvisits_estsample(6,"../input/estimates_asian_mainspec_bootstrap_avg.csv","../input/estsample_predictarray_asian_sixom.dta","../output/predictedvisits_asian_bsavg.csv")
compute_predvisits_estsample(6,"../input/estimates_whithisp_mainspec_bootstrap_avg.csv","../input/estsample_predictarray_whithisp_sixom.dta","../output/predictedvisits_whithisp_bsavg.csv")
