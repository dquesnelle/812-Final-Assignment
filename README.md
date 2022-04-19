# 812-Final-Assignment

##### To run entire script see pipeline.sh

### Part 1: Sequence Retrieval
1. NCBI gene IDs for 100 *nifH* genes were gathered in nifh_accessions.csv
2. gene_IDs.R isolated the gene IDs in integer form.
3. Gene IDs were copied and pasted into the loop object of gene_id_parser.sh
4. gene_id_parser.sh retrieved the gene sequences for each gene ID and put them in a fasta file called nifh_sequences1.fasta. For pipeline see: sequence_generator.sh

### Part 2: Multiple Sequence Alignment
1. msa.R produced a multiple sequence alignment out.fasta by taking nifh_sequences1.fasta as input
2. The MView program was used to produce visualizations in [figure1.html](https://aakanx.github.io/temp/figure1.html) and [figure2.html](https://aakanx.github.io/temp/figure2.html)

### Part 3: Calculating the distance matrix and contructing a phylogenetic tree
1. take the out.fasta file and filter out sequences with >60% identity to create DMinput.fasta 
2. use DMinput.fasta to calculate the distance matrix and construct and phylogenetic tree using distance_matrix_and_tree.r
3. output after running distance_matrix_and_tree.r will be a folder with four pdfs: DistMat(indel).pdf, DistMat(JC69&K80&K81&TN93).pdf, and DistMat(TS&TV).pdf to show the distance matrix and Rplots.pdf to show the phylogenetic tree 
