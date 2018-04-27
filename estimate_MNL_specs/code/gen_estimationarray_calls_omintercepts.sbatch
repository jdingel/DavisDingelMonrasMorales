#!/bin/bash

#SBATCH --job-name=estarray_omintercepts
#SBATCH --output=slurmlogs/estarray_omintercepts_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_omintercepts_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=3g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

## (3 elements)
list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia gen_estimationarray_calls_omintercepts.jl "${list_race[$SLURM_ARRAY_TASK_ID]}"
