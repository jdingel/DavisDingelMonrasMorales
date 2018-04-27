#!/bin/bash

for originmode in mainspec mintime
do

LIST_INSTANCES_1=`cat ../input/estimates/${originmode}/estimates_black_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 1,100p| paste -d, -s`
LIST_INSTANCES_2=`cat ../input/estimates/${originmode}/estimates_black_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 101,200p| paste -d, -s`
LIST_INSTANCES_3=`cat ../input/estimates/${originmode}/estimates_black_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 201,300p| paste -d, -s`
LIST_INSTANCES_4=`cat ../input/estimates/${originmode}/estimates_black_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 301,400p| paste -d, -s`
LIST_INSTANCES_5=`cat ../input/estimates/${originmode}/estimates_black_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 401,500p| paste -d, -s`

count=1

for i in $LIST_INSTANCES_1 $LIST_INSTANCES_2 $LIST_INSTANCES_3 $LIST_INSTANCES_4 $LIST_INSTANCES_5
do

echo "#!/bin/bash
#SBATCH --job-name=dissim_bootstrap_${originmode}
#SBATCH --output=slurmlogs/dissim_bootstrap_${originmode}_%A_%a.out
#SBATCH --error=slurmlogs/dissim_bootstrap_${originmode}_%A_%a.err
#SBATCH --array=${i}
#SBATCH --time=00:20:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=15g
#SBATCH --mail-type=END,FAIL

######################

# Begin work section #

######################

module load julia/0.6.2
julia -p \$SLURM_NTASKS dissimilarity_bootstrap.jl ${originmode} \$SLURM_ARRAY_TASK_ID
"> run_array_dissim_${originmode}_$count.sbatch

echo "#!/bin/bash
#SBATCH --job-name=dissim_bootstrap_${originmode}
#SBATCH --output=slurmlogs/dissim_bootstrap_${originmode}_%A_%a.out
#SBATCH --error=slurmlogs/dissim_bootstrap_${originmode}_%A_%a.err
#SBATCH --array=${i}
#SBATCH --time=00:20:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem-per-cpu=11g
#SBATCH --mail-type=END,FAIL

######################

# Begin work section #

######################

module load julia/0.6.2
julia -p \$SLURM_NTASKS dissimilarity_bootstrap.jl ${originmode} \$SLURM_ARRAY_TASK_ID
"> run_array_dissim_${originmode}_$count.sbatch
count=`expr $count + 1`

done
done
