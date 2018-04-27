#!/bin/bash

##INPUT
mkdir -p ../input/

##OUTPUT
mkdir -p ../output/tabsfigs

##Create symbolic links

ln -s ../../estimate_venueFE_Taddy/output/tables/table_Taddy.tex ../input/table_Taddy.tex

ln -s ../../isoindex_bootstrap/output/isoindices_p5p95distros.pdf ../input/isoindices_p5p95distros.pdf
ln -s ../../simulate_estimator/output/estimator_simulations.tex ../input/estimator_simulations.tex
ln -s ../../simulation_permanent_shocks/output/estimates_persistent_preferences_MLE.tex ../input/estimates_persistent_preferences_MLE.tex 
ln -s ../../observables_vs_FE/output/tables/sixom/table_observables_vs_FE.tex ../input/table_observables_vs_FE.tex
ln -s ../../isoindex_specs_bsavg/output/isoindices_bsavg_ci.tex ../input/isoindices_bsavg_ci.tex
ln -s ../../figures_notinpackage/output/figure_A1.pdf ../input/figure_A1.pdf
ln -s ../../venues_YelpvsDOHMH/output/figure_A2.pdf ../input/figure_A2.pdf
ln -s ../../predictvisits_gentrification/output/tables/table_gentrification_Harlem.tex ../input/table_gentrification_Harlem.tex
ln -s ../../predictvisits_gentrification/output/tables/table_gentrification_Bedstuy.tex ../input/table_gentrification_Bedstuy.tex
ln -s ../../isoindex_specs/output/isoindices_sixom_robustness_ci.tex ../input/isoindices_sixom_robustness_ci.tex
ln -s ../../gentrify_DTAs/output/gentrify_Harlem.pdf ../input/gentrify_Harlem.pdf
ln -s ../../gentrify_DTAs/output/gentrify_Harlem_manhattan.pdf ../input/gentrify_Harlem_manhattan.pdf
ln -s ../../gentrify_DTAs/output/gentrify_Bedstuy.pdf ../input/gentrify_Bedstuy.pdf
ln -s ../../gentrify_DTAs/output/gentrify_Bedstuy_manhattan.pdf ../input/gentrify_Bedstuy_manhattan.pdf
ln -s ../../gentrify_DTAs/output/gentrify_covars_Harlem.tex ../input/gentrify_covars_Harlem.tex
ln -s ../../gentrify_DTAs/output/gentrify_covars_Bedstuy.tex ../input/gentrify_covars_Bedstuy.tex
ln -s ../../estimate_nestedlogit/output/tables/sixom/tab_nlogit.tex ../input/table_nlogit_sixom.tex
ln -s ../../estimate_nestedlogit/output/tables/mintime/tab_nlogit.tex ../input/table_nlogit_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/norg/table_spatialfrictionsonly.tex  ../input/table_spatialfrictionsonly.tex
ln -s ../../figures_notinpackage/output/bootstrap_param_legend.pdf ../input/bootstrap_param_legend.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mintime/density_spatial_frictions_whithisp_mintime_1by3.pdf ../input/bootstrap_param_mintime_spatial.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mintime/density_social_frictions_whithisp_mintime_2by3.pdf ../input/bootstrap_param_mintime_social_whithisp.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mintime/density_social_frictions_black_mintime_2by3.pdf ../input/bootstrap_param_mintime_social_black.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mintime/density_social_frictions_asian_mintime_2by3.pdf ../input/bootstrap_param_mintime_social_asian.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_time_covariates_whithisp_mainspec_zoom_2by3.pdf ../input/bootstrap_param_mainspec_spatial_whithisp.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_time_covariates_black_mainspec_zoom_2by3.pdf ../input/bootstrap_param_mainspec_spatial_black.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_time_covariates_asian_mainspec_zoom_2by3.pdf ../input/bootstrap_param_mainspec_spatial_asian.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_social_frictions_whithisp_mainspec_2by3.pdf ../input/bootstrap_param_mainspec_social_whithisp.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_social_frictions_black_mainspec_2by3.pdf ../input/bootstrap_param_mainspec_social_black.pdf
ln -s ../../estimate_MNL_specs_bootstrap/output/figures/mainspec/density_social_frictions_asian_mainspec_2by3.pdf ../input/bootstrap_param_mainspec_social_asian.pdf
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks2_asian_sixom.tex ../input/tab_robustnesschecks2_asian_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks1_asian_sixom.tex ../input/tab_robustnesschecks1_asian_sixom.tex

ln -s ../../schelling_checks/output/racegapvsnull.pdf ../input/racegapvsnull.pdf
ln -s ../../schelling_checks/output/schelling_isoindexelements.pdf ../input/schelling_isoindexelements.pdf
ln -s ../../schelling_checks/output/schelling_*_sentence.tex  ../input/

ln -s ../../isoindex_specs/output/isoindices_robustness_ci.tex ../input/isoindices_robustness_ci.tex
ln -s ../../isoindex_specs/output/isoindices_sixom_mainspec_ci.tex ../input/isoindices_sixom_mainspec_ci.tex
ln -s ../../estimate_venueFE/output/tables/sixom/tab_venueFE_sixom.tex ../input/tab_venueFE_sixom.tex

