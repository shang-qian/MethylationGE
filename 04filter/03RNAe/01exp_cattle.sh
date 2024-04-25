#!/bin/bash
#SBATCH --job-name=stringtie
#SBATCH --partition=reg
#SBATCH --cpus-per-task=60
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#1.stringtie 
module load stringtie

workdir=~/analysis/03RNA_exp/cattle
mkdir -p $workdir
cd $workdir

for i in $(ls ~/analysis/02RNA_meth/cattle/01Align/*_input.sorted.bam)
do
echo $i
sample=$(basename $i _input.sorted.bam)
echo -e "Preparing run:" $sample $(date)
mkdir $sample
cd $sample
gtf=~/data/04Ref/GCF_002263795.1_ARS-UCD1.2_genomic.gff
stringtie -p 60 -G $gtf -eB -o $sample.output.gtf1 -A $sample.gene_abundence.tab1 -C $sample.known.cov_refs.gtf1 $i
cd ..

echo -e "Run complete:" $sample $(date)
done



