#! /usr/bin/env Rscript

library(ggplot2)

length <- read.delim(file = "/data/users/tgallagh/EE282project/data/processed/assembly_length.txt", header=FALSE)
gc <- read.delim(file = "/data/users/tgallagh/EE282project/data/processed/assembly_gc.txt", header = FALSE)

#Sequence length distrubution
png(filename="/data/users/tgallagh/EE282project/output/figures/assembly_length.png")
x <- ggplot(aes(x=V1), data=log10(length))
x + geom_histogram() +
  xlab("log 10 of seq length")
dev.off()

#Sequence gc distrubution 
png(filename="/data/users/tgallagh/EE282project/output/figures/assembly_gc.png")
m <- ggplot(aes(x = V1), data=gc)
m + geom_histogram() + xlab("GC percentage")
dev.off()