#!/bin/bash
#SBATCH --job-name=5factors
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/07Relation_5Factors
cd $workdir/10Cis_gene/07Relation_5Factors


module load R

for tissue in car mam spl
do
for i in 1 2 3 4
do
echo $i
mkdir ${tissue}_${i}
cd ${tissue}_${i}

Rscript ~/script/01cattle/09cis_regulation/07Relation_5factors_YN/02Factors_relationship_coding_2.r \
$workdir/10Cis_gene/06DNAm_RNAm_RNAe/02Gene_${tissue}_${i}_ML_PN_TPM.txt \
01${tissue}_${i}

cd ..
done
done

paste */02*GE*.coefficents > 12sample_parameters12_GE_cattle.txt
paste */04*DB*.coefficents > 12sample_parameters12_DB_cattle.txt
paste */06*DP*.coefficents > 12sample_parameters12_DP_cattle.txt
paste */08*RB*.coefficents > 12sample_parameters12_RB_cattle.txt
paste */10*RP*.coefficents > 12sample_parameters12_RP_cattle.txt








