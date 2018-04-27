#!/bin/sh

#SBATCH --job-name=estarrays_JLDs_mainspec
#SBATCH --output=slurmlogs/estarrays_JLDs_mainspec_job_%A_%a.out
#SBATCH --error=slurmlogs/estarrays_JLDs_mainspec_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=bigmem2
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=14
#SBATCH --mem-per-cpu=10g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia -p $SLURM_NTASKS estarrays_JLDs_bootstrap_raceid_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" mainspec
