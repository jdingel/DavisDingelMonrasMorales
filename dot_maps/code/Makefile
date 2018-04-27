####################
# Global functions
####################

estarray_func = gen_estimationarray_functions.jl

estimation_func=\
	estimation_functions.jl \
	fit_mnl_hessianfree.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \

####################
# INPUT
####################

stata_dta= \
	../input/dotmap_labels_bklyn.dta \
	../input/dotmap_labels_harlem.dta \
	../input/dotmap_zoomcuts.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/geoid11_coords.dta \
	../input/tracts.dta 

predictedvisits_input=\
	../input/predictedvisits/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec.jld \
	../input/predictedvisits/predictedvisits_collapsed_over_workplace_black_sixom_mainspec.jld \
	../input/predictedvisits/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec.jld 

#####################
# OUTPUT
#####################

folders_and_symlinks=create_folders_and_symlinks.txt

###################
# Estarrays
###################

predictedvisits_output=../output/pr_dest_race_tract_level_sixom_mainspec.csv

stata_output=\
	../output/sums_stats_neighbors_brooklyn.tex \
	../output/sumstats_dotmap_UES_racespcfc.tex \
	../output/dotmap_neither_zoom3and4.pdf \
	../output/dotmap_neither_zoom1.pdf \
	../output/dotmap_nosoc_zoom3and4.pdf \
	../output/dotmap_nosoc_zoom1.pdf \
	../output/dotmap_nospat_zoom3and4.pdf \
	../output/dotmap_nospat_zoom1.pdf \
	../output/dotmap_est_zoom3and4.pdf \
	../output/dotmap_est_zoom1.pdf \
	../output/dotmap_res_zoom3and4.pdf \
	../output/dotmap_res_zoom1.pdf

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits_output) $(stata_output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(predictedvisits_output): $(predictedvisits_input) $(stata_dta) dissimilarity_functions.jl general_functions.jl dot_maps.jl dot_maps_functions.jl dot_maps.sbatch
	sbatch -W dot_maps.sbatch

$(stata_output): $(predictedvisits_output) $(stata_dta) dot_maps.do dot_maps2.sbatch
	sbatch -W dot_maps2.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh

	

