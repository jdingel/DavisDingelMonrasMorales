#!/bin/sh

#SBATCH --job-name=gen_sourcefiles_predvisits_gentrification_jld
#SBATCH --output=slurmlogs/gen_sourcefiles_job.out
#SBATCH --error=slurmlogs/gen_sourcefiles_job.err
#SBATCH --time=00:20:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=7g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia gen_sourcefiles_predvisits_gentrification_jld.jl
