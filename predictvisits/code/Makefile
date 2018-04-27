###################
# PROGRAMS
###################

PROGS = compute_predvisits_racespecific_functions.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl

####################
# INPUT
####################

estimates_init_mintime=\
	../input/estimates/mintime/estimates_black_mainspec.csv \
	../input/estimates/mintime/estimates_black_lateadopt.csv \
	../input/estimates/mintime/estimates_black_half.csv \
	../input/estimates/mintime/estimates_black_fifth.csv \
	../input/estimates/mintime/estimates_black_droploca.csv \
	../input/estimates/mintime/estimates_black_locainfo1.csv \
	../input/estimates/mintime/estimates_black_locainfo2.csv \
	../input/estimates/mintime/estimates_black_carshare.csv \
	../input/estimates/mintime/estimates_black_revchain.csv \
	../input/estimates/mintime/estimates_black_disaggcuis.csv \
	../input/estimates/mintime/estimates_black_50.csv \
	../input/estimates/mintime/estimates_black_100.csv \
	../input/estimates/mintime/estimates_asian_mainspec.csv \
	../input/estimates/mintime/estimates_asian_lateadopt.csv \
	../input/estimates/mintime/estimates_asian_half.csv \
	../input/estimates/mintime/estimates_asian_fifth.csv \
	../input/estimates/mintime/estimates_asian_droploca.csv \
	../input/estimates/mintime/estimates_asian_locainfo1.csv \
	../input/estimates/mintime/estimates_asian_locainfo2.csv \
	../input/estimates/mintime/estimates_asian_carshare.csv \
	../input/estimates/mintime/estimates_asian_revchain.csv \
	../input/estimates/mintime/estimates_asian_disaggcuis.csv \
	../input/estimates/mintime/estimates_asian_50.csv \
	../input/estimates/mintime/estimates_asian_100.csv \
	../input/estimates/mintime/estimates_whithisp_mainspec.csv \
	../input/estimates/mintime/estimates_whithisp_lateadopt.csv \
	../input/estimates/mintime/estimates_whithisp_half.csv \
	../input/estimates/mintime/estimates_whithisp_fifth.csv \
	../input/estimates/mintime/estimates_whithisp_droploca.csv \
	../input/estimates/mintime/estimates_whithisp_locainfo1.csv \
	../input/estimates/mintime/estimates_whithisp_locainfo2.csv \
	../input/estimates/mintime/estimates_whithisp_carshare.csv \
	../input/estimates/mintime/estimates_whithisp_revchain.csv \
	../input/estimates/mintime/estimates_whithisp_disaggcuis.csv \
	../input/estimates/mintime/estimates_whithisp_50.csv \
	../input/estimates/mintime/estimates_whithisp_100.csv \

estimates_init_mintime_nlogit=\
	../input/estimates/mintime/estimates_whithisp_nlogit_nested2.csv \
	../input/estimates/mintime/estimates_whithisp_nlogit_nested1.csv \
	../input/estimates/mintime/estimates_black_nlogit_nested2.csv \
	../input/estimates/mintime/estimates_black_nlogit_nested1.csv \
	../input/estimates/mintime/estimates_asian_nlogit_nested2.csv \
	../input/estimates/mintime/estimates_asian_nlogit_nested1.csv

estimates_init_sixom_quick_version=\
	../input/estimates/sixom/estimates_black_mainspec.csv \
	../input/estimates/sixom/estimates_asian_mainspec.csv \
	../input/estimates/sixom/estimates_whithisp_mainspec.csv \

estimates_init_sixom_other=\
	../input/estimates/sixom/estimates_black_lateadopt.csv \
	../input/estimates/sixom/estimates_black_half.csv \
	../input/estimates/sixom/estimates_black_fifth.csv \
	../input/estimates/sixom/estimates_black_droploca.csv \
	../input/estimates/sixom/estimates_black_locainfo1.csv \
	../input/estimates/sixom/estimates_black_locainfo2.csv \
	../input/estimates/sixom/estimates_black_carshare.csv \
	../input/estimates/sixom/estimates_black_revchain.csv \
	../input/estimates/sixom/estimates_black_disaggcuis.csv \
	../input/estimates/sixom/estimates_black_50.csv \
	../input/estimates/sixom/estimates_black_100.csv \
	../input/estimates/sixom/estimates_asian_lateadopt.csv \
	../input/estimates/sixom/estimates_asian_half.csv \
	../input/estimates/sixom/estimates_asian_fifth.csv \
	../input/estimates/sixom/estimates_asian_droploca.csv \
	../input/estimates/sixom/estimates_asian_locainfo1.csv \
	../input/estimates/sixom/estimates_asian_locainfo2.csv \
	../input/estimates/sixom/estimates_asian_carshare.csv \
	../input/estimates/sixom/estimates_asian_revchain.csv \
	../input/estimates/sixom/estimates_asian_disaggcuis.csv \
	../input/estimates/sixom/estimates_asian_50.csv \
	../input/estimates/sixom/estimates_asian_100.csv \
	../input/estimates/sixom/estimates_whithisp_lateadopt.csv \
	../input/estimates/sixom/estimates_whithisp_half.csv \
	../input/estimates/sixom/estimates_whithisp_fifth.csv \
	../input/estimates/sixom/estimates_whithisp_droploca.csv \
	../input/estimates/sixom/estimates_whithisp_locainfo1.csv \
	../input/estimates/sixom/estimates_whithisp_locainfo2.csv \
	../input/estimates/sixom/estimates_whithisp_carshare.csv \
	../input/estimates/sixom/estimates_whithisp_revchain.csv \
	../input/estimates/sixom/estimates_whithisp_disaggcuis.csv \
	../input/estimates/sixom/estimates_whithisp_50.csv \
	../input/estimates/sixom/estimates_whithisp_100.csv \

