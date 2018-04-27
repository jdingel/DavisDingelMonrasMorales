#!/bin/bash

############################################
# Convert slurm files to local batch files 
############################################

NUM_CORES=

#Tasks that do not exploit array jobs
convert_sbatch_to_batch_nonarrayjobs (){
	sed -i.bak 's/module load/#module load/g' $1 && rm $1.bak
	sed -i.bak "s/\$SLURM_NTASKS/${NUM_CORES}/g" $1 && rm $1.bak
}

list_sbatch_nonarrayjobs=`find *.sbatch -type f ! -exec grep -q '\-\-array\=' {} \; -print`

for file in $list_sbatch_nonarrayjobs
do 
	cp ${file} ${file%.*}.sh
	convert_sbatch_to_batch_nonarrayjobs ${file%.*}.sh
done 

#Tasks using array jobs
list_sbatch_arrayjobs=`grep -rl "\-\-array\=" *.sbatch`

convert_sbatch_to_batch_arrayjobs (){
num1=`grep -o "#SBATCH \-\-array=\([0-9]*\)\-\([0-9]*\)" $1 | grep -oE "[0-9]+" | sed -n "1p"`
num2=`grep -o "#SBATCH \-\-array=\([0-9]*\)\-\([0-9]*\)" $1 | grep -oE "[0-9]+" | sed -n "2p"`

sed -i.bak "s/module load .*/for i in `seq $num1 $num2|tr '\n' ' '`;do/g" $1 && rm $1.bak
sed -i.bak 's/$SLURM_ARRAY_TASK_ID/${i}/g' $1 && rm $1.bak
sed -i.bak "s/\$SLURM_NTASKS/${NUM_CORES}/g" $1 && rm $1.bak
echo 'done'>> $1
}

for file in $list_sbatch_arrayjobs
do 
	cp ${file} ${file%.*}.sh
	convert_sbatch_to_batch_arrayjobs ${file%.*}.sh
done 

############################
# Modify Makefile
############################

create_local_Makefile (){
	sed -i.bak 's/sbatch -W/bash/g' $1 && rm $1.bak
	sed -i.bak 's/\.sbatch/.sh/g' $1 && rm $1.bak
}

create_local_Makefile Makefile




