###################
# PROGRAMS
###################

PROGS = dissimilarity_functions.jl \
	general_functions.jl

####################
# INPUT
####################

stata_dta = ../input/tract_2010_characteristics_est.dta

predictedvisits_mintime=\
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_mainspec.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_lateadopt.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_half.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_fifth.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_droploca.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_locainfo1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_locainfo2.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_carshare.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_revchain.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_disaggcuis.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_50.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_100.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_mainspec.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_lateadopt.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_half.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_fifth.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_droploca.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_locainfo1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_locainfo2.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_carshare.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_revchain.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_disaggcuis.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_50.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_100.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_mainspec.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_lateadopt.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_half.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_fifth.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_droploca.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_locainfo1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_locainfo2.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_carshare.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_revchain.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_disaggcuis.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_50.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_100.jld 

predictedvisits_sixom_mainspec=\
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_mainspec.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec.jld \

predictedvisits_sixom_robustnesschecks=\
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_lateadopt.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_half.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_fifth.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_droploca.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_locainfo1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_locainfo2.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_carshare.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_revchain.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_disaggcuis.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_50.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_100.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_lateadopt.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_half.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_fifth.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_droploca.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_locainfo1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_locainfo2.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_carshare.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_revchain.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_disaggcuis.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_50.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_100.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_lateadopt.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_half.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_fifth.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_droploca.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_locainfo1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_locainfo2.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_carshare.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_revchain.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_disaggcuis.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_50.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_100.jld \

predictedvisits_omintercepts =\
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_omintercepts_bias.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_omintercepts_nobias.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_omintercepts_bias.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_omintercepts_nobias.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_omintercepts_bias.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_omintercepts_nobias.jld

predictedvisits_mintime_nlogit=\
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_nlogit_nested1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_nlogit_nested2.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_nlogit_nested1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_nlogit_nested2.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_nlogit_nested1.jld \
	../input/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_nlogit_nested2.jld 

predictedvisits_sixom_nlogit=\
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_nlogit_nested1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_nlogit_nested2.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_nlogit_nested1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_nlogit_nested2.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_nlogit_nested1.jld \
	../input/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_nlogit_nested2.jld

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

folders_and_symlinks_quick_version=create_folders_and_symlinks_quick_version.txt

####################
# Dissimilarities
####################

dissim_residential =\
	../output/dissimilarity_index_pairwise_residential.csv \
	../output/dissimilarity_index_residential.csv 

dissim_omintercepts = \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_omintercepts_nobias.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_omintercepts_nobias.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_omintercepts_nobias.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_omintercepts_nobias.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_omintercepts_bias.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_omintercepts_bias.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_omintercepts_bias.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_omintercepts_bias.csv

dissim_sixom_mainspec=\
	../output/sixom/dissimilarity_index_venue_level_sixom_mainspec.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_mainspec.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_mainspec.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_mainspec.csv \

dissim_sixom_robustnesschecks=\
	../output/sixom/dissimilarity_index_venue_level_sixom_lateadopt.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_half.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_fifth.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_droploca.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_locainfo1.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_locainfo2.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_carshare.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_revchain.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_disaggcuis.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_50.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_100.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_lateadopt.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_half.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_fifth.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_droploca.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_locainfo1.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_locainfo2.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_carshare.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_revchain.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_disaggcuis.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_50.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_100.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_lateadopt.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_half.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_fifth.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_droploca.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_locainfo1.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_locainfo2.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_carshare.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_revchain.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_disaggcuis.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_50.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_100.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_lateadopt.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_half.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_fifth.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_droploca.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_locainfo1.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_locainfo2.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_carshare.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_revchain.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_disaggcuis.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_50.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_100.csv \

dissim_mintime = \
	../output/mintime/dissimilarity_index_venue_level_mintime_mainspec.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_lateadopt.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_half.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_fifth.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_droploca.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_locainfo1.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_locainfo2.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_carshare.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_revchain.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_disaggcuis.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_50.csv \
	../output/mintime/dissimilarity_index_venue_level_mintime_100.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_mainspec.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_lateadopt.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_half.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_fifth.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_droploca.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_locainfo1.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_locainfo2.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_carshare.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_revchain.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_disaggcuis.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_50.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_mintime_100.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_mainspec.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_lateadopt.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_half.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_fifth.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_droploca.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_locainfo1.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_locainfo2.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_carshare.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_revchain.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_disaggcuis.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_50.csv \
	../output/mintime/dissimilarity_index_tract_level_mintime_100.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_mainspec.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_lateadopt.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_half.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_fifth.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_droploca.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_locainfo1.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_locainfo2.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_carshare.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_revchain.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_disaggcuis.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_50.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_mintime_100.csv 

