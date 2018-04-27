#!/bin/sh

#SBATCH --job-name=DGP_perm_shock
#SBATCH --output=slurmlogs/DGP_perm_shock_job.out
#SBATCH --error=slurmlogs/DGP_perm_shock_job.err
#SBATCH --time=2:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=10g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia DGP_permanent_shocks_calls.jl

