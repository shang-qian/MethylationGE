#!/bin/bash
#SBATCH --job-name=align
#SBATCH --partition=short
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/03Align/01DNA_meth/02BS2_Align
cd $workdir/03Align/01DNA_meth/02BS2_Align


####1Alignment
module load bowtie2 samtools

R1=$workdir/02Trim/01DNA_meth/$tissue/${tissue}*_${sample}_1_val_1.fq.gz
R2=$workdir/02Trim/01DNA_meth/$tissue/${tissue}*_${sample}_2_val_2.fq.gz

bs_seeker2-align.py -1 $R1 -2 $R2 \
-g ~/data/04Ref/BS3/cow1_2_NCBI.fa \
--aligner=bowtie2 \
-o ${tissue}_${sample}_BS2.bam  \
--temp_dir=./ \
--bt2-p 32 \
-d $workdir/03Align/01DNA_meth/01BS2_Index  \
-f bam


###2sort and deduplicate
samtools sort -@ 32 ${tissue}_${sample}_BS2.bam -o ${tissue}_${sample}_BS2_sort.bam

gatk MarkDuplicates \
      --INPUT ${tissue}_${sample}_BS2_sort.bam \
      --OUTPUT ${tissue}_${sample}.rm_duplicates.bam \
      --METRICS_FILE ${tissue}_${sample}.rm_dup_metrics.txt \
      --REMOVE_DUPLICATES true \
      --TMP_DIR ./

##3call methylation
bs_seeker2-call_methylation.py -i ${tissue}_${sample}.rm_duplicates.bam -o ${tissue}_${sample}_bs2_output --db $workdir/03Align/01DNA_meth/01BS2_Index/cow1_2_NCBI.fa_bowtie2

