cd ./1-GetSeqs

# Get NCBI gene IDs from csv file 
Rscript gene_IDs.r "nifh_accessions.csv" 

# Install EDirect
sh -c "$(curl -fsSL ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"

# Copy and paste gene IDs into loop in gene_id_parser.sh. This has already been done.

# Retrieve gene sequences using gene IDs
bash gene_id_parser.sh

cd ..
