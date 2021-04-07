#!/bin/sh

genomeDir=../databases/hsapiens/genome/fa

touch Homo_sapiens_chrs.fa
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y MT
do
	wget -O $genomeDir/Homo_sapiens_chr${i}.fa.gz http://ftp.ensembl.org/pub/release-103/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.chromosome.${i}.fa.gz
	gunzip Homo_sapiens_chr${i}.fa.gz
	cat $genomeDir/Homo_sapiens_chr${i}.fa >> $genomeDir/Homo_sapiens_chrs.fa
	rm $genomeDir/Homo_sapiens_chr${i}.fa
done
ln -s $genomeDir/Homo_sapiens_chrs.fa $genomeDir/hsapiens.fa
