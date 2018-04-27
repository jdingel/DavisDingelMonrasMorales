####################
# INPUT
####################

stata_dta_inputs = \
	../input/venues_alltripsstats.dta \
	../input/users_nonloc.dta \
	../input/trips_nonloc.dta \
	../input/tract_pairs_2010_characteristics_est.dta \
	../input/estarray_raceblind.dta \
	../input/tract_2010_characteristics_est.dta \
	../input/venues_est.dta \
	../input/trips_est.dta \
	../input/users_est.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output = \
	../output/table_A02_lower.tex \
	../output/table_A02_upper.tex \
	../output/table_A01.tex \
	../output/edd_phdist_users.dta \
	../output/sumstats_table1.tex \
	../output/residential_isolation_indices.tex \
	../output/summ_tracts_MN_stats_weighted.tex \
	../output/summ_tracts_stats_weighted.tex \
	../output/summ_users_stats.tex \
	../output/rdfm_eucl_density.pdf \
	../output/rdfm_timework_density.pdf \
	../output/rdfm_timehome_density.pdf 

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(stata_dta_inputs) tableA02.do tableA01.do table1.do frictions_kdensities.do run.sbatch
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh

