#!/bin/sh

#SBATCH --job-name=estarrays_DTAs
#SBATCH --partition=covert-dingel
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e estarrays_DTAs.do
