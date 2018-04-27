#!/bin/sh

#SBATCH --job-name=estarray_Taddy
#SBATCH --output=slurmlogs/estarray_Taddy_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_Taddy_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --time=2:00:00
#SBATCH --partition=bigmem2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=50g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia gen_estimationarray_Taddy_calls.jl "${list_race[$SLURM_ARRAY_TASK_ID]}"
