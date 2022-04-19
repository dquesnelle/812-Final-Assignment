# Load packages
if (!require("BiocManager", quietly = TRUE))
  install.packages('BiocManager', repos='http://cran.us.r-project.org')
if (!require("Biostrings", quietly = TRUE))
  BiocManager::install("Biostrings")
if (!require("gridExtra", quietly = TRUE))
  install.packages('gridExtra', repos='http://cran.us.r-project.org')
if (!require("reshape2", quietly = TRUE))
  install.packages('reshape2', repos='http://cran.us.r-project.org')
library(ape)
library(Biostrings)
library(dplyr)
library(ggplot2)
library(graphics)
library(gridExtra)
library(reshape2)

# Define path of alignment fasta
args <- commandArgs(trailingOnly = TRUE)

# Create a DNAMultipleAlignment object
DNAAlign <- readDNAMultipleAlignment(filepath = "/Users/isabellaasselstine/Desktop/DMinput.fasta",format = "fasta")

g# Trim the names of sequences and rename
nameList <- DNAAlign@unmasked@ranges@NAMES
for (i in 1:length(nameList)) {
  nameList[i] <- paste(i,gsub("(\\S*)(\\s)(\\w+)(\\s)(\\w+)(.*)","\\3\\4\\5",nameList[i]),collapse = " ")
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
dir.create("./3-DistMatPhylo")
setwd("./3-DistMatPhylo")

# Plot DM based on different models for comparison
pdf("DistMat(TS&TV).pdf", width = 30, height = 15)
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

pdf("DistMat(Indel).pdf", width = 15, height = 15)
DistMatIndel <- plotDM(DNAAlignBin,Method[7],colorPalette)
DistMatIndel
while (!is.null(dev.list()))  dev.off()

# Using the distance matrix to contruct a phylogenetic tree 

# Installing ggtree
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree", force=TRUE)

# Defining the distance matrix object 

phylogeny <- dist.dna(DNAAlignBin,model="K80") %>% as.matrix

# Defining the tree and checking it looks good 
Tree = nj(phylogeny)
str(Tree)
class(Tree)

# Making and saving the tree
library(ggtree)
pdf("Phylogeny.pdf", width=30,height=32)
ggtree(Tree, branch.length="none", layout="circular")  + geom_tiplab()
dev.off()

# Return to previous dir
setwd("../")
