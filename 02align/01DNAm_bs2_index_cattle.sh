#!/bin/bash
#SBATCH --job-name=BS2
#SBATCH --partition=short
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


###bsseek2
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/03Align/01DNA_meth/01BS2_Index
cd $workdir/03Align/01DNA_meth/01BS2_Index


####1 chromosome
ref=~/data/04Ref/BS3/cow1_2_NCBI.fa

module load bowtie2
bs_seeker2-build.py -f $ref --aligner=bowtie2 -d $workdir/03Align/01DNA_meth/01BS2_Index


