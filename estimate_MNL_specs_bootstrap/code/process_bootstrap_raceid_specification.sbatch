#!/bin/sh

#SBATCH --job-name=process_bootstrap
#SBATCH --output=slurmlogs/process_bootstrap_job_%A_%a.out
#SBATCH --error=slurmlogs/process_bootstrap_job_%A_%a.err
#SBATCH --array=1-6
#SBATCH --partition=broadwl
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=500
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_specification[1]=mainspec

list_race+=(black asian asian whithisp whithisp)
list_specification+=(mintime mainspec mintime mainspec mintime)

module load julia/0.6.2
julia process_bootstrap_raceid_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" "${list_specification[$SLURM_ARRAY_TASK_ID]}" 
