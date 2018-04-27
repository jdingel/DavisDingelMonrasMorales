#!/bin/sh

#SBATCH --job-name=simulate_estimator
#SBATCH --partition=covert-dingel
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=10g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e choicesetconstruction.do
bash tablerefiner.sh

