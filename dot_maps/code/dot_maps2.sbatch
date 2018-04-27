#!/bin/sh

#SBATCH --job-name=dot_maps_stata
#SBATCH --output=slurmlogs/dot_maps_stata_job.out
#SBATCH --error=slurmlogs/dot_maps_stata_job.err
#SBATCH --time=00:10:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se -e dot_maps.do
