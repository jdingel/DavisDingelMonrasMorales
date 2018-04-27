####################
# Global functions
####################

estarray_func = gen_estimationarray_functions.jl

estimation_func=\
	estimation_functions.jl \
	fit_mnl_hessianfree.jl \
	fit_mnl_newton.jl \
	fit_nlogit_onelambda_multiperiod.jl \
	general_functions.jl \
	tables_formatting.jl \

####################
# INPUT
####################

estarrays_home_dta= \
	../input/estarrays/norg/estarray_whithisp_homeonly.dta \
	../input/estarrays/norg/estarray_black_homeonly.dta \
	../input/estarrays/norg/estarray_asian_homeonly.dta \
	../input/estarrays/norg/estarray_whithisp_homeonlysample.dta \
	../input/estarrays/norg/estarray_black_homeonlysample.dta \
	../input/estarrays/norg/estarray_asian_homeonlysample.dta

estarrays_norg_dta=\
	../input/estarrays/sixom/estarray_asian_spatial.dta \
	../input/estarrays/sixom/estarray_black_spatial.dta \
	../input/estarrays/sixom/estarray_whithisp_spatial.dta

estarrays_omintercepts_dta=\
	../input/estarrays/sixom/estarray_whithisp_mainspec.dta \
	../input/estarrays/sixom/estarray_black_mainspec.dta \
	../input/estarrays/sixom/estarray_asian_mainspec.dta

estarrays_raceblind_dta=\
	../input/estarrays/sixom/estarray_raceblind.dta

estarrays_sixom_standard1_dta=\
	../input/estarrays/sixom/estarray_asian_carshare.dta \
	../input/estarrays/sixom/estarray_asian_droploca.dta \
	../input/estarrays/sixom/estarray_asian.dta \
	../input/estarrays/sixom/estarray_asian_fifth.dta \
	../input/estarrays/sixom/estarray_asian_genderspecific.dta \
	../input/estarrays/sixom/estarray_asian_half.dta \
	../input/estarrays/sixom/estarray_asian_lateadopt.dta \
	../input/estarrays/sixom/estarray_asian_locainfo1.dta \
	../input/estarrays/sixom/estarray_asian_locainfo2.dta \
	../input/estarrays/sixom/estarray_asian_mainspec.dta \
	../input/estarrays/sixom/estarray_asian_revchain.dta \
	../input/estarrays/sixom/estarray_asian_spatialage.dta \
	../input/estarrays/sixom/estarray_asian_spatialgender.dta \
	../input/estarrays/sixom/estarray_asian_spatialincome.dta \
	../input/estarrays/sixom/estarray_black_carshare.dta \
	../input/estarrays/sixom/estarray_black_droploca.dta \
	../input/estarrays/sixom/estarray_black.dta \
	../input/estarrays/sixom/estarray_black_fifth.dta \
	../input/estarrays/sixom/estarray_black_genderspecific.dta \
	../input/estarrays/sixom/estarray_black_half.dta \
	../input/estarrays/sixom/estarray_black_lateadopt.dta \
	../input/estarrays/sixom/estarray_black_locainfo1.dta \
	../input/estarrays/sixom/estarray_black_locainfo2.dta \
	../input/estarrays/sixom/estarray_black_mainspec.dta \
	../input/estarrays/sixom/estarray_black_revchain.dta \
	../input/estarrays/sixom/estarray_black_spatialage.dta \
	../input/estarrays/sixom/estarray_black_spatialgender.dta \
	../input/estarrays/sixom/estarray_black_spatialincome.dta \
	../input/estarrays/sixom/estarray_whithisp_carshare.dta \
	../input/estarrays/sixom/estarray_whithisp_droploca.dta \
	../input/estarrays/sixom/estarray_whithisp.dta \
	../input/estarrays/sixom/estarray_whithisp_fifth.dta \
	../input/estarrays/sixom/estarray_whithisp_genderspecific.dta \
	../input/estarrays/sixom/estarray_whithisp_half.dta \
	../input/estarrays/sixom/estarray_whithisp_lateadopt.dta \
	../input/estarrays/sixom/estarray_whithisp_locainfo1.dta \
	../input/estarrays/sixom/estarray_whithisp_locainfo2.dta \
	../input/estarrays/sixom/estarray_whithisp_mainspec.dta \
	../input/estarrays/sixom/estarray_whithisp_revchain.dta \
	../input/estarrays/sixom/estarray_whithisp_spatialage.dta \
	../input/estarrays/sixom/estarray_whithisp_spatialgender.dta \
	../input/estarrays/sixom/estarray_whithisp_spatialincome.dta \
	../input/estarrays/sixom/estarray_asian_disaggcuis.dta \

