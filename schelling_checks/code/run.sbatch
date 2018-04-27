#!/bin/sh

#SBATCH --job-name=schelling_checks
#SBATCH --time=00:05:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e schelling_isoindexelements.do
