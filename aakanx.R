# how to setup everything with GitHub:
# clone GitHub repo from webpage, download GitHub Desktop
# open in RStudio through GitHub Desktop
# top right of RStudio, New Project, Existing Directory (everything you just cloned)

print("test")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("msa")

library(msa)

# system.file("tex", "texshade.sty", package="msa")

seqs <- readDNAStringSet("test_sequences.fasta"); seqs
aligned <- msa(seqs); print(aligned, show = "complete")

msaPrettyPrint(aligned, 
               output = "tex", 
               showNames = "none", 
               showLogo = "none", 
               showConsensus = "none", 
               showLegend = FALSE, 
               askForOverwrite = FALSE) # error, but .tex is usable

### pdf

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

# can always visualize on EMBL-EBI as well

### other stuff

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


