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
for i in $input_dir/*txt ; do
    base=`basename $i .txt`
    mid=`substr $base 2 5 | tr [a-z] [A-Z]`
    mch=`substr $base 6 6 | tr [a-z] [A-Z]`
    if [[ $mch == "." || $mch == "_" ]] ; then
        echo ">$base" > $output_dir/$base.parsed.dssp8
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk '{print substr($0,14,1)}' | tr -d "\n" >> $output_dir/$base.parsed.dssp8
        echo >> $output_dir/$base.parsed.dssp8
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk '{print substr($0,17,1)}' | tr " " "C" | tr -d "\n" >> $output_dir/$base.parsed.dssp8
        echo >> $output_dir/$base.parsed.dssp8
        
        echo ">$base" > $output_dir/$base.parsed.dssp
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk '{print substr($0,14,1)}' | tr -d "\n" >> $output_dir/$base.parsed.dssp
        echo >> $output_dir/$base.parsed.dssp
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk '{print substr($0,17,1)}' | tr "CTSB " "C" | tr "HGI" "H" | tr "E" "S" | tr -d "\n" >> $output_dir/$base.parsed.dssp
        echo >> $output_dir/$base.parsed.dssp 
    else
        echo ">$base" > $output_dir/$base.parsed.dssp8
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,14,1)}}' | tr -d "\n" >> $output_dir/$base.parsed.dssp8
        echo >> $output_dir/$base.parsed.dssp8
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,17,1)}}' | tr " " "C" | tr -d "\n" >> $output_dir/$base.parsed.dssp8
        echo >> $output_dir/$base.parsed.dssp8
        
        echo ">$base" > $output_dir/$base.parsed.dssp
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,14,1)}}' | tr -d "\n" >> $output_dir/$base.parsed.dssp
        echo >> $output_dir/$base.parsed.dssp
        sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,17,1)}}' | tr "CTSB " "C" | tr "HGI" "H" | tr "E" "S" | tr -d "\n" >> $output_dir/$base.parsed.dssp
        echo >> $output_dir/$base.parsed.dssp
    fi
    #echo "my_dssp" > $output_dir/$base.parsed.verify1
    #sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,17,1)}}' | tr "CTS " "C" | tr "HGI" "H" | tr "EB" "S" >> $output_dir/$base.parsed.verify1
    #echo "my_dssp8" > $output_dir/$base.parsed.verify2
    #sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,17,1)}}' | tr " " "C" >> $output_dir/$base.parsed.verify2
    #echo "my_res" > $output_dir/$base.parsed.verify3
    #sed -n '/#  RESIDUE AA STRUCTURE/,$p' output/output-scop-pdb/${mid}.pdb.dssp | tail -n +2 | awk -v chain=$mch '{if (substr($0,12,1) == chain) {print substr($0,14,1)}}' >> $output_dir/$base.parsed.verify3

done

echo_both "$script_name done."
