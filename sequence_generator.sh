# Get NCBI gene IDs from csv file 
Rscript gene_IDs.r "nifh_accessions.csv" 

# Copy and paste gene IDs into loop in gene_id_parser.sh

# Retrieve gene sequences using gene IDs
bash gene_id_parser.sh