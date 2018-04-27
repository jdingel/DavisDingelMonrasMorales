#!/bin/sh

#SBATCH --job-name=predvis_sixom_quick_version
#SBATCH --output=slurmlogs/predvis_sixom_quick_version_job_%A_%a.out
#SBATCH --error=slurmlogs/predvis_sixom_quick_version_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=broadwl
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=27
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##SIXOM 
list_race[1]=black
list_race+=(asian whithisp)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom mainspec
