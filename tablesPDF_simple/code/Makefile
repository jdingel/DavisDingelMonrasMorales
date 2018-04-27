####################################################
# INPUT
####################################################

inputs=\
	../input/estimator_simulations.tex \
	../input/estimates_persistent_preferences_MLE.tex  \
	../input/figure_A1.pdf \
	../input/gentrify_Harlem_manhattan_gray_edited2.png \
	../input/figure_A2.pdf \
	../input/tab_robustnesschecks2_asian_sixom.tex \
	../input/tab_robustnesschecks1_asian_sixom.tex \
	../input/racegapvsnull.pdf \
	../input/schelling_isoindexelements.pdf \
	../input/schelling_ttest_appendix_sentence.tex \
	../input/schelling_ttest_sentence.tex \
	../input/rdfm_eucl_density.pdf \
	../input/rdfm_timework_density.pdf \
	../input/rdfm_timehome_density.pdf \
	../input/sumstats_table1.tex \
	../input/table_A01.tex \
	../input/table_A02_lower.tex \
	../input/table_A02_upper.tex \
	../input/tab_raceblind.tex \
	../input/tab_robustnesschecks2_whithisp_sixom.tex \
	../input/tab_robustnesschecks1_whithisp_sixom.tex \
	../input/tab_robustnesschecks2_black_sixom.tex \
	../input/tab_robustnesschecks1_black_sixom.tex \
	../input/omintercepts.tex \
	../input/table_homeonlysample_homeonly.tex \
	../input/table_spatialfrictions_robustness.tex \
	../input/table_spatialfrictionsonly.tex \
	../input/tab_nosocial_and_mainspec.tex \
	../input/tab_robustnesschecks_black_sixom.tex \
	../input/tab_robustnesschecks_whithisp_sixom.tex \
	../input/tab_robustnesschecks_asian_mintime.tex \
	../input/tab_robustnesschecks_black_mintime.tex \
	../input/tab_robustnesschecks_whithisp_mintime.tex \
	../input/tab_robustnesschecks1_asian_mintime.tex \
	../input/tab_robustnesschecks2_asian_mintime.tex \
	../input/tab_robustnesschecks1_black_mintime.tex \
	../input/tab_robustnesschecks2_black_mintime.tex \
	../input/tab_robustnesschecks1_whithisp_mintime.tex \
	../input/tab_robustnesschecks2_whithisp_mintime.tex \
	../input/isoindices_sixom_mainspec_ci.tex \
	../input/dissimilarity_venues_mainspec.tex \
	../input/dissimilarity_tracts_mainspec.tex \
	../input/dissimilarity_cftl_venue_level.tex \
	../input/sumstats_dotmap_UES_racespcfc.tex \
	../input/sums_stats_neighbors_brooklyn.tex \
	../input/dotmap_res_zoom3and4_edited.pdf \
	../input/dotmap_nospat_zoom3and4_edited.pdf \
	../input/dotmap_nosoc_zoom3and4_edited.pdf \
	../input/dotmap_neither_zoom3and4_edited.pdf \
	../input/dotmap_est_zoom3and4_edited.pdf \
	../input/dotmap_nospat_zoom1_edited.pdf \
	../input/dotmap_nosoc_zoom1_edited.pdf \
	../input/dotmap_neither_zoom1_edited.pdf \
	../input/dotmap_est_zoom1_edited.pdf \
	../input/dotmap_res_zoom1_edited.pdf \
	../input/gentrify_Harlem.pdf \
	../input/gentrify_Harlem_manhattan.pdf \
	../input/gentrify_Bedstuy.pdf \
	../input/gentrify_Bedstuy_manhattan.pdf \
	../input/gentrify_covars_Harlem.tex \
	../input/gentrify_covars_Bedstuy.tex \
	../input/table_gentrification_Harlem.tex \
	../input/table_gentrification_Bedstuy.tex \


####################################################
# OUTPUT
####################################################

folders_and_symlinks=create_folders_and_symlinks.txt

buildPDF=../output/tabsfigs.pdf

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(buildPDF)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	echo "">create_folders_and_symlinks.txt

$(buildPDF): $(inputs) maketexfiles.sh makePDF.sh
	-bash maketexfiles.sh
	-bash makePDF.sh
