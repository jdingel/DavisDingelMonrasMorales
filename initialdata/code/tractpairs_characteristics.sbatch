#!/bin/sh

#SBATCH --job-name=tractpairs_characteristics
#SBATCH --time=4:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=4g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e tractpairs_characteristics.do

