#!/bin/sh

#SBATCH --job-name=dissim_cftl
#SBATCH --output=slurmlogs/dissim_cftl_job_%A_%a.out
#SBATCH --error=slurmlogs/dissim_cftl_job_%A_%a.err
#SBATCH --array=1-3
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_cftl[1]=socialchange
list_cftl+=(2ndAve slowdown)

module load julia/0.6.2
julia -p $SLURM_NTASKS dissimilarity_venueandtract_originmode_specification_cftl.jl sixom mainspec "${list_cftl[$SLURM_ARRAY_TASK_ID]}"
