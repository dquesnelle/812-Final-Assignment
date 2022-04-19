# Run this script to run the overall project
nifh_fasta="./nifh_sequences1.fasta"
fasta_ori="./2-MSA/out.fasta"
dm_path="./DMinput.fasta"

# Retrieve nifH gene sequences
bash sequence_generator.sh 

# Prepare multiple sequence alignment, visualize using MView
Rscript ./2-MSA/msa.R $nifh_fasta $fasta_ori
MView.sh $fasta_ori

# Filter out poorly aligned sequences
Python ratio_test.py $fasta_ori $dm_path

# Create distance matrix and phylogenetic tree
Rscript distance_matrix_and_tree.R $dm_path
