#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=short
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

###trim

###1 RNA meth trim
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/02Trim/02RNA_meth
cd $workdir/02Trim/02RNA_meth

##module load trimgalore fastqc
for tissue in car mam spl
do
echo $tissue
for i in 1 2 3 4
do
echo $tissue
R1=~/data/02RNA_meth/cattle/CleanData/${tissue}*_cattle${i}_input_CleanData_R1.fastq.gz
R2=~/data/02RNA_meth/cattle/CleanData/${tissue}*_cattle${i}_input_CleanData_R2.fastq.gz 

trim_galore -j 40 --paired --fastqc --retain_unpaired --output_dir $tissue --adapter TCACCGTGCCAGACTAGAGTCAAGCTCAACAGGGTCTTCTTTCCCCGCTG --adapter2 GGGTATAGGGGCGAAAGACTAATCGAACCATCTAGTAGCTGGTTCCCTCC $R1 $R2
done
done
