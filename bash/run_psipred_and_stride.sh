#!/bin/bash

# Written by Karolis Uziela in 2015

script_name=`basename $0`

if [ $# != 1 ] ; then
    echo "
Usage: 

$script_name [Parameters]

Parameters:
<pdb-dir>

"
    exit 1
fi

input_dir=$1

echo_both "$script_name started with parameters: $*"

#count=`ls -1 $input_dir/*.txt 2>/dev/null | wc -l`

stride_bin="/proj/wallner/users/x_karuz/software/stride/stride"
dssp_bin="/proj/wallner/users/x_karuz/software/dssp/dssp-2.0.4-linux-amd64"

for i in $input_dir/*.pdb ; do
    $stride_bin $i >$i.stride
    $dssp_bin $i >$i.dssp
done

echo_both "$script_name done."
