#!/bin/bash
#SBATCH --job-name=filter
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


#1. call methylated sites from cattle wgbs
files=$workdir/03Align/01DNA_meth/02BS2_Align/$sample/${sample}_bs2_output.CGmap.gz

#zcat $files >01Total/$sample.mC0.total
zcat $files |awk '$7>=1 {print $0}' >01Total/$sample.mC.total

#Coverage 1
awk '$4=="CG" {print $0}' 01Total/$sample.mC.total > 02CG/$sample.CG1.txt   
awk '$4=="CHG" {print $0}' 01Total/$sample.mC.total > 03CHG/$sample.CHG1.txt
awk '$4=="CHH" {print $0}' 01Total/$sample.mC.total > 04CHH/$sample.CHH1.txt

#Coverage 7
awk '$8>=7  {print $0}' 02CG/$sample.CG1.txt > 02CG/$sample.CG7.txt  
awk '$8>=7  {print $0}' 03CHG/$sample.CHG1.txt > 03CHG/$sample.CHG7.txt
awk '$8>=7  {print $0}' 04CHH/$sample.CHH1.txt > 04CHH/$sample.CHH7.txt

