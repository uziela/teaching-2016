#!/bin/bash

# Written by Karolis Uziela in 2016

if [ $# != 1 ] ; then
    echo "
Usage: 

$0 [Parameters]

Parameters:
<input-dir>

"
    exit 1
fi

input_dir=$1

files_per_node=16
extension=".txt"

# Run pconsc
a=0
b=0
input_files=""
for i in $input_dir/*$extension ; do
    let a=$a+1
    let "b=$a % $files_per_node"
    input_files="$input_files $i"
    if [ "$b" == "0" ] ; then
        #echo $input_files
        sbatch scripts/gamma-run-psiblast.sh "$input_files" 
        input_files=""
    fi
done

if [ "$b" != "0" ] ; then
    #echo $input_files
    sbatch scripts/gamma-run-psiblast.sh "$input_files"
fi