estimates_init_sixom+=$(estimates_init_sixom_quick_version)

estimates_init_sixom_omintercepts=\
	../input/estimates/sixom/estimates_whithisp_omintercepts.csv \
	../input/estimates/sixom/estimates_black_omintercepts.csv \
	../input/estimates/sixom/estimates_asian_omintercepts.csv

estimates_init_sixom_nlogit=\
	../input/estimates/sixom/estimates_whithisp_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_whithisp_nlogit_nested1.csv \
	../input/estimates/sixom/estimates_black_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_black_nlogit_nested1.csv \
	../input/estimates/sixom/estimates_asian_nlogit_nested2.csv \
	../input/estimates/sixom/estimates_asian_nlogit_nested1.csv

JLDs=\
	../input/JLDs/venues.jld \
	../input/JLDs/top_workplaces_5.jld \
	../input/JLDs/geoid11_work_pair.jld \
	../input/JLDs/geoid11.jld \
	../input/JLDs/geoid11_home_work.jld \
	../input/JLDs/geoid11_home_pair.jld \
	../input/JLDs/geoid11_home.jld

predvisitsarray = $(shell seq 1 2103|awk '$$0="../input/predictedvisitsarray/predvisitarray_"$$0'| awk '$$0=$$0".jld"'|tr "\n" " ")

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

folders_and_symlinks_quick_version=create_folders_and_symlinks_quick_version.txt

####################
# Predicted visits
####################

predictedvisits_mintime=\
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_mainspec.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_lateadopt.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_half.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_fifth.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_droploca.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_locainfo1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_locainfo2.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_carshare.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_revchain.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_disaggcuis.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_50.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_100.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_mainspec.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_lateadopt.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_half.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_fifth.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_droploca.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_locainfo1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_locainfo2.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_carshare.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_revchain.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_disaggcuis.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_50.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_100.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_mainspec.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_lateadopt.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_half.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_fifth.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_droploca.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_locainfo1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_locainfo2.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_carshare.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_revchain.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_disaggcuis.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_50.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_100.jld

predictedvisits_mintime_nlogit=\
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_nlogit_nested1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_black_mintime_nlogit_nested2.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_nlogit_nested1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_asian_mintime_nlogit_nested2.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_nlogit_nested1.jld \
	../output/predictedvisits/mintime/predictedvisits_collapsed_over_workplace_whithisp_mintime_nlogit_nested2.jld

predictedvisits_sixom_quick_version=\
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_mainspec.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_mainspec.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_mainspec.jld \

predictedvisits_sixom_other=\
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_lateadopt.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_half.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_fifth.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_droploca.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_locainfo1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_locainfo2.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_carshare.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_revchain.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_disaggcuis.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_50.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_100.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_lateadopt.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_half.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_fifth.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_droploca.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_locainfo1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_locainfo2.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_carshare.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_revchain.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_disaggcuis.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_50.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_100.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_lateadopt.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_half.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_fifth.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_droploca.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_locainfo1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_locainfo2.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_carshare.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_revchain.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_disaggcuis.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_50.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_100.jld \

predictedvisits_omintercepts =\
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_omintercepts_bias.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_omintercepts_nobias.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_omintercepts_bias.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_omintercepts_nobias.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_omintercepts_bias.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_omintercepts_nobias.jld

predictedvisits_sixom_nlogit=\
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_nlogit_nested1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_black_sixom_nlogit_nested2.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_nlogit_nested1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_asian_sixom_nlogit_nested2.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_nlogit_nested1.jld \
	../output/predictedvisits/sixom/predictedvisits_collapsed_over_workplace_whithisp_sixom_nlogit_nested2.jld

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(predictedvisits_omintercepts) $(predictedvisits_mintime) $(predictedvisits_sixom_quick_version) $(predictedvisits_sixom_other) \
	$(predictedvisits_mintime_nlogit) $(predictedvisits_sixom_nlogit)

all_quick_version: $(folders_and_symlinks_quick_version) $(predictedvisits_sixom_quick_version)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(folders_and_symlinks_quick_version): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks_quick_version.txt
	
$(predictedvisits_omintercepts): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_sixom_omintercepts) predvisits_raceid_sixom_omintercepts_typebias.jl predvisits_raceid_sixom_omintercepts_typebias.sbatch
	sbatch -W predvisits_raceid_sixom_omintercepts_typebias.sbatch

$(predictedvisits_mintime): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_mintime) predvisits_raceid_originmode_specification.jl predvisits_raceid_mintime.sbatch
	sbatch -W predvisits_raceid_mintime.sbatch

$(predictedvisits_sixom_other): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_sixom_other) predvisits_raceid_originmode_specification.jl predvisits_raceid_sixom_other.sbatch
	sbatch -W predvisits_raceid_sixom_other.sbatch

$(predictedvisits_mintime_nlogit): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_mintime_nlogit) predvisits_raceid_originmode_nlogit_nestid.jl predvisits_raceid_mintime_nlogit_nestid.sbatch
	sbatch -W predvisits_raceid_mintime_nlogit_nestid.sbatch

$(predictedvisits_sixom_nlogit): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_sixom_nlogit) predvisits_raceid_originmode_nlogit_nestid.jl predvisits_raceid_sixom_nlogit_nestid.sbatch
	sbatch -W predvisits_raceid_sixom_nlogit_nestid.sbatch

$(predictedvisits_sixom_quick_version): $(PROGS) $(JLDs) $(predvisitsarray) $(estimates_init_sixom_quick_version) predvisits_raceid_originmode_specification.jl predvisits_raceid_sixom_quick_version.sbatch
	sbatch -W predvisits_raceid_sixom_quick_version.sbatch
	
edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
