#!/bin/bash
#SBATCH --job-name=overlap2
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/05Filter/03RNA_meth_clean/02Overlap2/01Intersect
cd $workdir/05Filter/03RNA_meth_clean/02Overlap2

###1Bed
module load bedtools
for i in car mam spl
do

bedtools intersect -loj -a ../01Raw_Bed/01Total/01${i}_total.bed -b ../01Raw_Bed/${i}_cattle1.raw.bed |\
awk '$4=="." {print $1"\t"$2"\t"$3"\t"0}
     $4!="." {print $1"\t"$2"\t"$3"\t"1}' |sort -k1,1 -k2,2n |uniq >01Intersect/01${i}.T1.bed
wc -l 01Intersect/01${i}.T1.bed

bedtools intersect -loj -a 01Intersect/01${i}.T1.bed  -b ../01Raw_Bed/${i}_cattle2.raw.bed |\
awk '$5=="." {print $1"\t"$2"\t"$3"\t"$4"\t"0}
     $5!="." {print $1"\t"$2"\t"$3"\t"$4"\t"1}' |sort -k1,1 -k2,2n |uniq >01Intersect/02${i}.T12.bed
wc -l 01Intersect/02${i}.T12.bed  
     
bedtools intersect -loj -a 01Intersect/02${i}.T12.bed  -b ../01Raw_Bed/${i}_cattle3.raw.bed |\
awk '$6=="." {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"0}
     $6!="." {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"1}' |sort -k1,1 -k2,2n |uniq >01Intersect/03${i}.T123.bed
wc -l 01Intersect/03${i}.T123.bed  
 
bedtools intersect -loj -a 01Intersect/03${i}.T123.bed  -b ../01Raw_Bed/${i}_cattle4.raw.bed |\
awk '$7=="." {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"0}
     $7!="." {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"1}' |sort -k1,1 -k2,2n |uniq >01Intersect/04${i}.T1234.bed
wc -l 01Intersect/04${i}.T1234.bed  

awk '$4+$5+$6+$7>=2 {print $0} ' 01Intersect/04${i}.T1234.bed > 02${i}.tatal.overlap2

####sample1
bedtools intersect -loj -a ../01Raw_Bed/${i}_cattle1.raw.bed -b 02${i}.tatal.overlap2 |awk '$1==$4&&$2==$5&&$3==$6 {print $0}' |sort -k1,1 -k2,2n |uniq >03${i}_1.overlap2

done

