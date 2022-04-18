# how to setup everything with GitHub:
# clone GitHub repo from webpage, download GitHub Desktop
# open in RStudio through GitHub Desktop
# top right of RStudio, New Project, Existing Directory (everything you just cloned)

print("test")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("msa", force = TRUE)
library(msa)

seqs <- readDNAStringSet("test_sequences.fasta")
aligned <- msa(seqs)

# alignment2fasta is adapted from https://stackoverflow.com/questions/48218332/how-to-output-results-of-msa-package-in-r-to-fasta
alignment2fasta <- function(alignment, filename) {
  sink(filename)
  for(i in 1:length(rownames(alignment))) {
    cat(paste0('>', rownames(alignment)[i])) # sep = "" in paste0() by default, whereas sep = " " in paste()
    cat('\n')
    the.sequence <- toString(unmasked(alignment)[[i]])
    cat(the.sequence)
    cat('\n')
  }
  sink(NULL)
}
alignment2fasta(aligned, 'out.fasta')

# use MView for visualization through .sh script

for (i in 1:3) {
  print(i)
}


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

mySequenceFile <- system.file("examples", "exampleAA.fasta", package="msa")
mySequences <- readAAStringSet(mySequenceFile)
mySequences

myFirstAlignment <- msa(mySequences)
myFirstAlignment

print(myFirstAlignment, show="complete")

msaPrettyPrint(myFirstAlignment, output="pdf", showNames="none", showLogo="none", askForOverwrite=FALSE, verbose=FALSE)
msaPrettyPrint(myFirstAlignment, y=c(164, 213), output="asis", showNames="none", showLogo="none", askForOverwrite=FALSE)

install.packages("seqinr")

hemoSeq <- readDNAStringSet("test_sequences.fasta")
hemoAln <- msa(hemoSeq)

hemoAln2 <- msaConvert(hemoAln, type = "seqinr::alignment")


library(seqinr)
d <- dist.alignment(hemoAln2, "identity")
as.matrix(d)[1:3, "HBA1_Homo_sapiens", drop = FALSE]

library(ape)
hemoTree <- nj(d)
plot(hemoTree, main = "Phylogenetic Tree of Hemoglobin Alpha Sequences")


library(devtools)
devtools::install_github("vragh/seqvisr", build_manual = TRUE, build_vignettes = TRUE)
