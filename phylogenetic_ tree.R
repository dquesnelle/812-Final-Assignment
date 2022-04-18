if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

nameList <- DNAAlign@unmasked@ranges@NAMES
gsub("(\\w{0,}\\.\\d)(.+)","\\1")
for (i in 1:length(nameList)) {
  nameList[i] <- gsub("(\\w{0,}\\.\\d)(.+)","\\1",nameList[i])
}
DNAAlign@unmasked@ranges@NAMES <- nameList

DNAAlignBin <- as.DNAbin(DNAAlign)
BbDM <- dist.dna(DNAAlignBin,model="K80") %>% as.matrix
Tree = nj(BbDM)
str(Tree)
class(Tree)

library(ggtree)
ggtree(Tree, branch.length=3, layout="rectangular")  + geom_tiplab()
