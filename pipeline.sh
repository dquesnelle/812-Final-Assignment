# Run this script to run the overall project
nifh_fasta="./nifh_sequences1.fasta"
fasta_ori="./2-MSA/out.fasta"
dm_path="./DMinput.fasta"

# Retrieve nifh gene sequences
bash sequence_generator.sh 

# Run alignment on nifh sequences
bash ./2-MSA/msa.sh $nifh_fasta $fasta_ori

# Filter out poorly aligned sequences
Python ratio_test.py $fasta_ori $dm_path

# Create distance matrix and phylogenetic tree
Rscript distance_matrix_and_tree.R $dm_path
