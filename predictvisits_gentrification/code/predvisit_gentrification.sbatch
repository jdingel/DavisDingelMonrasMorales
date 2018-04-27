#!/bin/sh

#SBATCH --job-name=predvis_gentrification
#SBATCH --output=slurmlogs/predvis_gentrification_job.out
#SBATCH --error=slurmlogs/predvis_gentrification_job.err
#SBATCH --time=01:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia predvisit_gentrification.jl
