#!/bin/bash

# Ask user to indicate the partition
read -p "Please provide the name of the partition to which jobs will be submitted: " user_partition

for i in bootstrap_estarrays counterfactuals_DTAs dissimilarity_bootstrap_plot dissimilarity_computations dissimilarity_computations_counterfactuals dissimilarity_stderr dissimilarity_TeXtables dissimilarity_TeXtables_counterfactuals dot_maps estarrays_DTAs estarrays_nestedlogit_DTAs estarrays_venueFE_DTAs estarrays_venueFE_Taddy_DTAs estimate_MNL_specs estimate_MNL_specs_bootstrap estimate_nestedlogit estimate_venueFE estimate_venueFE_Taddy gentrify_DTAs initialdata install_packages isoindex_bootstrap isoindex_specs isoindex_specs_bsavg isoindex_venueFE observables_vs_FE predictvisits predictvisits_array predictvisits_counterfactuals predictvisits_counterfactuals_arrays predictvisits_estsmp predictvisits_estsmp_arrays predictvisits_estsmp_betabsavg predictvisits_estsmp_bootstrap predictvisits_estsmp_FE predictvisits_estsmp_nested predictvisits_gentrification schelling_checks simulate_estimator simulation_permanent_shocks summarystats venues_YelpvsDOHMH
do 
	for file in ${i}/code/*.sbatch
	do
		sed -i.bak "s/^#SBATCH --partition=.*/#SBATCH --partition=${user_partition}/g" ${file} && rm ${file}.bak
	done 
done


