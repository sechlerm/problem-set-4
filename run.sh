#! usr/bin/env bash

data='/Users/marybethsechler/Desktop/GAW/Homework/problem-set-4/data'

#build index

gunzip $data/hg19.chr1.fa.gz


#bowtie2-build ref filename what you want output called

bowtie2-build $data/hg19.chr1.fa $data/hg19.chr1

#bowtie2 to set up the alignment

bowtie2 -x hg19.chr1 -U factorx.chr1.fq.gz \
|samtools sort -o factorx.sort.bam

bedtools genomecov -ibam factorx.sort.bam -g $data/hg19.chrom.sizes -bg > factorx.bg

bedGraphToBigWig factorx.bg $data/hg19.chrom.sizes factorx.bw

macs2 bdgpeakcall -i factorx.bg  -o factorxpeaks.bed

#bedtools getfasta -fi hg19.chr1.fa -bed factorxpeaks.bed -fo factorxpeak.fa


shuf factorxpeaks.bed | head -n 1000 > peaks.rand.1000.bed
bedtools getfasta -fi hg19.chr1.fa -bed peaks.rand.1000.bed -fo factorxpeak.1000.fa


meme factorxpeak.1000.fa -nmotifs 1 -maxw 20 -minw 8 -dna -maxsize 1000000