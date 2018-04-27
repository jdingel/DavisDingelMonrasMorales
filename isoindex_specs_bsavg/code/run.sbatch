#!/bin/sh

#SBATCH --job-name=isoindex_specs_bsavg
#SBATCH --time=16:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=4g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se isoindex_specs_bsavg.do
bash tablerefiner.sh

