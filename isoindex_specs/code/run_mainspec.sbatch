#!/bin/sh

#SBATCH --job-name=isoindex_specs
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=4g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se isoindex_specs_mainspec.do
bash tablerefiner_mainspec.sh
