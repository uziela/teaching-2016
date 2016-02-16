#!/usr/bin/env python

# Written by Karolis Uziela in 2015

import sys

################################ Usage ################################

script_name = sys.argv[0]

usage_string = """
Usage:

    %s [Parameters]
    
Parameters:

    <input-file> - input file
    <output-file-stride3>
    <output-file-stride7>
    <chain>
    <id>
""" % script_name

if len(sys.argv) != 6:
    sys.exit(usage_string)

################################ Functions ################################

def read_data(filename, chain, aa_dict):
    
    aa_seq = ""
    stride7_seq = ""
    stride3_seq = ""
    f = open(filename)
    
    while True:
        line = f.readline()
        if len(line) == 0: 
            break
        #line = line.rstrip('\n')
        if line[:3] == "ASG":
            if chain == "." or chain == "_" or chain == line[9]:
                #print line
                aa_three = line[5:8]
                if aa_three in aa_dict.keys():
                    aa_one = aa_dict[aa_three]
                else:
                    aa_one = "X"
                stride7 = line[24]
                if stride7 in stride_dict.keys():
                    stride3 = stride_dict[stride7]
                else:
                    stride3 = "C"
                #print stride7,stride3
                aa_seq += aa_one
                stride7_seq += stride7
                stride3_seq += stride3

        #print line
        #bits = line.split("\t")     
        
    f.close()
    return (aa_seq, stride7_seq, stride3_seq)
    
def write_data(output_file, out_str):
    f = open(output_file,"w")  
    #out_str = "%s %f \n" % str_var f_var
    f.write(out_str)    
    f.close()


################################ Variables ################################

# Input files/directories
input_file = sys.argv[1]

# Output files/directories
output_file_stride3 = sys.argv[2]
output_file_stride7 = sys.argv[3]

# Constants
chain = sys.argv[4]
seqid = sys.argv[5]

aa_dict  = {'ALA': 'A',
    'ARG': 'R',
    'ASN': 'N',
    'ASP': 'D',
    'CYS': 'C',
    'GLN': 'Q',
    'GLU': 'E',
    'GLY': 'G',
    'HIS': 'H',
    'ILE': 'I',
    'LEU': 'L',
    'LYS': 'K',
    'MET': 'M',
    'PHE': 'F',
    'PRO': 'P',
    'SER': 'S',
    'THR': 'T',
    'TRP': 'W',
    'TYR': 'Y',
    'VAL': 'V',
    'ASX': 'B',
    'GLX': 'Z',
    'XXX': 'A',
    'MSE': 'M',
    'FME': 'M',
    'PCA': 'E',
    '5HP': 'E',
    'SAC': 'S',
    'CCS': 'C'}
stride_dict = {"C": "C",
        "T": "C",
        "B": "C",
        "b": "C",
        "H": "H",
        "G": "H",
        "I": "H",
        "E": "S"}

# Global variables
# N/A

################################ Main script ################################
    
#sys.stderr.write("%s is running with arguments: %s\n" % (script_name, str(sys.argv[1:])))


(aa_seq, stride7_seq, stride3_seq) = read_data(input_file, chain, aa_dict)

out_str1 = ">" + seqid + "\n" + aa_seq + "\n" + stride3_seq + "\n"
out_str2 = ">" + seqid + "\n" + aa_seq + "\n" + stride7_seq + "\n"

write_data(output_file_stride3, out_str1)
write_data(output_file_stride7, out_str2)

#sys.stderr.write("%s done.\n" % script_name)



