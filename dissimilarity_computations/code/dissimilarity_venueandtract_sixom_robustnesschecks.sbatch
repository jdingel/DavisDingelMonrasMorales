#!/bin/sh

#SBATCH --job-name=dissim_sixom_robustnesschecks
#SBATCH --output=slurmlogs/dissim_sixom_robustnesschecks_job_%A_%a.out
#SBATCH --error=slurmlogs/dissim_sixom_robustnesschecks_job_%A_%a.err
#SBATCH --array=1-11
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

list_spec+=(lateadopt half fifth locainfo1 locainfo2 droploca disaggcuis carshare revchain 50 100)

module load julia/0.6.2
julia -p $SLURM_NTASKS dissimilarity_venueandtract_originmode_specification.jl sixom "${list_spec[$SLURM_ARRAY_TASK_ID]}"
