#!/bin/bash

LIST_INSTANCES_1=`cat ../input/estimates_black_mainspec_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 1,100p| paste -d, -s`
LIST_INSTANCES_2=`cat ../input/estimates_black_mainspec_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 101,200p| paste -d, -s`
LIST_INSTANCES_3=`cat ../input/estimates_black_mainspec_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 201,300p| paste -d, -s`
LIST_INSTANCES_4=`cat ../input/estimates_black_mainspec_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 301,400p| paste -d, -s`
LIST_INSTANCES_5=`cat ../input/estimates_black_mainspec_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 401,500p| paste -d, -s`

count=1

for i in $LIST_INSTANCES_1 $LIST_INSTANCES_2 $LIST_INSTANCES_3 $LIST_INSTANCES_4 $LIST_INSTANCES_5
do

echo "#!/bin/bash
#SBATCH --job-name=isoindex_bootstrap_$count
#SBATCH --output=slurmlogs/isoindex_bootstrap_$count_%A_%a.out
#SBATCH --error=slurmlogs/isoindex_bootstrap_$count_%A_%a.err
#SBATCH --array=${i}
#SBATCH --time=28:00:00
#SBATCH --partition=covert-dingel
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=2g
#SBATCH --mail-type=END,FAIL

######################

# Begin work section #

######################

##Each instance takes about 2h15m
# Do some work based on the SLURM_ARRAY_TASK_ID

module load stata
stata-se -e bootstrap_isoindex.do \$SLURM_ARRAY_TASK_ID 100 \$SLURM_ARRAY_TASK_ID
"> run_array_$count.sbatch

count=`expr $count + 1`

done


