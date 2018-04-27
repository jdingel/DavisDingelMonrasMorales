#!/bin/bash

#SBATCH --job-name=estarray_raceblind
#SBATCH --output=slurmlogs/estarray_raceblind_job.out
#SBATCH --error=slurmlogs/estarray_raceblind_job.err
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=8g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia gen_estimationarray_calls_raceblind.jl
