#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=short
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


###trim
###1 DNA meth trim
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/02Trim/01DNA_meth
cd $workdir/02Trim/01DNA_meth

module load trimgalore fastqc
trim_galore -j 40 --paired --fastqc --retain_unpaired --output_dir trimmed_reads_customadapter/ --adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCACTTGACTCGATCTCGTA \
--adapter2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTCTGGCTATGTGTAGATC $R1 $R2

