#!/bin/bash

read -p "Please indicate the number of cores available locally: " NUM_CORES

sed -i.bak "s/^NUM_CORES=/NUM_CORES=$NUM_CORES/g" local_configuration_functions.sh && rm local_configuration_functions.sh.bak

BASEDIR=$PWD

for i in bootstrap_estarrays counterfactuals_DTAs dissimilarity_bootstrap_plot dissimilarity_computations dissimilarity_computations_counterfactuals dissimilarity_stderr dissimilarity_TeXtables dissimilarity_TeXtables_counterfactuals dot_maps estarrays_DTAs estarrays_nestedlogit_DTAs estarrays_venueFE_DTAs estarrays_venueFE_Taddy_DTAs estimate_MNL_specs estimate_MNL_specs_bootstrap estimate_nestedlogit estimate_venueFE estimate_venueFE_Taddy gentrify_DTAs initialdata install_packages isoindex_bootstrap isoindex_specs isoindex_specs_bsavg isoindex_venueFE observables_vs_FE predictvisits predictvisits_array predictvisits_counterfactuals predictvisits_counterfactuals_arrays predictvisits_estsmp predictvisits_estsmp_arrays predictvisits_estsmp_betabsavg predictvisits_estsmp_bootstrap predictvisits_estsmp_FE predictvisits_estsmp_nested predictvisits_gentrification schelling_checks simulate_estimator simulation_permanent_shocks summarystats venues_YelpvsDOHMH
do
	ln -s ../../local_configuration_functions.sh ./${i}/code/
	cd ./${i}/code/
	bash local_configuration_functions.sh $NUM_CORES
	cd $BASEDIR
done

cd ./commonfunctions/code
sed -i.bak 's/all: $(distribute_functions) $(user_partition)/all: $(distribute_functions)/g' Makefile && rm Makefile.bak
cd $BASEDIR

for i in dissimilarity_computations_bootstrap predictvisits_bootstrap isoindex_bootstrap
do
	cd ./${i}/code/
	sed -i.bak 's/\.sbatch/.sh/g' gen_array_jobs.sh && rm gen_array_jobs.sh.bak
	sed -i.bak 's/$(slurm_files): gen_array_jobs.sh/$(slurm_files): gen_array_jobs.sh local_configuration_functions.sh/g' Makefile && rm Makefile.bak

	sed -i.bak '/sh gen_array_jobs.sh/  a\
	<TAB>-sh local_configuration_functions.sh \
	' Makefile && rm Makefile.bak

	awk '{gsub(/<TAB>/,"\t");print}' Makefile > Makefile2
	mv Makefile2 Makefile

	cd $BASEDIR
done

for i in tablesPDF tablesPDF_simple
do 
	cd ./${i}/code/
	sed -i.bak 's/^module./#&/g' makePDF.sh && rm makePDF.sh.bak
	cd $BASEDIR
done 

#Local version only supports make quick_version
sed -i.bak '212,258d' Makefile && rm Makefile.bak

