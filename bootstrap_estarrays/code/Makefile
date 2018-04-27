####################
# PROGRAMS
####################

PROGS=\
	bootstrap_arraymaker_programs.do \
	bootstrap_estarrays.do \
	choiceset_program.do \
	DATA_PREP_estarray_program.do 

####################
# INPUT
####################

stata_dta=\
	../input/simulatedtrips_mintime.dta \
	../input/simulatedtrips_mainspec.dta \
	../input/venues_est.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/users_est.dta \
	../input/geoid11_dest.dta \
	../input/geoid11_home.dta \
	../input/geoid11_home_pair.dta \
	../input/geoid11_work_pair.dta \
	../input/geoid11_home_work.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

estarrays_bootstrap=$(shell seq 1 500|awk '$$0="../output/mainspec/asian_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap+=$(shell seq 1 500|awk '$$0="../output/mainspec/black_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap+=$(shell seq 1 500|awk '$$0="../output/mainspec/whithisp_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap+=$(shell seq 1 500|awk '$$0="../output/mintime/asian_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap+=$(shell seq 1 500|awk '$$0="../output/mintime/black_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")
estarrays_bootstrap+=$(shell seq 1 500|awk '$$0="../output/mintime/whithisp_"$$0'| awk '$$0=$$0".dta"'|tr "\n" " ")

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(estarrays_bootstrap)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(estarrays_bootstrap): $(PROGS) $(stata_dta) run_array.sbatch
	sbatch -W run_array.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
