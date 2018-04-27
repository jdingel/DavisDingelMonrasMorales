#!/bin/sh

#SBATCH --partition=covert-dingel
#SBATCH --job-name=gentrify_DTAs
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=5g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e gentrify_DTAs.do
stata-se -e stats.do
stata-se -e maps.do
bash tablerefiner.sh
