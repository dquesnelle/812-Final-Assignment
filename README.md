# 812-Final-Assignment

### Part 1: Sequence Retrieval
1. NCBI gene IDs for the nifh gene for 100 bacterial species were gathered in nifh_accessions.csv
2. gene_IDs.R isolated the gene IDs in integer form.
3. Gene IDs were copied and pasted into the loop object of gene_id_parser.sh
4. gen_ID_parser retrieved the gene sequences for each gene ID and put them in a fasta file called nifh_sequences1.fasta

For pipeline see: sequence_generator.sh

### Part 2: MSA 
(done within msa.sh at the moment... we could have an overall "script.sh" that itself calls each script in order from each part)
1. msa.R produced a multiple sequence alignment out.fasta by taking nifh_sequences1.fasta as input
2. The MView program was used to produce visualizations in figure1.html and figure2.html
