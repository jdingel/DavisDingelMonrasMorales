#!/bin/sh

#SBATCH --job-name=compute_loglikelihood_observables_vs_FE
#SBATCH --output=slurmlogs/compute_loglikelihood_observables_vs_FE_job.out
#SBATCH --error=slurmlogs/compute_loglikelihood_observables_vs_FE_job.err
#SBATCH --time=01:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3
#SBATCH --mem-per-cpu=10g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia -p $SLURM_NTASKS compute_loglikelihood_observables_vs_FE.jl
