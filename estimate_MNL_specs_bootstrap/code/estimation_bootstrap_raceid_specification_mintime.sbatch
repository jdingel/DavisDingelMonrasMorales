#!/bin/sh

#SBATCH --job-name=estim_bootstrap_mintime
#SBATCH --output=slurmlogs/estim_bootstrap_mintime_job_%A_%a.out
#SBATCH --error=slurmlogs/estim_bootstrap_mintime_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=broadwl
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=5g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia -p $SLURM_NTASKS estimation_bootstrap_raceid_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" mintime
