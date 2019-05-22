##Definitions

stata_dta_symlinks = \
	../output/venues_alltripsstats.dta \
	../output/users_nonloc.dta \
	../output/trips_nonloc.dta \
	../output/YelpvsDOHMH_ZIPs.dta \
	../output/venues_est.dta \
	../output/users_homeonlysample.dta \
	../output/users_est.dta \
	../output/trips_est.dta \
	../output/traveltime_gain_new_line.dta \
	../output/tracts.dta \
	../output/tractpairs.dta \
	../output/top_workplaces_5.dta \
	../output/observationallyequivalentvenuesdata.dta \
	../output/geoid11_coords.dta \
	../output/dotmap_zoomcuts.dta \
	../output/dotmap_labels_harlem.dta \
	../output/dotmap_labels_bklyn.dta \
	../output/choiceset_homeonly.dta \
	../output/choiceset_droploca.dta \
	../output/choiceset_all_posvis.dta \
	../output/choiceset_all.dta \
	../output/choiceset_50.dta \
	../output/choiceset_100.dta 

stata_dta_output = \
	../output/geoid11_dest.dta \
	../output/geoid11_home.dta \
	../output/geoid11_home_pair.dta \
	../output/geoid11_home_work.dta \
	../output/geoid11_work_pair.dta \
	../output/tract_2010_characteristics_est.dta \
	../output/tract_pairs_2010_characteristics_est.dta 

#####################
# Work section
#####################

all: $(stata_dta_symlinks) $(stata_dta_output)

../input/tractpairs.dta ../input/traveltime_gain_new_line.dta: ../input/%.dta : | ../input/%.dta.zip
	unzip $< -d ../input

$(stata_dta_symlinks): ../output/%.dta: | ../input/%.dta

$(stata_dta_output): tractpairs_characteristics.do tractpairs_characteristics.sbatch ../input/tracts.dta ../input/tractpairs.dta
	sbatch -W tractpairs_characteristics.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh

