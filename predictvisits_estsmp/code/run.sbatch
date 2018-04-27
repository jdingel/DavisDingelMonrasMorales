#!/bin/sh

#SBATCH --job-name=predictvisits_estsmp
#SBATCH --time=2:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=20g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia predictvisits_estsmp.jl
