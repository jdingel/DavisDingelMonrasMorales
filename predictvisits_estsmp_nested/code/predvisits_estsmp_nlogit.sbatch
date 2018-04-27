#!/bin/sh

#SBATCH --job-name=predictvisits_estsmp_nlogit
#SBATCH --output=slurmlogs/predictvisits_estsmp_nlogit_job_%A_%a.out
#SBATCH --error=slurmlogs/predictvisits_estsmp_nlogit_job_%A_%a.err
#SBATCH --array=1-12
#SBATCH --time=02:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=12g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_race[1]=black
list_originmode[1]=sixom
list_nestid[1]=1

list_race+=(black black black)
list_originmode+=(sixom mintime mintime)
list_nestid+=(2 1 2)

list_race+=(asian asian asian asian)
list_originmode+=(sixom sixom mintime mintime)
list_nestid+=(1 2 1 2)

list_race+=(whithisp whithisp whithisp whithisp)
list_originmode+=(sixom sixom mintime mintime)
list_nestid+=(1 2 1 2)

module load julia/0.6.2
julia predvisits_estsmp_nlogit.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" "${list_originmode[$SLURM_ARRAY_TASK_ID]}" "${list_nestid[$SLURM_ARRAY_TASK_ID]}"
