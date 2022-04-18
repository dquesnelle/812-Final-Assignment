
# This script comes from the EDirect cookbook repository on Githib
# Link: https://github.com/NCBI-Hackathons/EDirectCookbook/blob/master/EDirect_Cookbook.txt

# The NCBI gene IDs from gene_IDs.R are copied and pasted into the for loop.
# For each gene ID, this script will find and retrieve the gene sequence.
# It will then paste this sequence into the file nifh_sequences1.fasta for use in the alignment.

for value in { 11970903  9742706  5144036  5411589 31573395 25012506 66135341 66132306 65565472 65097490 58027523 57209642 66686341 64294505 66558925 60795032 66379201 64336658 44996749 31489522 29419855 29418613 24886632  7271977 1479061 61599259 61514986 29763669  9735509  1475788 56451760 70914963 69754478 69732137 69525103 66895772 66892402 66478756 66432510 66344908 66343528 66149407 64067074 64021609 61614856 61428909 61055496 58409220 48977766 48977636 45960649 45960611 24876744 24863695 24846099 24822259 24801823  3624474 61408688 65304567 61408688 70906580 70583870 68876202 68377734 67488582 66643971 66566559 66429654 66392686 66392181 66144139 62372264 61929281 61929156 61283970 58726859 57504914 55820408 49323801 45960570 41607343 24873336 24862159 24829851 24826380 24809358 24790299  1451768 70363091 69043340 67488558 66686368 60431491 58788210 24824788 3625965 10981576 44086063 14654102}
do

efetch -db gene -id $value -format native -mode xml \
  | xtract -pattern Entrezgene-Set \
    -group Gene-commentary \
    -if Gene-commentary_type@value -equals "genomic" \
    -element Gene-commentary_accession, Gene-commentary_version \
    -block Gene-commentary_seqs \
    -element Seq-interval_from,Seq-interval_to,Na-strand@value \
  | awk 'BEGIN{FS="\t";OFS="\t"}{print $1"."$2,$3,$4,$5}' \
  | while read -r chrom start stop strand ; do 
    efetch -db nuccore -id $chrom -chr_start $start -chr_stop $stop -strand $strand -format fasta >> nifh_sequences1.fasta
    done
done    
  