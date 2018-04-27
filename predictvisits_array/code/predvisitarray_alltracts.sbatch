#!/bin/sh

#SBATCH --job-name=predvisitarray
#SBATCH --output=slurmlogs/predvisitarray_job.out
#SBATCH --error=slurmlogs/predvisitarray_job.err
#SBATCH --time=02:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=9
#SBATCH --mem-per-cpu=16g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisitarray_alltracts.jl
