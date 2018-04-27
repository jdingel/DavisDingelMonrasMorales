
julia_packages=julia_packages.txt

#####################
# Work section
#####################

all:  $(julia_packages)

$(julia_packages): install_julia_packages.jl install_julia_packages.sbatch
	sbatch -W install_julia_packages.sbatch
	@echo "">julia_packages.txt

edit_sbatch: edit_sbatch.sh
	-bash edit_sbatch.sh
