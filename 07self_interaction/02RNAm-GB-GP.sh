#!/bin/bash
#SBATCH --job-name=RNAm-self-interaction
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#####cattle RNAm_GB_GP
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/04RNAm_GB_GP
cd $workdir/10Cis_gene/04RNAm_GB_GP

##Gene body and promoter
cattle_gbody=$workdir/10Cis_gene/01Gene_body_prom/00cattle_gene_body.txt
cattle_gprom=$workdir/10Cis_gene/01Gene_body_prom/00cattle_gene_promoter.txt

####calculate the gene
module load bedtools
for tissue in car mam spl
do
RNAm1=$workdir/05Filter/03RNA_meth_clean/02Overlap2/03${tissue}_1.overlap2


ls $RNAm1
bedtools intersect -loj -a ${cattle_gprom} -b $RNAm1 |awk '$8!="." {print $0}' > 01${tissue}_1_promoter.txt
bedtools intersect -loj -a ${cattle_gbody} -b $RNAm1 |awk '$6!="." {print $0}' > 01${tissue}_1_body.txt

done


################## calculate body_promoter RNAm
mkdir -p $workdir/10Cis_gene/05RNAm_GB_GP_PN
cd $workdir/10Cis_gene/05RNAm_GB_GP_PN

module load R
for tissue in car mam spl
do
for i in 1 2 3 4
do
echo $i
Rscript ~/script/01cattle/09cis_regulation/04RNAm_GB_GP.r \
$workdir/10Cis_gene/04RNAm_GB_GP/01${tissue}_${i}_body.txt \
$workdir/10Cis_gene/04RNAm_GB_GP/01${tissue}_${i}_promoter.txt \
${tissue}_${i}_RNAm_GB_GP_PN
done
done