ln -s ../../summarystats/output/rdfm_eucl_density.pdf ../input/rdfm_eucl_density.pdf
ln -s ../../summarystats/output/rdfm_timework_density.pdf ../input/rdfm_timework_density.pdf
ln -s ../../summarystats/output/rdfm_timehome_density.pdf ../input/rdfm_timehome_density.pdf
ln -s ../../summarystats/output/sumstats_table1.tex ../input/sumstats_table1.tex
ln -s ../../summarystats/output/table_A01.tex ../input/table_A01.tex
ln -s ../../summarystats/output/table_A02_lower.tex ../input/table_A02_lower.tex
ln -s ../../summarystats/output/table_A02_upper.tex ../input/table_A02_upper.tex

ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_raceblind.tex ../input/tab_raceblind.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks2_whithisp_sixom.tex ../input/tab_robustnesschecks2_whithisp_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks1_whithisp_sixom.tex ../input/tab_robustnesschecks1_whithisp_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks2_black_sixom.tex ../input/tab_robustnesschecks2_black_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks1_black_sixom.tex ../input/tab_robustnesschecks1_black_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_omintercepts.tex ../input/omintercepts.tex
ln -s ../../estimate_MNL_specs/output/tables/norg/table_homeonlysample_homeonly.tex ../input/table_homeonlysample_homeonly.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/table_spatialfrictions_robustness.tex ../input/table_spatialfrictions_robustness.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_nosocial_and_mainspec.tex ../input/tab_nosocial_and_mainspec.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks_black_sixom.tex ../input/tab_robustnesschecks_black_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/sixom/tab_robustnesschecks_whithisp_sixom.tex ../input/tab_robustnesschecks_whithisp_sixom.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks_asian_mintime.tex ../input/tab_robustnesschecks_asian_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks_black_mintime.tex ../input/tab_robustnesschecks_black_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks_whithisp_mintime.tex ../input/tab_robustnesschecks_whithisp_mintime.tex

ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks1_asian_mintime.tex ../input/tab_robustnesschecks1_asian_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks2_asian_mintime.tex ../input/tab_robustnesschecks2_asian_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks1_black_mintime.tex ../input/tab_robustnesschecks1_black_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks2_black_mintime.tex ../input/tab_robustnesschecks2_black_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks1_whithisp_mintime.tex ../input/tab_robustnesschecks1_whithisp_mintime.tex
ln -s ../../estimate_MNL_specs/output/tables/mintime/tab_robustnesschecks2_whithisp_mintime.tex ../input/tab_robustnesschecks2_whithisp_mintime.tex

ln -s ../../dot_maps/output/sumstats_dotmap_UES_racespcfc.tex ../input/sumstats_dotmap_UES_racespcfc.tex
ln -s ../../dot_maps/output/sums_stats_neighbors_brooklyn.tex ../input/sums_stats_neighbors_brooklyn.tex
ln -s ../../dot_maps/output/dotmap_res_zoom3and4.pdf ../input/dotmap_res_zoom3and4_edited.pdf
ln -s ../../dot_maps/output/dotmap_nospat_zoom3and4.pdf ../input/dotmap_nospat_zoom3and4_edited.pdf
ln -s ../../dot_maps/output/dotmap_nosoc_zoom3and4.pdf ../input/dotmap_nosoc_zoom3and4_edited.pdf
ln -s ../../dot_maps/output/dotmap_neither_zoom3and4.pdf ../input/dotmap_neither_zoom3and4_edited.pdf
ln -s ../../dot_maps/output/dotmap_est_zoom3and4.pdf ../input/dotmap_est_zoom3and4_edited.pdf
ln -s ../../dot_maps/output/dotmap_nospat_zoom1.pdf ../input/dotmap_nospat_zoom1_edited.pdf
ln -s ../../dot_maps/output/dotmap_nosoc_zoom1.pdf ../input/dotmap_nosoc_zoom1_edited.pdf
ln -s ../../dot_maps/output/dotmap_neither_zoom1.pdf ../input/dotmap_neither_zoom1_edited.pdf
ln -s ../../dot_maps/output/dotmap_est_zoom1.pdf ../input/dotmap_est_zoom1_edited.pdf
ln -s ../../dot_maps/output/dotmap_res_zoom1.pdf ../input/dotmap_res_zoom1_edited.pdf

ln -s ../../dissimilarity_stderr/output/dissimilarity_venues_mainspec.tex ../input/dissimilarity_venues_mainspec.tex
ln -s ../../dissimilarity_stderr/output/dissimilarity_tracts_mainspec.tex ../input/dissimilarity_tracts_mainspec.tex
ln -s ../../dissimilarity_TeXtables/output/sixom/dissimilarity_mainspec_venue_level_homeonly.tex ../input/dissimilarity_mainspec_venue_level_homeonly.tex
ln -s ../../dissimilarity_TeXtables/output/dissimilarity_revchain_venue_comp_across_race.tex ../input/dissimilarity_revchain_venue_comp_across_race.tex
ln -s ../../dissimilarity_TeXtables/output/sixom/dissimilarity_robustnesschecks_venue_level_comp_within_race.tex ../input/dissimilarity_robustnesschecks_venue_level_comp_within_race.tex
ln -s ../../dissimilarity_TeXtables/output/sixom/dissimilarity_robustnesschecks_venue_level_comp_across_race.tex ../input/dissimilarity_robustnesschecks_venue_level_comp_across_race.tex
ln -s ../../dissimilarity_TeXtables_counterfactuals/output/sixom/dissimilarity_cftl_venue_level.tex ../input/dissimilarity_cftl_venue_level.tex

ln -s ../../dissimilarity_bootstrap_plot/output/dissimilarity_bootstrap_plot.pdf ../input/
ln -s ../../dissimilarity_bootstrap_plot/output/dissimilarity_bootstrap_table.tex ../input/
