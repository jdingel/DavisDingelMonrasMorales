####################
# PROGRAMS
####################

PROGS = \
	predictvisits_estsmp_arrays.do \
	DATA_PREP_estarray_program.do \

####################
# INPUT
####################

stata_dta=\
	../input/users_est.dta \
	../input/venues_est.dta \
	../input/geoid11_home_pair.dta \
	../input/geoid11_home_work.dta \
	../input/geoid11_work_pair.dta \
	../input/geoid11_dest.dta \
	../input/geoid11_home.dta \
	../input/venues.dta

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

estsample_predictarray=\
	../output/estsample_predictarray_whithisp_mintime.dta \
	../output/estsample_predictarray_black_mintime.dta \
	../output/estsample_predictarray_asian_mintime.dta \
	../output/estsample_predictarray_whithisp_sixom.dta \
	../output/estsample_predictarray_black_sixom.dta \
	../output/estsample_predictarray_asian_sixom.dta \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(estsample_predictarray)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estsample_predictarray): $(PROGS) $(stata_dta) run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
