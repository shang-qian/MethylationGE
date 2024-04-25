#!/bin/bash
#SBATCH --job-name=RNAe
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/06DNAm_RNAm_RNAe
cd $workdir/10Cis_gene/06DNAm_RNAm_RNAe

GeneF=$workdir/10Cis_gene/01Gene_body_prom/00cattle_gene_body.txt

module load R

for i in car mam spl
do
k=0
for j in 1 2 3 4
do
echo $i
let k=$k+1
echo $k
DNAm=$workdir/10Cis_gene/03DNAm_GB_GP_ML/02DNAm_${j}_${i}_GB_GP_ML_mC.txt
RNAm=$workdir/10Cis_gene/05RNAm_GP_GP_PN/${i}_${j}_RNAm_GB_GP_PN.txt
TPM=$workdir/05Filter/06RNA_exp_clean/01TPM/02LCS9081_${i}*_cattle${k}.gene_TPM.gene

Rscript ~/script/01cattle/09cis_regulation/06DNAm_RNAm_RNAe.r $GeneF $DNAm $RNAm $TPM ${i}_${j}
done
done
 
 

