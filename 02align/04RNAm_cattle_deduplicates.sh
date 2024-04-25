#!/bin/bash
#SBATCH --job-name=Hisat2
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#1. mapping for cattle RNA meth
module load gatk samtools

for i in $(ls *.sorted.bam)
do
echo $i
sample=$(basename $i .sorted.bam)
gatk MarkDuplicates \
      --INPUT $i \
      --OUTPUT $sample.rm_duplicates.bam \
      --METRICS_FILE $sample.rm_dup_metrics.txt \
      --REMOVE_DUPLICATES true

samtools sort -@ 40 -o $sample.rm_duplicates_sorted.bam $sample.rm_duplicates.bam
samtools index $sample.rm_duplicates_sorted.bam
samtools flagstat $sample.rm_duplicates_sorted.bam > $sample.rm_duplicates_sorted.txt1
samtools stats $sample.rm_duplicates_sorted.bam > $sample.rm_duplicates_sorted.txt2

done



