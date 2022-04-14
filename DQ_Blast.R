#!/usr/bin/env Rscript



Seq_Blast = function(InputName, E, OutputName) {

  library(BiocManager)
  #install("Biostrings")
  #install("annotate")
  library(seqinr)
  library(littler)
  library(dplyr)
  
  
  AA = readDNAStringSet(InputName) # Read test sequence
    
  AAblast = blastSequences(paste(AA), expect = E, as = 'data.frame') # Blast sequence to find similar sequences

  # Remove sequences so that only 1 per species is left
  ##First = grep("loti", AAblast$Hit_def)
  #Indivs = unique(AAblast$Hit_accession)
  #Indivs
  
  #grep(Indivs, AAblast)
  
  write.fasta(sequences = AAblast, 
              file.out = OutputName) # Write the individual sequences to a new fasta file for use in the alignment

  
  
}


Seq_Blast("Mesorhizobium.fasta", 10, "testalign.fasta")


args = commandArgs(trailingOnly = TRUE)
Seq_Blast(args[c(1, 2, 3)]) # here we define our FileName parameter to be used in the command line

