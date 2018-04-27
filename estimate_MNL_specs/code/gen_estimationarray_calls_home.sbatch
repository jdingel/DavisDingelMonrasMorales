#!/bin/bash

#SBATCH --job-name=estarray_home
#SBATCH --output=slurmlogs/estarray_home_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_home_job_%A_%a.err
#SBATCH --array=1-6
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=3g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##home only (6 elements)
list_race[1]=black
list_spec[1]=homeonly

list_race+=(black asian asian whithisp whithisp)
list_spec+=(homeonlysample homeonly homeonlysample homeonly homeonlysample)

module load julia/0.6.2
julia gen_estimationarray_calls_home.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" "${list_spec[$SLURM_ARRAY_TASK_ID]}"
