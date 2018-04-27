####################
# INPUT
####################

stata_dta_inputs = \
	../input/trips_est.dta \
	../input/users_est.dta

predictedvisits_mainspec=\
	../input/predictedvisits_whithisp_mainspec.csv \
	../input/predictedvisits_black_mainspec.csv \
	../input/predictedvisits_asian_mainspec.csv \

predictedvisits_others =\
	../input/predictedvisits_whithisp_mintime.csv \
	../input/predictedvisits_whithisp_pooled.csv \
	../input/predictedvisits_black_mintime.csv \
	../input/predictedvisits_black_pooled.csv \
	../input/predictedvisits_asian_mintime.csv \
	../input/predictedvisits_asian_pooled.csv \
	../input/predictedvisits_asian_sixom_nlogit_nest1.csv \
	../input/predictedvisits_black_sixom_nlogit_nest1.csv \
	../input/predictedvisits_whithisp_sixom_nlogit_nest1.csv \
	../input/predictedvisits_asian_sixom_nlogit_nest2.csv \
	../input/predictedvisits_black_sixom_nlogit_nest2.csv \
	../input/predictedvisits_whithisp_sixom_nlogit_nest2.csv \

####################
# OUTPUT
####################

folders_and_symlinks=create_folders_and_symlinks.txt

folders_and_symlinks_quick_version=create_folders_and_symlinks_quick_version.txt

output_mainspec_1=\
	../output/isolationindex_estsample.tex \
	../output/simulatedtrips_mainspec.dta \
	../output/isoindices_sixom_mainspec.dta \
	../output/isoindices_sixom_mainspec.tex \

output_mainspec_2=../output/isoindices_sixom_mainspec_ci.tex

output_others_1=\
	../output/simulatedtrips_mintime.dta \
	../output/isoindices_mintime.dta \
	../output/isoindices_mintime.tex \
	../output/isoindices_sixom_pooled.dta \
	../output/isoindices_sixom_pooled.tex \
	../output/simulatedtrips_sixom_pooled.dta \
	../output/simulatedtrips_sixom_nest1.dta \
	../output/isoindices_sixom_nest1.dta \
	../output/isoindices_sixom_nest1.tex \
	../output/simulatedtrips_sixom_nest2.dta \
	../output/isoindices_sixom_nest2.dta \
	../output/isoindices_sixom_nest2.tex \

output_others_2=../output/isoindices_sixom_robustness_ci.tex \

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(output_mainspec_1) $(output_mainspec_2) $(output_others_1) $(output_others_2)

all_quick_version: 	$(folders_and_symlinks_quick_version) $(output_mainspec_1) $(output_mainspec_2)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(folders_and_symlinks_quick_version): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks_quick_version.txt
	
$(output_mainspec_1): $(stata_dta_inputs) $(predictedvisits_mainspec) isoindex_programs.do isoindex_specs_mainspec.do run_mainspec.sbatch
	sbatch -W run_mainspec.sbatch

$(output_mainspec_2): $(output_mainspec_1) tablerefiner_mainspec.sh
	bash tablerefiner_mainspec.sh

$(output_others_1): $(stata_dta_inputs) $(predictedvisits_others) isoindex_programs.do isoindex_specs_others.do run_others.sbatch
	sbatch -W run_others.sbatch

$(output_others_2): $(output_others_1) tablerefiner_others.sh
	bash tablerefiner_others.sh

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