estarrays_sixom_standard2_dta=\
	../input/estarrays/sixom/estarray_asian_100.dta \
	../input/estarrays/sixom/estarray_asian_50.dta \
	../input/estarrays/sixom/estarray_black_100.dta \
	../input/estarrays/sixom/estarray_black_50.dta \
	../input/estarrays/sixom/estarray_whithisp_100.dta \
	../input/estarrays/sixom/estarray_whithisp_50.dta \
	../input/estarrays/sixom/estarray_black_disaggcuis.dta \
	../input/estarrays/sixom/estarray_whithisp_disaggcuis.dta \

estarrays_mintime_standard1_dta= \
	../input/estarrays/mintime/estarray_whithisp_locainfo2.dta \
	../input/estarrays/mintime/estarray_whithisp_locainfo1.dta \
	../input/estarrays/mintime/estarray_whithisp_droploca.dta \
	../input/estarrays/mintime/estarray_whithisp_carshare.dta \
	../input/estarrays/mintime/estarray_whithisp_revchain.dta \
	../input/estarrays/mintime/estarray_whithisp_fifth.dta \
	../input/estarrays/mintime/estarray_whithisp_half.dta \
	../input/estarrays/mintime/estarray_whithisp_lateadopt.dta \
	../input/estarrays/mintime/estarray_whithisp_mainspec.dta \
	../input/estarrays/mintime/estarray_black_locainfo2.dta \
	../input/estarrays/mintime/estarray_black_locainfo1.dta \
	../input/estarrays/mintime/estarray_black_droploca.dta \
	../input/estarrays/mintime/estarray_black_carshare.dta \
	../input/estarrays/mintime/estarray_black_revchain.dta \
	../input/estarrays/mintime/estarray_black_fifth.dta \
	../input/estarrays/mintime/estarray_black_half.dta \
	../input/estarrays/mintime/estarray_black_lateadopt.dta \
	../input/estarrays/mintime/estarray_black_mainspec.dta \
	../input/estarrays/mintime/estarray_asian_locainfo2.dta \
	../input/estarrays/mintime/estarray_asian_locainfo1.dta \
	../input/estarrays/mintime/estarray_asian_droploca.dta \
	../input/estarrays/mintime/estarray_asian_carshare.dta \
	../input/estarrays/mintime/estarray_asian_revchain.dta \
	../input/estarrays/mintime/estarray_asian_fifth.dta \
	../input/estarrays/mintime/estarray_asian_half.dta \
	../input/estarrays/mintime/estarray_asian_lateadopt.dta \
	../input/estarrays/mintime/estarray_asian_mainspec.dta

estarrays_mintime_standard2_dta= \
	../input/estarrays/mintime/estarray_whithisp_100.dta \
	../input/estarrays/mintime/estarray_whithisp_50.dta \
	../input/estarrays/mintime/estarray_black_100.dta \
	../input/estarrays/mintime/estarray_black_50.dta \
	../input/estarrays/mintime/estarray_asian_100.dta \
	../input/estarrays/mintime/estarray_asian_50.dta \
	../input/estarrays/mintime/estarray_whithisp_disaggcuis.dta \
	../input/estarrays/mintime/estarray_black_disaggcuis.dta \
	../input/estarrays/mintime/estarray_asian_disaggcuis.dta

