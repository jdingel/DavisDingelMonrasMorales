#!/bin/sh

#SBATCH --job-name=dot_maps_julia
#SBATCH --output=slurmlogs/dot_maps_julia_job.out
#SBATCH --error=slurmlogs/dot_maps_julia_job.err
#SBATCH --time=00:20:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2
julia -p $SLURM_NTASKS dot_maps.jl
