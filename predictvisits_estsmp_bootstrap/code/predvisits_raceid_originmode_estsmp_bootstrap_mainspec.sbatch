#!/bin/sh

#SBATCH --job-name=predictvisits_estsmp_bootstap_mainspec
#SBATCH --output=slurmlogs/predictvisits_estsmp_bootstrap_mainspec_job_%A_%a.out
#SBATCH --error=slurmlogs/predictvisits_estsmp_bootstrap_mainspec_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --time=10:00:00
#SBATCH --partition=bigmem2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_estsmp_bootstrap.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" mainspec
