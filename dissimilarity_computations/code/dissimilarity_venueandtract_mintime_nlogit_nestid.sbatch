#!/bin/sh

#SBATCH --job-name=dissim_nlogit_mintime
#SBATCH --output=slurmlogs/dissim_nlogit_mintime_job_%A_%a.out
#SBATCH --error=slurmlogs/dissim_nlogit_mintime_job_%A_%a.err
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

list_nestid[1]=1
list_nestid+=(2)

module load julia/0.6.2
julia -p $SLURM_NTASKS dissimilarity_venueandtract_originmode_nlogit_nestid.jl mintime "${list_nestid[$SLURM_ARRAY_TASK_ID]}"
