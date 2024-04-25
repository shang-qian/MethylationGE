#!/bin/bash
#SBATCH --job-name=gene
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


##RNA expression cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/09Gene_venn/03RNAe/01Exp2gene
cd $workdir/09Gene_venn/03RNAe/01Exp2gene


###2 expression from 4 replicates in cattle
module load bedtools
for i in car mam spl
do
for j in 1 2 3 4
do
echo $i
RNAe=$workdir/05Filter/06RNA_exp_clean/01TPM/01LCS9081_${i}*_cattle${j}.gene_TPM.all
awk '{print $1"\t"$2"\t"$3}' $RNAe >01${i}.${j}.RNAe.bed
bedtools intersect -loj -a 01${i}.${j}.RNAe.bed -b $workdir/09Gene_venn/01DNAm/01Gene_region/01Gene_pos.bed |awk '$4==$1&&$2==$5 {print $0}' > 02$i.$j.gene_peak.bed

awk '{print $1"\t"$2"\t"$3}' 02$i.$j.gene_peak.bed |sort -k1,1 -k2,2n |uniq > 03${i}.$j.peak_gene_overlap.peak
awk '{print $4"\t"$5"\t"$6"\t"$7"\t"$8}' 02$i.$j.gene_peak.bed |sort -k1,1 -k2,2n|uniq >04${i}.$j.gene

done
done