dissim_sixom_nlogit = \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_nlogit_nested2.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_nlogit_nested2.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_nlogit_nested2.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_nlogit_nested2.csv \
	../output/sixom/dissimilarity_index_pairwise_tract_level_sixom_nlogit_nested1.csv \
	../output/sixom/dissimilarity_index_tract_level_sixom_nlogit_nested1.csv \
	../output/sixom/dissimilarity_index_pairwise_venue_level_sixom_nlogit_nested1.csv \
	../output/sixom/dissimilarity_index_venue_level_sixom_nlogit_nested1.csv 

dissim_mintime_nlogit=\
	../output/mintime/dissimilarity_index_pairwise_tract_level_sixom_nlogit_nested2.csv \
	../output/mintime/dissimilarity_index_tract_level_sixom_nlogit_nested2.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_sixom_nlogit_nested2.csv \
	../output/mintime/dissimilarity_index_venue_level_sixom_nlogit_nested2.csv \
	../output/mintime/dissimilarity_index_pairwise_tract_level_sixom_nlogit_nested1.csv \
	../output/mintime/dissimilarity_index_tract_level_sixom_nlogit_nested1.csv \
	../output/mintime/dissimilarity_index_pairwise_venue_level_sixom_nlogit_nested1.csv \
	../output/mintime/dissimilarity_index_venue_level_sixom_nlogit_nested1.csv 

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(dissim_residential) $(dissim_omintercepts) $(dissim_sixom_mainspec) $(dissim_sixom_robustnesschecks) $(dissim_mintime) \
		$(dissim_sixom_nlogit) $(dissim_mintime_nlogit)

all_quick_version: $(folders_and_symlinks_quick_version) $(dissim_residential) $(dissim_sixom_mainspec)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(folders_and_symlinks_quick_version): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks_quick_version.txt

$(dissim_residential): $(PROGS) $(stata_dta) dissimilarity_residential_calls.jl dissimilarity_residential_calls.sbatch
	sbatch -W dissimilarity_residential_calls.sbatch

$(dissim_sixom_mainspec): $(PROGS) $(stata_dta) $(predictedvisits_sixom_mainspec) dissimilarity_venueandtract_originmode_specification.jl dissimilarity_venueandtract_sixom_mainspec.sbatch
	sbatch -W dissimilarity_venueandtract_sixom_mainspec.sbatch

$(dissim_omintercepts): $(PROGS) $(stata_dta) $(predictedvisits_omintercepts) dissimilarity_venueandtract_sixom_omintercepts_typebias.jl dissimilarity_venueandtract_sixom_omintercepts_typebias.sbatch
	sbatch -W dissimilarity_venueandtract_sixom_omintercepts_typebias.sbatch

$(dissim_sixom_robustnesschecks): $(PROGS) $(stata_dta) $(predictedvisits_sixom_robustnesschecks) dissimilarity_venueandtract_originmode_specification.jl dissimilarity_venueandtract_sixom_robustnesschecks.sbatch
	sbatch -W dissimilarity_venueandtract_sixom_robustnesschecks.sbatch

$(dissim_mintime): $(PROGS) $(stata_dta) $(predictedvisits_mintime) dissimilarity_venueandtract_originmode_specification.jl dissimilarity_venueandtract_mintime.sbatch
	sbatch -W dissimilarity_venueandtract_mintime.sbatch

$(dissim_sixom_nlogit): $(PROGS) $(stata_dta) $(predictedvisits_sixom_nlogit) dissimilarity_venueandtract_originmode_nlogit_nestid.jl dissimilarity_venueandtract_sixom_nlogit_nestid.sbatch
	sbatch -W dissimilarity_venueandtract_sixom_nlogit_nestid.sbatch

$(dissim_mintime_nlogit): $(PROGS) $(stata_dta) $(predictedvisits_mintime_nlogit) dissimilarity_venueandtract_originmode_nlogit_nestid.jl dissimilarity_venueandtract_mintime_nlogit_nestid.sbatch
	sbatch -W dissimilarity_venueandtract_mintime_nlogit_nestid.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
	