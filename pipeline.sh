# Run this script to run the overall project

# Retrieve nifh gene sequences
bash sequence_generator.sh 

# Run alignment on nifh sequences
bash ./2-MSA/msa.sh

# Filter out poorly aligned sequences
Python ratio_test.py

# Create distance matrix and phylogenetic tree
Rscript distrance_matrix_and_tree.R
