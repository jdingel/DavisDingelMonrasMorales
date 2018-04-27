#!/bin/bash

#SBATCH --job-name=estimation_raceblind
#SBATCH --output=slurmlogs/estimation_raceblind_job.out
#SBATCH --error=slurmlogs/estimation_raceblind_job.err
#SBATCH --partition=covert-dingel
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia estimation_calls_raceblind.jl
