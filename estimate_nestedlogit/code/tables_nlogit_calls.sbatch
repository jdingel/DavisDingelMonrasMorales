#!/bin/sh

#SBATCH --job-name=Textable
#SBATCH --output=slurmlogs/Textable.out
#SBATCH --error=slurmlogs/Textable.err
#SBATCH --time=15:00
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia tables_nlogit_calls.jl
