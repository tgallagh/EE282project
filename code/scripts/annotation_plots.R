library(ggplot2)

genelength <- read.delim(file = "/data/users/tgallagh/EE282project/data/processed/annotation_gene_length.txt", header=FALSE)

exonlength <- read.delim(file = "/data/users/tgallagh/EE282project/data/processed/annotation_exon_length.txt", header = FALSE)

transcriptlength <-read.delim(file = "/data/users/tgallagh/EE282project/data/processed/annotation_transcript_number.txt", sep = '', header=FALSE)

#gene length
png(filename="/data/users/tgallagh/EE282project/output/figures/annotation_gene_length.png")
x <- ggplot(aes(x=V1), data=log10(genelength))
x + geom_histogram() +
  xlab("log 10 of gene length")
dev.off()

#exon length distrubution
png(filename ="/data/users/tgallagh/EE282project/output/figures/annotation_exon_length.png")
m <- ggplot(aes(x = log10(V1)), data=exonlength)
m + geom_histogram() +
  xlab("log 10 of exon length")
dev.off()

#transcript length distrubution 
png(filename = "/data/users/tgallagh/EE282project/output/figures/annotation_transcript_number.png")
transcriptlength$V1 <- as.numeric(as.character(transcriptlength$V1))
g <- ggplot(aes(x=log10(V1)), data = transcriptlength)
g + geom_histogram() +
  xlab("log 10 of transcript length")
dev.off()
