#!/bin/sh

#SBATCH --job-name=predvis_sixom_other
#SBATCH --output=slurmlogs/predvis_sixom_other_job_%A_%a.out
#SBATCH --error=slurmlogs/predvis_sixom_other_job_%A_%a.err
#SBATCH --array=1-33
#SBATCH --partition=broadwl
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=27
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##SIXOM (33 elements)
list_race[1]=black
list_spec[1]=lateadopt

list_race+=(black black black black black black black black black black)
list_spec+=(half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

list_race+=(asian asian asian asian asian asian asian asian asian asian asian)
list_spec+=(lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

list_race+=(whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp)
list_spec+=(lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom "${list_spec[$SLURM_ARRAY_TASK_ID]}"
