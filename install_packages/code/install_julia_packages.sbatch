#!/bin/sh

#SBATCH --job-name=install_julia_packages
#SBATCH --time=2:00:00
#SBATCH --partition=covert-dingel
#SBATCH --mem-per-cpu=1g
#SBATCH --nodes=1
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia install_julia_packages.jl
