#!/bin/bash
#SBATCH --job-name=gene
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


##RNA methylation cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/09Gene_venn/02RNAm/01Peak2gene
cd $workdir/09Gene_venn/02RNAm/01Peak2gene

###2 peak from 4 replicates in cattle
module load bedtools
for i in car mam spl
do
for j in 1 2 3 4
do
echo $i
RNAm=~/analysis/01Cattle/05Filter/03RNA_meth_clean/02Overlap2/03${i}_${j}.overlap2
awk '{print $1"\t"$2"\t"$3}' $RNAm >01${i}.$j.o2.bed
bedtools intersect -loj -a 01${i}.${j}.o2.bed -b $workdir/09Gene_venn/01DNAm/01Gene_region/02Gene_pos_promoter2k.bed |awk '$4!="." {print $0}' > 02$i.$j.gene_peak.bed
awk '{print $1"\t"$2"\t"$3}' 02$i.$j.gene_peak.bed |sort -k1,1 -k2,2n |uniq > 03${i}.$j.peak_gene_overlap.peak
awk '{print $4"\t"$5"\t"$6"\t"$7"\t"$8}' 02$i.$j.gene_peak.bed |sort -k1,1 -k2,2n|uniq >04${i}.$j.peak_gene_overlap.gene

done
done


