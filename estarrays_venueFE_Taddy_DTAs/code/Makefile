####################
# INPUT
####################

stata_dta_inputs = \
	../input/geoid11_work_pair.dta \
	../input/geoid11_home_work.dta \
	../input/geoid11_home_pair.dta \
	../input/geoid11_home.dta \
	../input/geoid11_dest.dta \
	../input/venues_est.dta \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/users_est.dta \
	../input/trips_est.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

estarrays_venueFE_Taddy=\
	../output/estarray_venueFE_Taddy_whithisp.dta \
	../output/estarray_venueFE_Taddy_asian.dta \
	../output/estarray_venueFE_Taddy_black.dta 

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(estarrays_venueFE_Taddy)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estarrays_venueFE_Taddy): $(stata_dta_inputs) estarrays_venueFE_programs.do estarrays_venueFE_Taddy_DTAs.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
