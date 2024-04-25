#!/bin/bash
#SBATCH --job-name=callpeak
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

#1. call peaks from cattle MeRIP-seq
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/04Peak/01Exomepeak2
cd $workdir/04Peak/01Exomepeak2

module load R
for i in $tissue
do
for j in 1 2 3 4
do
gff=~/data/04Ref/cattle_ARS-UCD1.2.gff
IPBAM=$workdir/03Align/02RNA_meth/${i}*_cattle${j}_IP.rm_duplicates_sorted.bam
INPUTBAM=$workdir/03Align/02RNA_meth/${i}*_cattle${j}_input.rm_duplicates_sorted.bam
samplename=cattle_${i}_${j}
Rscript ~/script/01cattle/03peak/01RNA_m/02peak_call_cattle.r $gff $IPBAM $INPUTBAM $samplename
done
done
