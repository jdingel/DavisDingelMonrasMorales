#!/bin/bash

#SBATCH --job-name=bootstrap_estarrays_array
#SBATCH --output=j_%A_%a.out
#SBATCH --error=j_%A_%a.err
#SBATCH --array=1-451:50
#SBATCH --time=04:00:00
#SBATCH --partition=covert-dingel
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=8g
#SBATCH --mail-type=END,FAIL

######################
# Begin work section #
######################

module load stata
stata-se bootstrap_estarrays.do $SLURM_ARRAY_TASK_ID