#####################
# OUTPUT
#####################

folders_and_symlinks=create_folders_and_symlinks.txt

###################
# Estarrays
###################

estarrays_home_jld= \
	../output/estarrays_JLDs/norg/estarray_whithisp_homeonly.jld \
	../output/estarrays_JLDs/norg/estarray_black_homeonly.jld \
	../output/estarrays_JLDs/norg/estarray_asian_homeonly.jld \
	../output/estarrays_JLDs/norg/estarray_whithisp_homeonlysample.jld \
	../output/estarrays_JLDs/norg/estarray_black_homeonlysample.jld \
	../output/estarrays_JLDs/norg/estarray_asian_homeonlysample.jld

estarrays_norg_jld=\
	../output/estarrays_JLDs/norg/estarray_whithisp_spatial6.jld \
	../output/estarrays_JLDs/norg/estarray_asian_spatial6.jld \
	../output/estarrays_JLDs/norg/estarray_asian_spatial4.jld \
	../output/estarrays_JLDs/norg/estarray_whithisp_spatial4.jld \
	../output/estarrays_JLDs/norg/estarray_whithisp_spatial2.jld \
	../output/estarrays_JLDs/norg/estarray_asian_spatial2.jld \
	../output/estarrays_JLDs/norg/estarray_black_spatial4.jld \
	../output/estarrays_JLDs/norg/estarray_black_spatial6.jld \
	../output/estarrays_JLDs/norg/estarray_black_spatial2.jld

estarrays_omintercepts_jld=\
	../output/estarrays_JLDs/sixom/estarray_asian_omintercepts.jld \
	../output/estarrays_JLDs/sixom/estarray_black_omintercepts.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_omintercepts.jld

estarrays_raceblind_jld=\
	../output/estarrays_JLDs/sixom/estarray_raceblind.jld

estarrays_sixom_standard1_jld=\
	../output/estarrays_JLDs/sixom/estarray_whithisp_spatialincome.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_spatialage.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_spatialgender.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_spatialincome.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_spatialgender.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_revchain.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_mainspec.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_carshare.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_revchain.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_mainspec.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_carshare.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_droploca.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_droploca.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_locainfo1.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_half.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_locainfo2.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_locainfo1.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_half.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_locainfo2.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_lateadopt.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_lateadopt.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_fifth.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_fifth.jld \
	../output/estarrays_JLDs/sixom/estarray_black_spatialincome.jld \
	../output/estarrays_JLDs/sixom/estarray_black_spatialgender.jld \
	../output/estarrays_JLDs/sixom/estarray_black_revchain.jld \
	../output/estarrays_JLDs/sixom/estarray_black_carshare.jld \
	../output/estarrays_JLDs/sixom/estarray_black_mainspec.jld \
	../output/estarrays_JLDs/sixom/estarray_black_locainfo2.jld \
	../output/estarrays_JLDs/sixom/estarray_black_locainfo1.jld \
	../output/estarrays_JLDs/sixom/estarray_black_droploca.jld \
	../output/estarrays_JLDs/sixom/estarray_black_lateadopt.jld \
	../output/estarrays_JLDs/sixom/estarray_black_half.jld \
	../output/estarrays_JLDs/sixom/estarray_black_fifth.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_spatialage.jld \
	../output/estarrays_JLDs/sixom/estarray_black_spatialage.jld

estarrays_sixom_standard2_jld=\
	../output/estarrays_JLDs/sixom/estarray_whithisp_100.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_100.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_50.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_50.jld \
	../output/estarrays_JLDs/sixom/estarray_black_100.jld \
	../output/estarrays_JLDs/sixom/estarray_black_50.jld \
	../output/estarrays_JLDs/sixom/estarray_whithisp_disaggcuis.jld \
	../output/estarrays_JLDs/sixom/estarray_asian_disaggcuis.jld \
	../output/estarrays_JLDs/sixom/estarray_black_disaggcuis.jld

