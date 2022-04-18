Rscript ./2-MSA/msa.R "nifh_sequences1.fasta" "out.fasta" # arguments are infile and outfile

# for testing, use next line:
# Rscript ./2-MSA/msa.R "./test-files/test_sequences.fasta" "./test-files/testout.fasta"

# get Perl https://www.perl.org/get.html and make sure it is added to PATH
# get MView https://desmid.github.io/mview/index.html#installation and make sure it is added to PATH
# restart computer for PATH to be updated in R
# check R PATH by writing in R console: Sys.getenv("PATH")
# this part was done on Windows, which is why the batch file version of mview is used
mview.bat -in fasta -width 100 -html head -bold -css on -coloring identity -moltype dna ./2-MSA/out.fasta > ./2-MSA/figure1.html
  # -in fasta: input format
  # -width 100: 100 bp per line shown
  # -html head: output to html file
  # -bold: bold letters
  # -css on: coloured letter backgrounds
  # -coloring identity: coloured with respect to identity/match with reference sequence
  # -moltype dna: colouring by pyrimidines, purines
  # first sequence in file is reference sequence by default
mview.bat -in fasta -width 100 -html head -bold -css on -coloring mismatch -colormap red -ref 32 -sort pid ./2-MSA/out.fasta > ./2-MSA/figure2.html
  # -in fasta: input format
  # -width 100: 100 bp per line shown
  # -html head: output to html file
  # -bold: bold letters
  # -css on: coloured letter backgrounds
  # -coloring mismatch: coloured with respect to mismatches from reference sequence
  # -ref 32: selecting 32 (S meliloti 2011) as reference sequence 



### failed attempts

# cp aligned.tex "C:/Users/aakan/Desktop/tex/New folder/aligned.tex"
# rm -r ./out
# mkdir ./out
# cp ./aligned.tex ./out/aligned.tex
# cd ./out
# pdflatex aligned.tex
# keep pressing enter
# cd ..
