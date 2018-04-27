#!/bin/bash

#SBATCH --job-name=estarray_sixom_standard2
#SBATCH --output=slurmlogs/estarray_sixom_standard2_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_sixom_standard2_job_%A_%a.err
#SBATCH --array=1-9
#SBATCH --partition=covert-dingel
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=8g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##SIXOM(9 elements)
list_race[1]=black
list_spec[1]=50

list_race+=(black asian asian whithisp whithisp)
list_spec+=(100 50 100 50 100)

list_race+=(black asian whithisp)
list_spec+=(disaggcuis disaggcuis disaggcuis)

module load julia/0.6.2
julia gen_estimationarray_calls_standard.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom "${list_spec[$SLURM_ARRAY_TASK_ID]}"
