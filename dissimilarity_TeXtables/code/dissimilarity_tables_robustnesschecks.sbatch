#!/bin/sh

#SBATCH --job-name=dissim_table_robustnesschecks
#SBATCH --output=slurmlogs/dissim_table_robustnesschecks_job.out
#SBATCH --error=slurmlogs/dissim_table_robustnesschecks_job.err
#SBATCH --time=00:10:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia dissimilarity_tables_robustnesschecks.jl
