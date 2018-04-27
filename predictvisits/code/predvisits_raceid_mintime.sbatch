#!/bin/sh

#SBATCH --job-name=predvis_mintime
#SBATCH --output=slurmlogs/predvis_mintime_job_%A_%a.out
#SBATCH --error=slurmlogs/predvis_mintime_job_%A_%a.err
#SBATCH --array=1-36
#SBATCH --partition=broadwl
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=27
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##mintime (36 elements)
list_race[1]=black
list_spec[1]=mainspec

list_race+=(black black black black black black black black black black black)
list_spec+=(lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

list_race+=(asian asian asian asian asian asian asian asian asian asian asian asian)
list_spec+=(mainspec lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

list_race+=(whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp)
list_spec+=(mainspec lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain disaggcuis 50 100)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisits_raceid_originmode_specification.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" mintime "${list_spec[$SLURM_ARRAY_TASK_ID]}"
