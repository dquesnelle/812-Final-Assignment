print("test")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("msa")

library(msa)

system.file("tex", "texshade.sty", package="msa")

mySequences <- readDNAStringSet("test_sequences.fasta")
mySequences

myFirstAlignment <- msa(mySequences)
print(myFirstAlignment, show="complete")

msaPrettyPrint(myFirstAlignment, output="pdf", showNames="none",showLogo="none", askForOverwrite=FALSE, verbose=FALSE)

