#!/bin/sh

#SBATCH --job-name=dissim_residential
#SBATCH --output=slurmlogs/dissim_residential_job.out
#SBATCH --error=slurmlogs/dissim_residential_job.err
#SBATCH --time=00:10:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia dissimilarity_residential_calls.jl
