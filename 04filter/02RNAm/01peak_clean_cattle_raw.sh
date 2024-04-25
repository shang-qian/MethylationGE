#!/bin/bash
#SBATCH --job-name=filger
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/05Filter/03RNA_meth_clean/01Raw_Bed
cd $workdir/05Filter/03RNA_meth_clean/01Raw_Bed


for i in car mam spl
do
for j in 1 2 3 4
do
sample=${i}_cattle${j}
echo $sample
awk '/^NC/ {print $1"\t"$2"\t"$3} ' ~/analysis/01Cattle/04Peak/01Exomepeak2/cattle_$i$j/peaks.bed |sort -k1,1 -k2,2n |uniq > $sample.raw.bed
done
done


