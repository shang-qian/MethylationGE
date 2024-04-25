#!/bin/bash
#SBATCH --job-name=self-interaction
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/02DNAm_GB_GP
cd $workdir/10Cis_gene/02DNAm_GB_GP

###1 gene intersect with DNA methylation
mkdir GB GP
module load bedtools
for i in car mam spl
do
for j in 1 2 3 4
do
echo $i
bedtools intersect -loj -a ../01Gene_body_prom/00cattle_gene_body.txt -b 01$i.$j.c7o2.ML.bed |awk '$6!="."&&$4==$9 {print $0}' >GB/01GB_${i}_$j.bed
bedtools intersect -loj -a ../01Gene_body_prom/00cattle_gene_promoter.txt -b 01$i.$j.c7o2.ML.bed |awk '$8!="."&&$6==$11 {print $0}'>GP/01GP_${i}_$j.bed
done
done


###2 calculate GB_GP_ML_mC
mkdir -p $workdir/10Cis_gene/03DNAm_GB_GP_ML
cd $workdir/10Cis_gene/03DNAm_GB_GP_ML

module load R
for i in car mam spl
do
for j in 1 2 3 4
do
echo $i
Rscript ~/script/01cattle/09cis_regulation/02DNAm_GB_GP_ML.r $workdir/10Cis_gene/02DNAm_GB_GP/GB/01GB_${i}_$j.bed $workdir/10Cis_gene/02DNAm_GB_GP/GP/01GP_${i}_$j.bed DNAm_${j}_${i}
done
done



