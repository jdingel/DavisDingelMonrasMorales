#!/bin/sh

#SBATCH --job-name=YelpvsDOHMH
#SBATCH --partition=covert-dingel
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=2g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e venues_YelpvsDOHMH.do
