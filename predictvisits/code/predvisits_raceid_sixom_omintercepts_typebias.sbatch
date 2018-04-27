#!/bin/sh

#SBATCH --job-name=predvis_omin
#SBATCH --output=slurmlogs/predvis_omin_job_%A_%a.out
#SBATCH --error=slurmlogs/predvis_omin_job_%A_%a.err
#SBATCH --array=1-6
#SBATCH --partition=broadwl
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=27
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_bias[1]=bias

#black users
list_race+=(black)
list_bias+=(nobias)

#asia users
list_race+=(asian asian)
list_bias+=(bias nobias)

#whithisp users
list_race+=(whithisp whithisp)
list_bias+=(bias nobias)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_sixom_omintercepts_typebias.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom "${list_bias[$SLURM_ARRAY_TASK_ID]}"
