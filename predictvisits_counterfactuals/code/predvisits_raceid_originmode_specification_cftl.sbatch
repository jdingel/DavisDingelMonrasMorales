#!/bin/sh

#SBATCH --job-name=predviscftl
#SBATCH --output=slurmlogs/predviscftl_job_%A_%a.out
#SBATCH --error=slurmlogs/predviscftl_job_%A_%a.err
#SBATCH --array=1-9
#SBATCH --partition=broadwl
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_cftl[1]=socialchange

list_race+=(black black asian asian asian whithisp whithisp whithisp)
list_cftl+=(2ndAve slowdown socialchange 2ndAve slowdown socialchange 2ndAve slowdown)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_specification_cftl.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom mainspec "${list_cftl[$SLURM_ARRAY_TASK_ID]}"
