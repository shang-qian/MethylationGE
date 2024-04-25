#!/bin/bash
#SBATCH --job-name=Feature
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1



###Replicates
species=01Cattle
workdir=~/analysis/$species
mkdir -p $workdir/08Genomic_feature/01DNAm
cd $workdir/08Genomic_feature/01DNAm

gff=/mnt/ceph/sxie/data/04Ref/cattle_ARS-UCD1.2.gff

peakpath=$workdir/06Cluster_venn/01DNAm/03Cluster/01bed2

pattern=bed
peakfileformat=bed

module load R
Rscript ~/script/01cattle/07Genomic_feature/01DNAm/01DNAm_Peak_features/02Peak_distribution.r $workdir/08Genomic_feature/01DNAm $gff $peakpath $pattern "cattle_DNAm" $peakfileformat


