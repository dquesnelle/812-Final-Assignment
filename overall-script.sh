
# Install EDirect
sh -c "$(curl -fsSL ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"

# Retrieve gene sequences using gene IDs
bash gene_id_parser.sh

bash ./2-MSA/msa.sh
