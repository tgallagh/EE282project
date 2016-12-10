#!/usr/bin/env bash
module load jje/jjeutils/0.1a
module load jje/kent/2014.02.19 
module load R

FILE=$1

touch /data/users/tgallagh/EE282project/data/processed/chromosome_summary.txt
OUTPUT="/data/users/tgallagh/EE282project/data/processed/chromosome_summary.txt"

echo "Chromosome summary" > $OUTPUT
echo "" >> $OUTPUT

bioawk -c gff '$seqname == "X" {print } ' < $FILE \
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome X are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '$seqname == "Y" {print } ' < $FILE \
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome Y are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '$seqname == "2L" {print } ' < $FILE\
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome 2L are:" $(sort -u -k10| wc -l) >> annotation_summary.txt

bioawk -c gff '$seqname == "2R" {print } ' < $FILE\
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome 2R are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '$seqname == "3L" {print } ' < $FILE\
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome 3L are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '$seqname == "3R" {print } ' < $FILE \
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome 3R are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '$seqname == "4" {print } ' < $FILE \
|bioawk -c gff '$feature == "gene" {print }' \
|echo "The number of genes in chromosome 4 are:" $(sort -u -k10| wc -l) >> $OUTPUT

bioawk -c gff '{print $feature }' < $FILE \
|sort \
| uniq -c | sort -rnk1,1 \
 > /data/users/tgallagh/EE282project/data/processed/total_features.txt

grep -o FBgn[0-9]* < $FILE | uniq -c | sort -n > /data/users/tgallagh/EE282project/data/processed/transcripts.txt

bioawk -c gff '$feature == "gene" {print}'< $FILE | awk '{print $5-$4}' | sort -n >  /data/users/tgallagh/EE282project/data/processed/gene_length.txt

 bioawk -c gff '$feature == "exon" {print}'<$FILE | awk '{print $5-$4}' | sort -n > /data/users/tgallagh/EE282project/data/processed/exon_length.txt

Rscript annotation_plots.R 