estarrays_mintime_standard1_jld= \
	../output/estarrays_JLDs/mintime/estarray_whithisp_carshare.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_revchain.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_mainspec.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_revchain.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_mainspec.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_carshare.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_spatialage.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_droploca.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_droploca.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_locainfo2.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_half.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_locainfo1.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_half.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_locainfo2.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_lateadopt.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_lateadopt.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_locainfo1.jld \
	../output/estarrays_JLDs/mintime/estarray_black_spatialage.jld \
	../output/estarrays_JLDs/mintime/estarray_black_revchain.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_fifth.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_fifth.jld \
	../output/estarrays_JLDs/mintime/estarray_black_carshare.jld \
	../output/estarrays_JLDs/mintime/estarray_black_locainfo1.jld \
	../output/estarrays_JLDs/mintime/estarray_black_lateadopt.jld \
	../output/estarrays_JLDs/mintime/estarray_black_locainfo2.jld \
	../output/estarrays_JLDs/mintime/estarray_black_fifth.jld \
	../output/estarrays_JLDs/mintime/estarray_black_droploca.jld \
	../output/estarrays_JLDs/mintime/estarray_black_half.jld \
	../output/estarrays_JLDs/mintime/estarray_black_mainspec.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_spatialage.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_spatialgender.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_spatialincome.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_spatialgender.jld \
	../output/estarrays_JLDs/mintime/estarray_black_spatialgender.jld \
	../output/estarrays_JLDs/mintime/estarray_black_spatialincome.jld

estarrays_mintime_standard2_jld= \
	../output/estarrays_JLDs/mintime/estarray_whithisp_100.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_50.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_100.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_50.jld \
	../output/estarrays_JLDs/mintime/estarray_black_100.jld \
	../output/estarrays_JLDs/mintime/estarray_black_50.jld \
	../output/estarrays_JLDs/mintime/estarray_asian_disaggcuis.jld \
	../output/estarrays_JLDs/mintime/estarray_whithisp_disaggcuis.jld \
	../output/estarrays_JLDs/mintime/estarray_black_disaggcuis.jld

####################
# Estimates
####################

estimates_home= \
	../output/estimates/norg/estimates_whithisp_homeonly.csv \
	../output/estimates/norg/estimates_black_homeonly.csv \
	../output/estimates/norg/estimates_asian_homeonly.csv \
	../output/estimates/norg/estimates_whithisp_homeonlysample.csv \
	../output/estimates/norg/estimates_black_homeonlysample.csv \
	../output/estimates/norg/estimates_asian_homeonlysample.csv

estimates_norg=\
	../output/estimates/norg/estimates_whithisp_spatial6.csv \
	../output/estimates/norg/estimates_asian_spatial6.csv \
	../output/estimates/norg/estimates_asian_spatial4.csv \
	../output/estimates/norg/estimates_whithisp_spatial4.csv \
	../output/estimates/norg/estimates_whithisp_spatial2.csv \
	../output/estimates/norg/estimates_asian_spatial2.csv \
	../output/estimates/norg/estimates_black_spatial4.csv \
	../output/estimates/norg/estimates_black_spatial6.csv \
	../output/estimates/norg/estimates_black_spatial2.csv

estimates_omintercepts=\
	../output/estimates/sixom/estimates_asian_omintercepts.csv \
	../output/estimates/sixom/estimates_black_omintercepts.csv \
	../output/estimates/sixom/estimates_whithisp_omintercepts.csv

estimates_raceblind=\
	../output/estimates/sixom/estimates_raceblind.csv

