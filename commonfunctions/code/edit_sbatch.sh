#!/bin/bash

edit_sbatch_files (){
	sed -i.bak "s/^#SBATCH --partition=.*/#SBATCH --partition=$1/g" $2 && rm $2.bak
}

read -p "Please indicate the partition to perform this task: " user_partition
read -p "Please indicate the list of files using this partition: " list_files

for i in $list_files 
do
	edit_sbatch_files ${user_partition} ${i}
done 