#!/bin/sh

#SBATCH --job-name=Textable
#SBATCH --output=slurmlogs/Textable.out
#SBATCH --error=slurmlogs/Textable.err
#SBATCH --time=00:10:00
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=500
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia tables_FE_calls.jl
