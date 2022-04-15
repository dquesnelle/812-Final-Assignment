# Load packages
library(Biostrings)
library(ggplot2)
library(reshape2)
library(ape)

path = "./ALIGNMENT.fasta"

# Create a DNAMultipleAlignment object
DNAAlign <- readDNAMultipleAlignment(filepath = path,format = "fasta")

# Convert to a DNABin object
DNAAlignBin <- as.DNAbin(DNAAlign)

# Calculate and plot distance matrix
DNADM <- dist.dna(DNAAlignBin,model="K80")
DNADMmat <- as.matrix(DNADM)
PDat <- melt(DNADMmat)
ggplot(data = PDat, aes(x=Var1, y=Var2, fill=value))+
  geom_tile()
ggsave("DistanceMatrix.png")
# To do list
# 1. Change variable names
# 2. Change color scheme
# 3. Try different DM model