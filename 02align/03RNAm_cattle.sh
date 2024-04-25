#!/bin/bash
#SBATCH --job-name=Hisat2
#SBATCH --partition=reg
#SBATCH --cpus-per-task=64
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

##1. build genome index
module load hisat2 samtools

mkdir -p ~/data/04Ref/hisat2_cow
cd ~/data/04Ref/hisat2_cow
hisat2-build -p 32 $ref cattle12.genome

###2. mapping for RNAmeth fastq
module load samtools
for i in $(ls $filedir/*_cattle3*_CleanData_R1.fastq.gz)
do
echo $i

hisat2 -t -p 64 -x ~/data/04Ref/hisat2_cow/cattle12.genome -1 $i -2 $filedir/${sample}_CleanData_R2.fastq.gz -S $sample.sam 

samtools view -bS $sample.sam > $sample.bam
samtools sort $sample.sam >$sample.sorted.bam
samtools flagstat $sample.sorted.bam >$sample.sorted.txt

done




