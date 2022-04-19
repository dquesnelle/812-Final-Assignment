arguments <- commandArgs(trailingOnly = TRUE)
sequences <- arguments[1]
filename <- arguments[2]

# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("msa", force = TRUE)

library(msa)

alignment <- msa(readDNAStringSet(sequences), method = "ClustalW")
# readDNAStringSet() for converting fasta to DNAStringSet as input for msa()
# can also select ClustalOmega, Muscle as alignment tools

msa2fasta <- function(alignment, filename) {
  sink(filename) # divert output to filename
  for(i in 1:length(rownames(alignment))) {
    cat(paste0('>', rownames(alignment)[i]), "\n",
        toString(unmasked(alignment)[[i]]), "\n")
        # write description line, sep = "" in paste0() by default and sep = " " in paste()
        # convert sequence (DNAString object) in alignment to string object
  }
  sink(NULL) # end diversion to filename
}

msa2fasta(alignment, filename)