estimates_sixom_standard1=\
	../output/estimates/sixom/estimates_asian_mainspec.csv \
	../output/estimates/sixom/estimates_asian_lateadopt.csv \
	../output/estimates/sixom/estimates_asian_half.csv \
	../output/estimates/sixom/estimates_asian_fifth.csv \
	../output/estimates/sixom/estimates_asian_droploca.csv \
	../output/estimates/sixom/estimates_asian_locainfo1.csv \
	../output/estimates/sixom/estimates_asian_locainfo2.csv \
	../output/estimates/sixom/estimates_asian_carshare.csv \
	../output/estimates/sixom/estimates_asian_revchain.csv \
	../output/estimates/sixom/estimates_asian_spatialage.csv \
	../output/estimates/sixom/estimates_asian_spatialgender.csv \
	../output/estimates/sixom/estimates_asian_spatialincome.csv \
	../output/estimates/sixom/estimates_black_mainspec.csv \
	../output/estimates/sixom/estimates_black_lateadopt.csv \
	../output/estimates/sixom/estimates_black_half.csv \
	../output/estimates/sixom/estimates_black_fifth.csv \
	../output/estimates/sixom/estimates_black_droploca.csv \
	../output/estimates/sixom/estimates_black_locainfo1.csv \
	../output/estimates/sixom/estimates_black_locainfo2.csv \
	../output/estimates/sixom/estimates_black_carshare.csv \
	../output/estimates/sixom/estimates_black_revchain.csv \
	../output/estimates/sixom/estimates_black_spatialage.csv \
	../output/estimates/sixom/estimates_black_spatialgender.csv \
	../output/estimates/sixom/estimates_black_spatialincome.csv \
	../output/estimates/sixom/estimates_whithisp_mainspec.csv \
	../output/estimates/sixom/estimates_whithisp_lateadopt.csv \
	../output/estimates/sixom/estimates_whithisp_half.csv \
	../output/estimates/sixom/estimates_whithisp_fifth.csv \
	../output/estimates/sixom/estimates_whithisp_droploca.csv \
	../output/estimates/sixom/estimates_whithisp_locainfo1.csv \
	../output/estimates/sixom/estimates_whithisp_locainfo2.csv \
	../output/estimates/sixom/estimates_whithisp_carshare.csv \
	../output/estimates/sixom/estimates_whithisp_revchain.csv \
	../output/estimates/sixom/estimates_whithisp_spatialage.csv \
	../output/estimates/sixom/estimates_whithisp_spatialgender.csv \
	../output/estimates/sixom/estimates_whithisp_spatialincome.csv

estimates_sixom_standard2=\
	../output/estimates/sixom/estimates_whithisp_100.csv \
	../output/estimates/sixom/estimates_whithisp_50.csv \
	../output/estimates/sixom/estimates_asian_100.csv \
	../output/estimates/sixom/estimates_asian_50.csv \
	../output/estimates/sixom/estimates_black_100.csv \
	../output/estimates/sixom/estimates_black_50.csv \
	../output/estimates/sixom/estimates_asian_disaggcuis.csv \
	../output/estimates/sixom/estimates_whithisp_disaggcuis.csv \
	../output/estimates/sixom/estimates_black_disaggcuis.csv \

