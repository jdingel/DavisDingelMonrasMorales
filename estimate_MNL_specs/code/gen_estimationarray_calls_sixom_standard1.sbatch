#!/bin/bash

#SBATCH --job-name=estarray_sixom_standard1
#SBATCH --output=slurmlogs/estarray_sixom_standard1_job_%A_%a.out
#SBATCH --error=slurmlogs/estarray_sixom_standard1_job_%A_%a.err
#SBATCH --array=1-36
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=3g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

##SIXOM (27 elements)
list_race[1]=black
list_spec[1]=mainspec

list_race+=(black black black black black black black black)
list_spec+=(lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain)

list_race+=(asian asian asian asian asian asian asian asian asian)
list_spec+=(mainspec lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain)

list_race+=(whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp whithisp)
list_spec+=(mainspec lateadopt half fifth droploca locainfo1 locainfo2 carshare revchain)

##Specifications with spatial-frictions interaction (9 elements)
list_race+=(black asian whithisp black asian whithisp black asian whithisp)
list_spec+=(spatialage spatialage spatialage spatialgender spatialgender spatialgender spatialincome spatialincome spatialincome)

module load julia/0.6.2
julia gen_estimationarray_calls_standard.jl "${list_race[$SLURM_ARRAY_TASK_ID]}" sixom "${list_spec[$SLURM_ARRAY_TASK_ID]}"
