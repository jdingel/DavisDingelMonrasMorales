#!/bin/sh

#SBATCH --job-name=estarrays_venueFE_Taddy_DTAs
#SBATCH --time=3:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=16g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load stata
stata-se estarrays_venueFE_Taddy_DTAs.do

	