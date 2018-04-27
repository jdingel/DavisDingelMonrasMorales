#!/bin/bash

#SBATCH --job-name=isoindex_bootstrap_gather
#SBATCH --time=00:05:00
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=FAIL,END

module load stata
stata-se -e gather_bootstrapped_isoindices.do

