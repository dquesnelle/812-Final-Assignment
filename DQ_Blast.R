#!/usr/bin/env Rscript

# This function will blast a sequence against the database and find similar sequences.
# There are 3 parameters to this function:
# 1. InputName: the name of the file containing the sequence to be blasted.
# 2. E: the expect value of the blast search, meaning how similar you want your sequences. 10 is std, greater = less similar.
# 3: OutputName: the name of the file the blast result will be output to.

Seq_Blast = function(InputName, E, OutputName) {

  library(BiocManager)
  #install("Biostrings") # these lines might mess with the command line
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

