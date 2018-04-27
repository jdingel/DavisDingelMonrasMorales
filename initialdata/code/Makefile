####################
# INPUT
####################

stata_dta_inputs = \
	../input/venues_alltripsstats.dta \
	../input/trips_nonloc.dta \
	../input/users_nonloc.dta \
	../input/tracts.dta \
	../input/dotmap_labels_bklyn.dta \
	../input/dotmap_labels_harlem.dta \
	../input/dotmap_zoomcuts.dta \
	../input/YelpvsDOHMH_ZIPs.dta \
	../input/geoid11_coords.dta \
	../input/observationallyequivalentvenuesdata.dta \
	../input/choiceset_all_posvis.dta \
	../input/tractpairs.dta \
	../input/users_est.dta \
	../input/choiceset_droploca.dta \
	../input/choiceset_homeonly.dta \
	../input/users_homeonlysample.dta \
	../input/trips_est.dta \
	../input/venues_est.dta \
	../input/choiceset_100.dta \
	../input/choiceset_50.dta \
	../input/choiceset_all.dta \
	../input/traveltime_gain_new_line.dta \
	../input/top_workplaces_5.dta 

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

####################
# dta files
####################

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

all: $(folders_and_symlinks) $(stata_dta_output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(stata_dta_output): $(stata_dta_inputs) $(stata_dta_inputs) tractpairs_characteristics.do tractpairs_characteristics.sbatch
	sbatch -W tractpairs_characteristics.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh

