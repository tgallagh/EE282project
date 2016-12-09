#!/bin/bash
FILE=$1

#Basic sequence info. 
echo "The number of bases is: $(grep -v "^>" $FILE | grep -o [A-Z]| wc -l)" ;
echo "The number of N's is: $(grep -v "^>" $FILE | grep N -o | wc -l)" ;
echo "The total number of sequences is $(grep -o -c "^>" $FILE)" 

#GC contect in new .txt file for R 
bioawk -c fastx '{ print gc($seq) }' dmel-all-chromosome-r6.13.fasta > gc.txt ; 
 
#Print the sequence information for bases < 100,000 base pairs 
bioawk -c fastx '{ if (length($seq) < 100000) { print(">"$name "\n" $seq) }}' $FILE \
| tee >(echo "The number of nucleotides in sequences with lengths <100,000 bp is:" $(grep -o [A-Z] | wc -l) > summary.txt) \
| tee >(echo "The number of N's in sequences with lengths <100,000 bp is: " $(grep -v ">" | grep N -0 | wc -l)>> summary.txt) \
|echo "The number of sequences with lengths <100,000 bp is:" $(grep -o -c "^>") >> summary.txt


