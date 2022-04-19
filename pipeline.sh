# Run this script to run the overall project

nifh_fasta="./1-GetSeqs/nifh_sequences1.fasta"
fasta_ori="./2-MSA/out.fasta" # naming alignment outfile
dm_path="./3-DistMatPhylo/DMinput.fasta" # naming filtered alignment

# Retrieve nifH gene sequences
bash ./1-GetSeqs/sequence_generator.sh 

# Prepare multiple sequence alignment, visualize using MView
Rscript ./2-MSA/msa.R $nifh_fasta $fasta_ori
bash ./2-MSA/MView.sh $fasta_ori

# Filter out poorly aligned sequences
python ./3-DistMatPhylo/ratio_test.py $fasta_ori $dm_path

# Create distance matrix and phylogenetic tree
Rscript ./3-DistMatPhylo/distance_matrix_and_tree.R $dm_path
