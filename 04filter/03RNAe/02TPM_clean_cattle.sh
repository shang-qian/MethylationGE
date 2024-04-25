#!/bin/bash
#SBATCH --job-name=TPM
#SBATCH --partition=reg
#SBATCH --cpus-per-task=64
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


##Cattle
###1.call methylated sites  cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/05Filter/06RNA_exp_clean/01TPM
cd $workdir/05Filter/06RNA_exp_clean/01TPM


for i in $(ls $workdir/05Filter/05RNA_exp/01Raw/*.gene_abundence.tab)
do
sample=$(basename $i .gene_abundence.tab)
echo $sample
awk -v FS="\t" '$6>=0.5 {split($5,a,"gene-"); print a[2]"\t"$6}' 01$sample.gene_TPM.all |uniq >02$sample.gene_TPM.gene
done
     



