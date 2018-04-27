#!/bin/sh

#SBATCH --job-name=predvisarray_cftl
#SBATCH --output=slurmlogs/predvisarray_cftljob_%A_%a.out
#SBATCH --error=slurmlogs/predvisarray_cftljob_%A_%a.err
#SBATCH --array=1-2
#SBATCH --partition=covert-dingel
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=9
#SBATCH --mem-per-cpu=16g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################
list_cftl[1]=2ndAve
list_cftl+=(slowdown)

module load julia/0.6.2
julia -p $SLURM_NTASKS predvisitarray_alltracts_cftl.jl "${list_cftl[$SLURM_ARRAY_TASK_ID]}"
