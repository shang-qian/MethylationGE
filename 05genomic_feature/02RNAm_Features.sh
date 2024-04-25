#!/bin/bash
#SBATCH --job-name=Feature
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


species=01Cattle
workdir=~/analysis/$species
mkdir -p $workdir/08Genomic_feature/02RNAm
cd $workdir/08Genomic_feature/02RNAm


gff=/mnt/ceph/sxie/data/04Ref/cattle_ARS-UCD1.2.gff
peakpath=$workdir/05Filter/03RNA_meth_clean/02Overlap2
pattern=overlap2
peakfileformat=overlap2

module load R
Rscript ~/script/01cattle/07Genomic_feature/02RNAm/01Peak_features/02Peak_distribution.r $workdir/08Genomic_feature/02RNAm $gff $peakpath $pattern "cattle" $peakfileformat