estimates_mintime_standard1= \
	../output/estimates/mintime/estimates_asian_mainspec.csv \
	../output/estimates/mintime/estimates_asian_lateadopt.csv \
	../output/estimates/mintime/estimates_asian_half.csv \
	../output/estimates/mintime/estimates_asian_fifth.csv \
	../output/estimates/mintime/estimates_asian_droploca.csv \
	../output/estimates/mintime/estimates_asian_locainfo1.csv \
	../output/estimates/mintime/estimates_asian_locainfo2.csv \
	../output/estimates/mintime/estimates_asian_carshare.csv \
	../output/estimates/mintime/estimates_asian_revchain.csv \
	../output/estimates/mintime/estimates_asian_spatialage.csv \
	../output/estimates/mintime/estimates_asian_spatialgender.csv \
	../output/estimates/mintime/estimates_asian_spatialincome.csv \
	../output/estimates/mintime/estimates_black_mainspec.csv \
	../output/estimates/mintime/estimates_black_lateadopt.csv \
	../output/estimates/mintime/estimates_black_half.csv \
	../output/estimates/mintime/estimates_black_fifth.csv \
	../output/estimates/mintime/estimates_black_droploca.csv \
	../output/estimates/mintime/estimates_black_locainfo1.csv \
	../output/estimates/mintime/estimates_black_locainfo2.csv \
	../output/estimates/mintime/estimates_black_carshare.csv \
	../output/estimates/mintime/estimates_black_revchain.csv \
	../output/estimates/mintime/estimates_black_spatialage.csv \
	../output/estimates/mintime/estimates_black_spatialgender.csv \
	../output/estimates/mintime/estimates_black_spatialincome.csv \
	../output/estimates/mintime/estimates_whithisp_mainspec.csv \
	../output/estimates/mintime/estimates_whithisp_lateadopt.csv \
	../output/estimates/mintime/estimates_whithisp_half.csv \
	../output/estimates/mintime/estimates_whithisp_fifth.csv \
	../output/estimates/mintime/estimates_whithisp_droploca.csv \
	../output/estimates/mintime/estimates_whithisp_locainfo1.csv \
	../output/estimates/mintime/estimates_whithisp_locainfo2.csv \
	../output/estimates/mintime/estimates_whithisp_carshare.csv \
	../output/estimates/mintime/estimates_whithisp_revchain.csv \
	../output/estimates/mintime/estimates_whithisp_spatialage.csv \
	../output/estimates/mintime/estimates_whithisp_spatialgender.csv \
	../output/estimates/mintime/estimates_whithisp_spatialincome.csv

estimates_mintime_standard2= \
	../output/estimates/mintime/estimates_whithisp_100.csv \
	../output/estimates/mintime/estimates_whithisp_50.csv \
	../output/estimates/mintime/estimates_asian_100.csv \
	../output/estimates/mintime/estimates_asian_50.csv \
	../output/estimates/mintime/estimates_black_100.csv \
	../output/estimates/mintime/estimates_black_50.csv \
	../output/estimates/mintime/estimates_asian_disaggcuis.csv \
	../output/estimates/mintime/estimates_whithisp_disaggcuis.csv \
	../output/estimates/mintime/estimates_black_disaggcuis.csv \

####################
# Estimates
####################

tables=\
	../output/tables/mintime/tab_robustnesschecks2_whithisp_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks1_whithisp_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks2_asian_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks1_asian_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks2_black_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks1_black_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks_whithisp_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks_asian_mintime.tex \
	../output/tables/mintime/tab_robustnesschecks_black_mintime.tex \
	../output/tables/norg/table_homeonlysample_homeonly.tex \
	../output/tables/norg/table_spatialfrictionsonly.tex \
	../output/tables/sixom/tab_raceblind.tex \
	../output/tables/sixom/tab_omintercepts.tex \
	../output/tables/sixom/table_spatialfrictions_robustness.tex \
	../output/tables/sixom/tab_robustnesschecks1_asian_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks2_asian_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks2_whithisp_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks1_whithisp_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks2_black_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks1_black_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks_whithisp_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks_asian_sixom.tex \
	../output/tables/sixom/tab_robustnesschecks_black_sixom.tex \
	../output/tables/sixom/tab_nosocial_and_mainspec.tex

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(estarrays_home_jld) $(estarrays_norg_jld) $(estarrays_omintercepts_jld) $(estarrays_raceblind_jld) \
	$(estarrays_mintime_standard1_jld) $(estarrays_mintime_standard2_jld) \
	$(estarrays_sixom_standard1_jld) $(estarrays_sixom_standard2_jld) \
	$(estimates_home) $(estimates_norg) $(estimates_omintercepts) $(estimates_raceblind) \
	$(estimates_mintime_standard1) $(estimates_mintime_standard2) \
	$(estimates_sixom_standard1) $(estimates_sixom_standard2) \
	$(tables) \

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estarrays_home_jld): $(estarrays_home_dta) $(estarray_func) gen_estimationarray_calls_home.jl gen_estimationarray_calls_home.sbatch
	sbatch -W gen_estimationarray_calls_home.sbatch

