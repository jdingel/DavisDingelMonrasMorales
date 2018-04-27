####################
# INPUT
####################

stata_dta=\
	../input/users_est.dta  \
	../input/trips_est.dta \
	../input/isoindices_sixom_mainspec.dta \

predictedvisits_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/predictedvisits_asian_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predictedvisits_bootstrap+=$(shell awk -F,  '{print $$5}' ../input/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/predictedvisits_black_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")
predictedvisits_bootstrap+=$(shell awk -F,  '{print $$5}' ../input/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../input/predictedvisits_whithisp_mainspec_"$$0'|awk '$$0=$$0".csv"'| tr "\n" " ")

####################
# OUTPUT
####################

slurm_files=\
	run_array_1.sbatch \
	run_array_2.sbatch \
	run_array_3.sbatch \
	run_array_4.sbatch \
	run_array_5.sbatch \

folders_and_symlinks=create_folders_and_symlinks.txt

isoindices_bootstrap=$(shell awk -F,  '{print $$5}' ../input/estimates_black_mainspec_bootstrap_clean.csv |  awk "NR > 1"|sort -u|sort -n|sed -n 1,500p| awk '$$0 = "../output/isoindices_"$$0'|awk '$$0=$$0".dta"'| tr "\n" " ")

isoindices_bootstrap_all=../output/isoindices_1to500.dta

figure=../output/isoindices_p5p95distros.pdf

output_all=$(isoindices_bootstrap)
output_all+=$(isoindices_bootstrap_all)
output_all+=$(figure)

#####################
# Work section
#####################

all: $(folders_and_symlinks) $(slurm_files) $(output_all)

$(folders_and_symlinks): create_folders_and_symlinks.sh
	-bash 	create_folders_and_symlinks.sh
	@echo "">create_folders_and_symlinks.txt

$(slurm_files): gen_array_jobs.sh
	bash gen_array_jobs.sh

$(output_all): $(stata_dta) $(predictedvisits_bootstrap) $(slurm_files) bootstrap_isoindex.do bootstrap_isoindex_programs.do gather_bootstrapped_isoindices.do run_final.sbatch
	sbatch -W run_array_1.sbatch
	sbatch -W run_array_2.sbatch
	sbatch -W run_array_3.sbatch
	sbatch -W run_array_4.sbatch
	sbatch -W run_array_5.sbatch
	sbatch -W run_final.sbatch

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
