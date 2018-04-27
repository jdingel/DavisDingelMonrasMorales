#!/bin/sh

#SBATCH --job-name=dissimilarity_bootstrap_plot
#SBATCH --output=slurmlogs/dissimilarity_bootstrap_plot.out
#SBATCH --error=slurmlogs/dissimilarity_bootstrap_plot.err
#SBATCH --partition=covert-dingel
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load stata
stata-se -e dissimilarity_bootstrap_plot.do
