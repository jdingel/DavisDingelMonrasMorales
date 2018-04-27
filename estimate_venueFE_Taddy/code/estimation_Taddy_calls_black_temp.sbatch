#!/bin/sh

#SBATCH --job-name=estimation_Taddy
#SBATCH --output=slurmlogs/estimation_Taddy_job_black_temp.out
#SBATCH --error=slurmlogs/estimation_Taddy_job_black_temp.err
#SBATCH --partition=broadwl
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=40g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia estimation_Taddy_calls.jl black
