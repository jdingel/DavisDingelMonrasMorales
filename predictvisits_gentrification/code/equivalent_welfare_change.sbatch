#!/bin/sh

#SBATCH --job-name=equiv_welfare
#SBATCH --output=slurmlogs/equiv_welfare_job.out
#SBATCH --error=slurmlogs/equiv_welfare_job.err
#SBATCH --time=00:20:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia equivalent_welfare_change.jl
