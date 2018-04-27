#!/bin/bash

#SBATCH --job-name=estimation_omintercepts
#SBATCH --output=slurmlogs/estimation_omintercepts_job_%A_%a.out
#SBATCH --error=slurmlogs/estimation_omintercepts_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=covert-dingel
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=3g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##home only (3 elements)
list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia estimation_calls_omintercepts.jl "${list_race[$SLURM_ARRAY_TASK_ID]}"
