#!/bin/bash
#SBATCH --job-name=filger2
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#1. call methylated sites from cattle wgbs
#####clean
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/05Filter/02DNA_meth_clean
cd $workdir/05Filter/02DNA_meth_clean

for tissue in car mam spl
do
for type in CG CHG CHH
do
echo $tissue
Rscript ~/script/01cattle/04filter/01DNAm/03Filter2_overlap2_cattle.r $workdir/05Filter/02DNA_meth_clean ${tissue}1.${type}7.txt ${tissue}2.${type}7.txt ${tissue}3.${type}7.txt ${tissue}4.${type}7.txt

done
done







