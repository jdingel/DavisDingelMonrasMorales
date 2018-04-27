####################
# INPUT
####################

stata_dta_inputs = \
	../input/choiceset_whithisp.dta \
	../input/choiceset_asian.dta \
	../input/choiceset_black.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/users_est.dta \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/venues_est.dta \
	../input/geoid11_dest.dta \
	../input/geoid11_home.dta \
	../input/geoid11_home_pair.dta \
	../input/geoid11_work_pair.dta \
	../input/geoid11_home_work.dta \
	../input/tract_2010_characteristics_est.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# dta files
####################

venues= ../output/venues.dta

estarray_mintime=\
	../output/mintime/estarray_whithisp_incval_nested2.dta \
	../output/mintime/estarray_whithisp_nests_nested2.dta \
	../output/mintime/estarray_whithisp_incval_nested1.dta \
	../output/mintime/estarray_whithisp_nests_nested1.dta \
	../output/mintime/estarray_black_incval_nested2.dta \
	../output/mintime/estarray_black_nests_nested2.dta \
	../output/mintime/estarray_black_incval_nested1.dta \
	../output/mintime/estarray_black_nests_nested1.dta \
	../output/mintime/estarray_asian_incval_nested2.dta \
	../output/mintime/estarray_asian_nests_nested2.dta \
	../output/mintime/estarray_asian_incval_nested1.dta \
	../output/mintime/estarray_asian_nests_nested1.dta 

estarray_sixom=\
	../output/sixom/estarray_whithisp_incval_nested2.dta \
	../output/sixom/estarray_whithisp_nests_nested2.dta \
	../output/sixom/estarray_whithisp_incval_nested1.dta \
	../output/sixom/estarray_whithisp_nests_nested1.dta \
	../output/sixom/estarray_black_incval_nested2.dta \
	../output/sixom/estarray_black_nests_nested2.dta \
	../output/sixom/estarray_black_incval_nested1.dta \
	../output/sixom/estarray_black_nests_nested1.dta \
	../output/sixom/estarray_asian_incval_nested2.dta \
	../output/sixom/estarray_asian_nests_nested2.dta \
	../output/sixom/estarray_asian_incval_nested1.dta \
	../output/sixom/estarray_asian_nests_nested1.dta 

output_all=$(venues)
output_all+=$(estarray_mintime)
output_all+=$(estarray_sixom)

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output_all)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output_all): $(stata_dta_inputs) estarray_nested_programs.do estarrays_nestedlogit_DTAs.do DATA_PREP_estarray_program.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
	