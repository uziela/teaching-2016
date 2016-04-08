#! /bin/sh
#SBATCH -t 02-00:00:00
#SBATCH -J psiblast
#SBATCH -N 1
#SBATCH --exclusive
#SBATCH -A snic2015-10-12
#SBATCH --error=/proj/wallner/users/x_karuz/karolis-git-repos/teaching-2016/logs/psiblast.%j.err
#SBATCH --output=/proj/wallner/users/x_karuz/karolis-git-repos/teaching-2016/logs/psiblast.%j.log

input_files=$1

#run_all_external_bin="/proj/wallner/users/x_karuz/software/ProQ_scripts/bin/run_all_external.pl"
blast_bin="/proj/wallner/users/x_karuz/software/blast-2.2.26/bin/blastpgp"
uniref_db="/proj/wallner/users/x_karuz/data_sets/uniref/uniref90.fasta"

echo_both "`date`"
echo_both "psiblast for input files: $input_files"

for input in $input_files ; do
    $blast_bin -j 8 -d $uniref_db -i $input -o $input.blastpgp -Q $input.psi &>$input.log &
done

wait

echo_both "psiblast is done."
echo_both "`date`"
