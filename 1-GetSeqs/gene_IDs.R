#! usr/bin/env Rscript


library(readr)
library(littler)

# The first step for the project is to gather sequences we want to align.
# The NCBI gene IDs of nifh genes from 100 species were collected in a csv file called nifh_accessions
# This function will read the csv file containing the NCBI gene IDs
# It will output all the gene IDs as integers for use in retrieving the sequences

get_gene_IDs = function(InputName) { 

  gene_IDs = read.csv(file =InputName) 
  
  ids = as.numeric(paste(gene_IDs$Gene_ID, sep = " "))

  return(ids)
}

args = commandArgs(trailingOnly = TRUE)
get_gene_IDs(args[1]) # here we define our parameters for the command line


