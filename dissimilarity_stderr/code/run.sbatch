#!/bin/sh

#SBATCH --job-name=dissimilarity_stderr
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=4g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se dissimilarity_stderr.do
