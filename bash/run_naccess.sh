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

naccess_bin="/proj/wallner/users/x_bjowa/local/naccess/naccess"

cd $input_dir

for i in *.pdb ; do
    echo $naccess_bin $i
    $naccess_bin $i
done

echo_both "$script_name done."
