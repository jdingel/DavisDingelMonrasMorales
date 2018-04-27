####################
# INPUT
####################

stata_dta_inputs = \
	../input/tract_2010_characteristics_est.dta  \
	../input/geoid11_coords.dta  \
	../input/venues_est.dta  \
	../input/tract_pairs_2010_characteristics_est.dta

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output=\
	../output/gentrify_covars_Bedstuy.tex \
	../output/gentrify_covars_Bedstuy_preprocess.tex \
	../output/gentrify_covars_Harlem.tex \
	../output/gentrify_covars_Harlem_preprocess.tex \
	../output/gentrify_avgcovars_Bedstuy.dta \
	../output/gentrify_avgcovars_Harlem.dta \
	../output/tractpairs_Bedstuy.dta \
	../output/venues_Bedstuy.dta \
	../output/tracts_Bedstuy.dta \
	../output/gentrify_Bedstuy_manhattan.pdf \
	../output/gentrify_Bedstuy.pdf \
	../output/tractpairs_Harlem.dta \
	../output/venues_Harlem.dta \
	../output/tracts_Harlem.dta \
	../output/gentrify_Harlem_manhattan.pdf \
	../output/gentrify_Harlem.pdf


#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(stata_dta_inputs) gentrify_DTAs.do gentrify_DTAs_programs.do stats.do run.sbatch tablerefiner.sh
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
