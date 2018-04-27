#!/bin/sh

#SBATCH --job-name=summarystats
#SBATCH --partition=covert-dingel
#SBATCH --time=0:25:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=2g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e frictions_kdensities.do
stata-se -e table1.do
stata-se -e tableA01.do
stata-se -e tableA02.do
