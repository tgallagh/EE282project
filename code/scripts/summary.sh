#!/usr/bin/env bash
module load jje/jjeutils/0.1a 
module load jje/kent/2014.02.19 
module load R
module load perl

FILE=$1
touch /data/users/tgallagh/EE282project/data/processed/summary.txt

OUTPUT="/data/users/tgallagh/EE282project/data/processed/summary.txt"
echo "Summary of sequence information" > $OUTPUT 

echo . >> $OUTPUT 

#Basic sequence info. 
echo "The number of bases is:" $(grep -v "^>" $FILE | grep -o [A-Z]| wc -l) >> $OUTPUT ;
echo "The number of N's is:" $(grep -v "^>" $FILE | grep N -o | wc -l) >>  $OUTPUT ;
echo "The total number of sequences is:" $(grep -o -c "^>" $FILE) >> $OUTPUT ; 
echo . >> $OUTPUT
 
#Print the sequence information for bases < 100,000 base pairs 
bioawk -c fastx '{ if (length($seq) < 100000) { print(">"$name "\n" $seq) }}' $FILE \
| tee >(echo "The number of nucleotides in sequences with lengths <100,000 bp is:" $(grep -o [A-Z] | wc -l) >> $OUTPUT) \
| tee >(echo "The number of N's in sequences with lengths <100,000 bp is: " $(grep -v ">" | grep N -0 | wc -l)>> $OUTPUT) \
|echo "The number of sequences with lengths <100,000 bp is:" $(grep -o -c "^>") >> $OUTPUT

#Print the sequence information for bases > 100,000 base pairs 
bioawk -c fastx '{ if (length($seq) > 100000) { print(">"$name "\n" $seq) }}' $FILE \
| tee >(echo "The number of nucleotides in sequences with lengths >100,000 bp is:" $(grep -o [A-Z] | wc -l) >> $OUTPUT) \
| tee >(echo "The number of N's in sequences with lengths >100,000 bp is: " $(grep -v ">" | grep N -0 | wc -l)>> $OUTPUT) \
|echo "The number of sequences with lengths >100,000 bp is:" $(grep -o -c "^>") >> $OUTPUT

#CDF plot
faSize -detailed $FILE | sort -rnk 2,2 > /data/users/tgallagh/EE282project/data/processed/seq.sorted.sixes.txt &&
plotCDF /data/users/tgallagh/EE282project/data/processed/seq.sorted.sixes.txt /data/users/tgallagh/EE282project/output/figures/CDFplot.png


#GC contect in new .txt file for R 
bioawk -c fastx '{ print gc($seq) }' $FILE > /data/users/tgallagh/EE282project/data/processed/gc.txt ; 
#length in new .txt file for R 
bioawk -c fastx '{ print length($seq) }' $FILE > /data/users/tgallagh/EE282project/data/processed/length.txt 