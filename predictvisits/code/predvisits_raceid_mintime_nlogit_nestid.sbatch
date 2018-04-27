#!/bin/sh

#SBATCH --job-name=predvis_nlogit_mintime
#SBATCH --output=slurmlogs/predvis_nlogit_mintime_job_%A_%a.out
#SBATCH --error=slurmlogs/predvis_nlogit_mintime_job_%A_%a.err
#SBATCH --array=1-6
#SBATCH --partition=broadwl
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=27
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_nestid[1]=1

list_race+=(black asian asian whithisp whithisp)
list_nestid+=(2 1 2 1 2)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_nlogit_nestid.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" mintime "${list_nestid[$SLURM_ARRAY_TASK_ID]}"
