#!/bin/sh

#SBATCH --job-name=Textable
#SBATCH --output=slurmlogs/Textable_job.out
#SBATCH --error=slurmlogs/Textable_job.err
#SBATCH --time=0:10:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=1g
#SBATCH --mail-type=END,FAIL

module load julia/0.6.2

julia tables_MNL_specs.jl
