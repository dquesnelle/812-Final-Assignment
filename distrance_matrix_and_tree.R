# Load packages
library(ape)
library(Biostrings)
library(dplyr)
library(ggplot2)
library(graphics)
library(gridExtra)
library(reshape2)

# Define path of alignment fasta
path = "./DMinput.fasta"

# Create a DNAMultipleAlignment object
DNAAlign <- readDNAMultipleAlignment(filepath = path,format = "fasta")

# Trim the names of sequences and rename
nameList <- DNAAlign@unmasked@ranges@NAMES
for (i in 1:length(nameList)) {
  nameList[i] <- gsub("(\\w{0,}\\.\\d)(.+)","\\1",nameList[i])
}
DNAAlign@unmasked@ranges@NAMES <- nameList

# Convert to DNAMultipleAlignment a DNABin object
DNAAlignBin <- as.DNAbin(DNAAlign)

# Methods used and color scheme
Method = c("TS","TV","JC69","K80","K81","TN93","indel")
colorPalette = c("#fcfcfc","#c27ba0","#ffc999","#d2b48c","#4decec","#072e52")

# Define function to calculate and plot distance matrix
plotDM <- function(DNAbin,calMol,colorPal){
  PDat <- dist.dna(DNAbin,model=calMol) %>% as.matrix %>% melt
  DMPlot <- ggplot(data = PDat, aes(x=Var1, y=Var2, fill=value))+
    geom_tile()+ 
    scale_fill_gradientn(colours = colorPal)+
    theme(axis.text.x = element_text(angle = 90,hjust = 1,vjust = 0.5))+
    ggtitle(paste("Model = ", calMol))+
    theme(plot.title = element_text(hjust = 0.5))+
    xlab(NULL)+
    ylab(NULL)
  return(DMPlot)
}

# New dir for plots
dir.create("./DistMatAndPhyloPlot")
setwd("./DistMatAndPhyloPlot")

# Plot DM based on different models for comparison
pdf("DistMat(TS&TV).pdf", width = 30, height = 12)
DistMatTS <- plotDM(DNAAlignBin,Method[1],colorPalette)
DistMatTV <- plotDM(DNAAlignBin,Method[2],colorPalette)
grid.arrange(DistMatTS, DistMatTV, nrow = 1)
while (!is.null(dev.list()))  dev.off()

pdf("DistMat(JC69&K80&K81&TN93).pdf",width = 30,height = 27)
DistMatJC69 <- plotDM(DNAAlignBin,Method[3],colorPalette)
DistMatTN93 <- plotDM(DNAAlignBin,Method[4],colorPalette)
DistMatGG95 <- plotDM(DNAAlignBin,Method[5],colorPalette)
DistMatBH87 <- plotDM(DNAAlignBin,Method[6],colorPalette)
grid.arrange(DistMatJC69, DistMatTN93, DistMatGG95, DistMatBH87, nrow = 2, ncol = 2)
while (!is.null(dev.list()))  dev.off()

pdf("DistMat(Indel).pdf", width = 15, height = 12)
DistMatIndel <- plotDM(DNAAlignBin,Method[7],colorPalette)
DistMatIndel
while (!is.null(dev.list()))  dev.off()

##using the distance matrix to contruct a phylogenetic tree 

#installing ggtree
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

#defining the distance metrix object 
DNAAlignBin <- as.DNAbin(DNAAlign)
phylogeny <- dist.dna(DNAAlignBin,model="K80") %>% as.matrix

#defining the tree and checking it looks good 
Tree = nj(phylogeny)
str(Tree)
class(Tree)

#making and saving the tree
library(ggtree)
pdf(width=20,height=4)
ggtree(Tree, branch.length=3, layout="rectangular")  + geom_tiplab()
dev.off()

# Return to previous dir
setwd("../")



