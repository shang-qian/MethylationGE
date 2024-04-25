#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


###fastqc
module load fastqc
species=Cattle

###DNA methylation
workdir=~/analysis/01$species
mkdir -p $workdir/01Fastqc/01DNA_meth
cd $workdir/01Fastqc/01DNA_meth

for i in $(ls ~/data/01DNA_meth/cattle/01.RawData/*.fq.gz)
do
echo $i
fastqc -t 60 $i -o ./
done

###RNA-meth
workdir=~/analysis/01$species
mkdir -p $workdir/01Fastqc/02RNA_meth
cd $workdir/01Fastqc/02RNA_meth

for i in $(ls ~/data/02RNA_meth/cattle/CleanData/*_cattle*.fastq.gz)
do
echo $i
fastqc -t 60 $i -o ./
done

##RNA-seq
#The same with RNA-meth input files