$(estarrays_norg_jld): $(estarrays_norg_dta) $(estarray_func) gen_estimationarray_calls_norg.jl gen_estimationarray_calls_norg.sbatch
	sbatch -W gen_estimationarray_calls_norg.sbatch

$(estarrays_omintercepts_jld): $(estarrays_omintercepts_dta) $(estarray_func) gen_estimationarray_calls_omintercepts.jl gen_estimationarray_calls_omintercepts.sbatch
	sbatch -W gen_estimationarray_calls_omintercepts.sbatch

$(estarrays_raceblind_jld): $(estarrays_raceblind_dta) $(estarray_func) gen_estimationarray_calls_raceblind.jl gen_estimationarray_calls_raceblind.sbatch
	sbatch -W gen_estimationarray_calls_raceblind.sbatch

$(estarrays_mintime_standard1_jld): $(estarrays_mintime_standard1_dta) $(estarray_func) gen_estimationarray_calls_standard.jl gen_estimationarray_calls_mintime_standard1.sbatch
	sbatch -W gen_estimationarray_calls_mintime_standard1.sbatch

$(estarrays_mintime_standard2_jld): $(estarrays_mintime_standard2_dta) $(estarray_func) gen_estimationarray_calls_standard.jl gen_estimationarray_calls_mintime_standard2.sbatch
	sbatch -W gen_estimationarray_calls_mintime_standard2.sbatch

$(estarrays_sixom_standard1_jld): $(estarrays_sixom_standard1_dta) $(estarray_func) gen_estimationarray_calls_standard.jl gen_estimationarray_calls_sixom_standard1.sbatch
	sbatch -W gen_estimationarray_calls_sixom_standard1.sbatch

$(estarrays_sixom_standard2_jld): $(estarrays_sixom_standard2_dta) $(estarray_func) gen_estimationarray_calls_standard.jl gen_estimationarray_calls_sixom_standard2.sbatch
	sbatch -W gen_estimationarray_calls_sixom_standard2.sbatch

$(estimates_home): $(estarrays_home_jld) estimation_calls_home.jl estimation_calls_home.sbatch
	sbatch -W estimation_calls_home.sbatch

$(estimates_norg): $(estarrays_norg_jld) estimation_calls_norg.jl estimation_calls_norg.sbatch
	sbatch -W estimation_calls_norg.sbatch

$(estimates_omintercepts): $(estarrays_omintercepts_jld) estimation_calls_omintercepts.jl estimation_calls_omintercepts.sbatch
	sbatch -W estimation_calls_omintercepts.sbatch

$(estimates_raceblind): $(estarrays_raceblind_jld) estimation_calls_raceblind.jl estimation_calls_raceblind.sbatch
	sbatch -W estimation_calls_raceblind.sbatch

$(estimates_mintime_standard1): $(estarrays_mintime_standard1_jld) estimation_calls_standard.jl estimation_calls_mintime_standard1.sbatch
	sbatch -W estimation_calls_mintime_standard1.sbatch

$(estimates_mintime_standard2): $(estarrays_mintime_standard2_jld) estimation_calls_standard.jl estimation_calls_mintime_standard2.sbatch
	sbatch -W estimation_calls_mintime_standard2.sbatch

$(estimates_sixom_standard1): $(estarrays_sixom_standard1_jld) estimation_calls_standard.jl estimation_calls_sixom_standard1.sbatch
	sbatch -W estimation_calls_sixom_standard1.sbatch

$(estimates_sixom_standard2): $(estarrays_sixom_standard2_jld) estimation_calls_standard.jl estimation_calls_sixom_standard2.sbatch
	sbatch -W estimation_calls_sixom_standard2.sbatch

$(tables): $(estimates_home) $(estimates_norg) $(estimates_omintercepts) $(estimates_raceblind) $(estimates_mintime_standard1) $(estimates_mintime_standard2) $(estimates_sixom_standard1) $(estimates_sixom_standard2) tables_functions.jl tables_formatting.jl tables_MNL_specs.jl tables_MNL_specs.sbatch
	sbatch -W tables_MNL_specs.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
