#!/bin/sh

#SBATCH --job-name=estimationFE_sixom
#SBATCH --output=slurmlogs/estimationFE_sixom_job_%A_%a.out
#SBATCH --error=slurmlogs/estimationFE_sixom_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=32g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia estimation_FE_calls.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom
