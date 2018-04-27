#!/bin/sh

#SBATCH --job-name=predictvisits_estsmp_arrays
#SBATCH --time=0:30:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=2g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e predictvisits_estsmp_arrays.do
