# Load packages
library(ape)
library(Biostrings)
library(dplyr)
library(ggplot2)
library(graphics)
library(gridExtra)
library(reshape2)

# Define path of alignment fasta
path = "./ALIGNMENT.fasta"

# Create a DNAMultipleAlignment object
DNAAlign <- readDNAMultipleAlignment(filepath = path,format = "fasta")

# Trim the names of sequences and rename
nameList <- DNAAlign@unmasked@ranges@NAMES
gsub("(\\w{0,}\\.\\d)(.+)","\\1",test)
for (i in 1:length(nameList)) {
  nameList[i] <- gsub("(\\w{0,}\\.\\d)(.+)","\\1",nameList[i])
}
DNAAlign@unmasked@ranges@NAMES <- nameList

# Convert to DNAMultipleAlignment a DNABin object
DNAAlignBin <- as.DNAbin(DNAAlign)

# Methods used and color scheme
Method = c("TS","TV","JC69","TN93","GG95","BH87","indel")
colorPalette = c("#fcfcfc","#c27ba0","#d9ead3","#ffc999","#d2b48c","#072e52")

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
dir.create("./DistMatPlot")
setwd("./DistMatPlot")

# Plot DM based on different models for comparison
pdf("DistMat(TS&TV).pdf", width = 9, height = 4)
DistMatTS <- plotDM(DNAAlignBin,Method[1],colorPalette)
DistMatTV <- plotDM(DNAAlignBin,Method[2],colorPalette)
grid.arrange(DistMatTS, DistMatTV, nrow = 1)
while (!is.null(dev.list()))  dev.off()

pdf("DistMat(JC69&TN93&GG95&BH87).pdf",width = 10,height = 9)
DistMatJC69 <- plotDM(DNAAlignBin,Method[3],colorPalette)
DistMatTN93 <- plotDM(DNAAlignBin,Method[4],colorPalette)
DistMatGG95 <- plotDM(DNAAlignBin,Method[5],colorPalette)
DistMatBH87 <- plotDM(DNAAlignBin,Method[6],colorPalette)
grid.arrange(DistMatJC69, DistMatTN93, DistMatGG95, DistMatBH87, nrow = 2, ncol = 2)
while (!is.null(dev.list()))  dev.off()

pdf("DistMat(Indel).pdf", width = 5, height = 4)
DistMatIndel <- plotDM(DNAAlignBin,Method[7],colorPalette)
DistMatIndel
while (!is.null(dev.list()))  dev.off()

# Return to previous dir
setwd("../")