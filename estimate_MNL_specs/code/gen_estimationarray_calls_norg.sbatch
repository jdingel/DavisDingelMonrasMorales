#!/bin/bash

#SBATCH --job-name=estarray_norg
#SBATCH --output=slurmlogs/estarray_norg_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_norg_job_%A_%a.err
#SBATCH --array=1-9
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=3g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

## (9 elements)
list_race[1]=black
list_norg[1]=2

list_race+=(black black asian asian asian whithisp whithisp whithisp)
list_norg+=(4 6 2 4 6 2 4 6)

module load julia/0.6.2
julia gen_estimationarray_calls_norg.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" "${list_norg[$SLURM_ARRAY_TASK_ID]}"
