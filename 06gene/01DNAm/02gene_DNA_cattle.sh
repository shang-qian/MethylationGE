#!/bin/bash
#SBATCH --job-name=gene
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


##RNA methylation cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/09Gene_venn/01DNAm/03Tissue2gene
cd $workdir/09Gene_venn/01DNAm/03Tissue2gene


for i in car mam spl
do
cat $workdir/09Gene_venn/01DNAm/02Gene_replicates/03${i}_*_gene.bed |sort -k1,1 -k2,2n |uniq > 01${i}_merge4replicates.gene
done



module load R
Rscript ~/script/01cattle/08Gene_venn/01DNAm/05DNAm_3tissue_venn_cattle.r $workdir/09Gene_venn/01DNAm/03Tissue2gene \
01car_merge4replicates.gene 01mam_merge4replicates.gene 01spl_merge4replicates.gene 02Cattle_DNAm_tissues_gene



