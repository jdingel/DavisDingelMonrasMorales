####################
# PROGRAMS
####################

PROGS=isoindex_programs.do

####################
# INPUT
####################

input=\
	../input/predictedvisits_whithisp_bsavg.csv \
	../input/predictedvisits_black_bsavg.csv \
	../input/predictedvisits_asian_bsavg.csv \
	../input/isolationindex_estsample.tex \
	../input/trips_est.dta \
	../input/users_est.dta \

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

output=\
	../output/isoindices_bsavg_ci.tex \
	../output/isoindices_bsavg.dta \
	../output/isoindices_bsavg.tex \
	../output/simulatedtrips_bsavg.dta \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(output): $(PROGS) $(input) isoindex_specs_bsavg.do run.sbatch tablerefiner.sh
	sbatch -W run.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
