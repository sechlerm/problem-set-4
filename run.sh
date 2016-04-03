#! usr/bin/env bash

data='/Users/marybethsechler/Desktop/GAW/Homework/problem-set-4/data'

#build index

gunzip $data/hg19.chr1.fa.gz


#bowtie2-build ref filename what you want output called

bowtie2-build $data/hg19.chr1.fa $data/hg19.chr1

#bowtie2 to set up the alignment

bowtie2 -x hg19.chr1 -U factorx.chr1.fq.gz \
|samtools sort -o factorx.sort.bam