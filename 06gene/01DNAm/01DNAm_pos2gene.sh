#!/bin/bash
#SBATCH --job-name=gene
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


##DNA methylation cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/09Gene_venn/01DNAm
cd $workdir/09Gene_venn/01DNAm



###cattle
mkdir -p 01Gene_region
cd 01Gene_region

gff=~/data/04Ref/cattle_ARS-UCD1.2.gff
awk -v FS="\t" '$3=="gene" {print $1"\t"$4"\t"$5"\t"$7"\t"$9}' $gff |awk '{split($5,a,";");split(a[1],b,"gene-");print $1"\t"$2"\t"$3"\t"$4"\t"b[2]}' \
|sort -k1,1 -k2,2n |uniq |awk '/^NC/ {print $0}'> 01Gene_pos.bed

awk '$4=="+" {print $1"\t"$2-2000"\t"$3"\t"$4"\t"$5}
     $4=="-" {print $1"\t"$2"\t"$3+2000"\t"$4"\t"$5}' 01Gene_pos.bed >02Gene_pos_promoter2k.bed

