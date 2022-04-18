arguments <- commandArgs(trailingOnly = TRUE)
sequences <- arguments[1]
filename <- arguments[2]

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("msa", force = TRUE)
library(msa)

alignment <- msa(readDNAStringSet(sequences), method = "ClustalW")
# fasta to DNAStringSet for msa()
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

# use MView for visualization through .sh script



### failed visualizations

# msaPrettyPrint(aligned, 
#                output = "pdf", 
#                showNames = "none", 
#                showLogo = "none", 
#                showConsensus = "none", 
#                showLegend = FALSE, 
#                askForOverwrite = FALSE) # error

# after running the previous lines
# this is what's working on Windows and makes a nicer .pdf
# download MiKTeX and TeXstudio (together as proTeXt https://ctan.org/pkg/protext)
# open myFirstAlignment.tex in TeXstudio and press the button "Build & View" or hit F5
# whatever files were involved in this process are in ./files right now
# everything doesn't have to be in R: we can try tex to pdf in shell, calling MiKTeX to make it happen!

# trying again
# needed to add following line in Sys.getenv("PATH") using Sys.setenv(PATH="...;...;...;___")
# C:\\Users\\aakan\\AppData\\Local\\Programs\\MiKTeX 2.9\\miktex\\bin\\x64
# run following two lines:
# oldPath <- Sys.getenv("PATH")
# Sys.setenv(PATH = paste(oldPath, "C:\\Users\\aakan\\AppData\\Local\\Programs\\MiKTeX 2.9\\miktex\\bin\\x64", sep = ";")); Sys.getenv("PATH")
# problem with pdflatex.exe


### examples in manual

# mySequenceFile <- system.file("examples", "exampleAA.fasta", package="msa")
# mySequences <- readAAStringSet(mySequenceFile)
# mySequences
# 
# myFirstAlignment <- msa(mySequences)
# myFirstAlignment
# 
# print(myFirstAlignment, show="complete")
# 
# msaPrettyPrint(myFirstAlignment, output="pdf", showNames="none", showLogo="none", askForOverwrite=FALSE, verbose=FALSE)
# msaPrettyPrint(myFirstAlignment, y=c(164, 213), output="asis", showNames="none", showLogo="none", askForOverwrite=FALSE)
# 
# install.packages("seqinr")
# 
# hemoSeq <- readDNAStringSet("test_sequences.fasta")
# hemoAln <- msa(hemoSeq)
# 
# hemoAln2 <- msaConvert(hemoAln, type = "seqinr::alignment")
# 
# 
# library(seqinr)
# d <- dist.alignment(hemoAln2, "identity")
# as.matrix(d)[1:3, "HBA1_Homo_sapiens", drop = FALSE]
# 
# library(ape)
# hemoTree <- nj(d)
# plot(hemoTree, main = "Phylogenetic Tree of Hemoglobin Alpha Sequences")