# get Perl https://www.perl.org/get.html and make sure it is added to PATH
# get MView https://desmid.github.io/mview/index.html#installation and make sure it is added to PATH
# restart R for its PATH to be updated (or restart computer)
mview.bat -in fasta -width 100 -html head -bold -css on -coloring identity -moltype dna ./out.fasta > figure1.html; open figure1.html
mview.bat -in fasta -width 100 -html head -bold -css on -coloring mismatch -colormap red -ref 32 -sort pid ./out.fasta > figure2.html; open figure2.html

# can select "-ref 1" for reference sequence; 32 is S meliloti 2011



### failed attempts

# cp aligned.tex "C:/Users/aakan/Desktop/tex/New folder/aligned.tex"
# rm -r ./out
# mkdir ./out
# cp ./aligned.tex ./out/aligned.tex
# cd ./out
# pdflatex aligned.tex
# keep pressing enter
# cd ..