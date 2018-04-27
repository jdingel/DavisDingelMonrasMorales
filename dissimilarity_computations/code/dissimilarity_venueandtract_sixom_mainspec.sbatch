#!/bin/sh

#SBATCH --job-name=dissim_sixom_mainspec
#SBATCH --output=slurmlogs/dissim_sixom_mainspec.out
#SBATCH --error=slurmlogs/dissim_sixom_mainspec.err
#SBATCH --partition=covert-dingel
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load julia/0.6.2
julia -p $SLURM_NTASKS dissimilarity_venueandtract_originmode_specification.jl sixom mainspec
