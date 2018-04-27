#!/bin/sh

#SBATCH --job-name=prepare_tripdata
#SBATCH --output=slurmlogs/prepare_tripdata_job.out
#SBATCH --error=slurmlogs/prepare_tripdata_job.err
#SBATCH --time=01:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=END,FAIL

module load stata
stata-se prepare_tripdata.do

