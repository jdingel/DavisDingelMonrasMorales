#!/bin/sh

#SBATCH --job-name=dissim_omin
#SBATCH --output=slurmlogs/dissim_ominjob_%A_%a.out
#SBATCH --error=slurmlogs/dissim_ominjob_%A_%a.err
#SBATCH --array=1-2
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_bias[1]=bias
list_bias+=(nobias)

module load julia/0.6.2
julia -p $SLURM_NTASKS dissimilarity_venueandtract_sixom_omintercepts_typebias.jl "${list_bias[$SLURM_ARRAY_TASK_ID]}"
