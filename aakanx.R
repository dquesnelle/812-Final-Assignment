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

msaPrettyPrint(myFirstAlignment, output="tex")

###

install.packages("seqinr")

hemoSeq <- readDNAStringSet("test_sequences.fasta")
hemoAln <- msa(hemoSeq)

hemoAln2 <- msaConvert(hemoAln, type="seqinr::alignment")


library(seqinr)
d <- dist.alignment(hemoAln2, "identity")
as.matrix(d)[1:3, "HBA1_Homo_sapiens", drop=FALSE]

library(ape)
hemoTree <- nj(d)
plot(hemoTree, main="Phylogenetic Tree of Hemoglobin Alpha Sequences")

