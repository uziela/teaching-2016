#!/bin/bash

# Written by Karolis Uziela in 2015

script_name=`basename $0`

if [ $# != 2 ] ; then
    echo "
Usage: 

$script_name [Parameters]

Parameters:
<input-dir>
<output-dir>

"
    exit 1
fi

input_dir=$1
output_dir=$2

echo_both "$script_name started with parameters: $*"

#count=`ls -1 $input_dir/*.txt 2>/dev/null | wc -l`

mkdir $output_dir

for i in $input_dir/*.txt ; do
    base=`basename $i`
    mid=`substr $base 2 5 | tr [a-z] [A-Z]`
    wget -P $output_dir http://www.rcsb.org/pdb/files/${mid}.pdb
done

echo_both "$script_name done."
