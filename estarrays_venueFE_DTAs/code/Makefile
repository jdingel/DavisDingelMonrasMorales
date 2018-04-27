####################
# INPUT
####################

stata_dta_inputs = \
		../input/choiceset_all_posvis.dta \
		../input/users_est.dta \
		../input/venues_est.dta \
		../input/tract_2010_characteristics_est.dta \
		../input/tract_pairs_2010_characteristics_est.dta \
		../input/geoid11_dest.dta \
		../input/geoid11_home.dta \
		../input/geoid11_home_pair.dta \
		../input/geoid11_work_pair.dta \
		../input/geoid11_home_work.dta \
		../input/tract_characteristics.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

estarrays_venueFE=\
	../output/estarray_venueFE_mintime_whithisp.dta \
	../output/estarray_venueFE_mintime_black.dta \
	../output/estarray_venueFE_mintime_asian.dta \
	../output/estarray_venueFE_whithisp.dta \
	../output/estarray_venueFE_black.dta \
	../output/estarray_venueFE_asian.dta 

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(estarrays_venueFE)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estarrays_venueFE): $(stata_dta_inputs) estarrays_venueFE_DTAs.do estarrays_venueFE_programs.do prepcovariates_venueFE.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
