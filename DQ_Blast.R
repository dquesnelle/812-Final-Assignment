#!/usr/bin/env Rscript



Seq_Blast = function(InputName, E, OutputName) {

  library(BiocManager)
  #install("Biostrings")
  #install("annotate")
  library(seqinr)
  library(littler)
  library(dplyr)
  
  
  AA = readDNAStringSet(InputName) # Read test sequence
    
  AAblast = blastSequences(paste(AA), 
                           expect = E, 
                           as = 'data.frame') # Blast sequence to find similar sequences

  write.fasta(sequences = AAblast, 
              file.out = OutputName) # Write the blast result to a new fasta file for use in the alignment
  
}

#Seq_Blast("Mesorhizobium.fasta", 10, "testalign.fasta") # For testing purposes

args = commandArgs(trailingOnly = TRUE)
Seq_Blast(args[c(1, 2, 3)]) # here we define our parameters for the command line

