#!/bin/bash

##Distribute common functions
cd ./

##1) Estimation
for folder in estimate_MNL_specs estimate_MNL_specs_bootstrap estimate_venueFE estimate_nestedlogit
do
	for file in estimation_functions.jl fit_mnl_hessianfree.jl fit_mnl_newton.jl fit_nlogit_onelambda_multiperiod.jl gen_estimationarray_functions.jl general_functions.jl tables_formatting.jl
	do
		ln -s ../../commonfunctions/code/${file} ./../../${folder}/code/
	done
done

##2) Computation of predicted visits
for folder in predictvisits predictvisits_bootstrap predictvisits_estsmp_nested predictvisits_estsmp_bootstrap predictvisits_estsmp_betabsavg predictvisits_counterfactuals predictvisits_estsmp observables_vs_FE
do
	for file in fit_mnl_newton.jl fit_nlogit_onelambda_multiperiod.jl  general_functions.jl  compute_predvisits_racespecific_functions.jl
	do
		ln -s ../../commonfunctions/code/${file} ./../../${folder}/code/
	done
done

##3) Generate predicted visits array
for folder in predictvisits_array predictvisits_counterfactuals_arrays
do
	for file in general_functions.jl gen_array_predvisits_racespecific_functions.jl
	do
		ln -s ../../commonfunctions/code/${file} ./../../${folder}/code/
	done
done

##4) Compute dissimilarity indices
for folder in dissimilarity_computations dissimilarity_computations_counterfactuals dissimilarity_computations_bootstrap
do
	for file in dissimilarity_functions.jl  general_functions.jl
	do
	ln -s ../../commonfunctions/code/${file} ./../../${folder}/code/
	done
done

##5) Gentrification
for file in fit_mnl_newton.jl fit_nlogit_onelambda_multiperiod.jl  general_functions.jl  compute_predvisits_racespecific_functions.jl gen_array_predvisits_racespecific_functions.jl
do
ln -s ../../commonfunctions/code/${file} ./../../predictvisits_gentrification/code/
done

##6) dot maps
for file in general_functions.jl dissimilarity_functions.jl
do
ln -s ../../commonfunctions/code/${file} ./../../dot_maps/code/
done

##7) Taddy
for file in general_functions.jl gen_estimationarray_functions.jl tables_formatting.jl
do
ln -s ../../commonfunctions/code/${file} ./../../estimate_venueFE_Taddy/code/
done

##8) DGP permanent shocks
ln -s ../../commonfunctions/code/fit_mnl_newton.jl ./../../simulation_permanent_shocks/code/

##9) function that allows the user to edit sbatch files directly
for i in bootstrap_estarrays counterfactuals_DTAs dissimilarity_bootstrap_plot dissimilarity_computations dissimilarity_computations_bootstrap dissimilarity_computations_counterfactuals dissimilarity_stderr dissimilarity_TeXtables dissimilarity_TeXtables_counterfactuals dot_maps estarrays_DTAs estarrays_nestedlogit_DTAs estarrays_venueFE_DTAs estarrays_venueFE_Taddy_DTAs estimate_MNL_specs estimate_MNL_specs_bootstrap estimate_nestedlogit estimate_venueFE estimate_venueFE_Taddy figures_notinpackage gentrify_DTAs initialdata install_packages isoindex_bootstrap isoindex_specs isoindex_specs_bsavg observables_vs_FE predictvisits predictvisits_array predictvisits_bootstrap predictvisits_counterfactuals predictvisits_counterfactuals_arrays predictvisits_estsmp predictvisits_estsmp_arrays predictvisits_estsmp_betabsavg predictvisits_estsmp_bootstrap predictvisits_estsmp_nested predictvisits_gentrification schelling_checks simulate_estimator simulation_permanent_shocks summarystats venues_YelpvsDOHMH
do
ln -s ../../commonfunctions/code/edit_sbatch.sh ./../../${i}/code
done
