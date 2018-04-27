#!/bin/sh

#SBATCH --job-name=predictvisits_estsmp_betabsavg
#SBATCH --time=2:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=8g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia predictvisits_estsmp_betabsavg.jl
