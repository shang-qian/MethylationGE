#!/bin/bash
#SBATCH --job-name=self-interaction
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1


species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/08Inner_gene/02RelathionshipTXT_eachgene $workdir/10Cis_gene/08Inner_gene/03Plot_R9 $workdir/10Cis_gene/08Inner_gene/04Relathionship_0.05
cd $workdir/10Cis_gene/08Inner_gene

Rscript ~/script/01cattle/09cis_regulation/08Inner_gene/02Inner_cis_reg_cattle.r  "~/analysis/01Cattle/10Cis_gene/06DNAm_RNAm_RNAe",
"02Gene_car_1_ML_PN_TPM.txt",
"02Gene_car_2_ML_PN_TPM.txt",
"02Gene_car_3_ML_PN_TPM.txt",
"02Gene_car_4_ML_PN_TPM.txt",
"02Gene_mam_1_ML_PN_TPM.txt",
"02Gene_mam_2_ML_PN_TPM.txt",
"02Gene_mam_3_ML_PN_TPM.txt",
"02Gene_mam_4_ML_PN_TPM.txt",
"02Gene_spl_1_ML_PN_TPM.txt",
"02Gene_spl_2_ML_PN_TPM.txt",
"02Gene_spl_3_ML_PN_TPM.txt",
"02Gene_spl_4_ML_PN_TPM.txt",
"01Cis_gene_cattle"


######how many gene positive and negative
species=Cattle
workdir=~/analysis/01$species

cat *0.05.txt |sort |uniq >../05Relationship_0.05_All.txt
awk '!/^lm/ {split($8,a,":"); print $2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"a[1]"\t"a[2]}' 05Relationship_0.05_All.txt >06Relationship_0.05_All_gene_type.txt
###total gene #
awk '{print $9}' 06Relationship_0.05_All_gene_type.txt |sort |uniq |wc -l
awk '$8=="DB" {print $9}' 06Relationship_0.05_All_gene_type.txt |sort |uniq |wc -l
awk '$8=="DP" {print $9}' 06Relationship_0.05_All_gene_type.txt |sort |uniq |wc -l
awk '$8=="RB" {print $9}' 06Relationship_0.05_All_gene_type.txt |sort |uniq |wc -l
awk '$8=="RP" {print $9}' 06Relationship_0.05_All_gene_type.txt |sort |uniq |wc -l

##All distribution
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/08Inner_gene/07All_upset
cd $workdir/10Cis_gene/08Inner_gene/07All_upset

All_gene=read.table("../06Relationship_0.05_All_gene_type.txt")
gene_total=sort(unique(All_gene[,9]))
print(length(gene_total))
ResultAll=NULL
for (i in 1:length(gene_total))
{
tmp=All_gene[All_gene[,9]==gene_total[i],]
if(dim(tmp)[1]==1)
{ DBPRBP=c(length(tmp[1,8][tmp[1,8] %in% "DB"]),length(tmp[1,8][tmp[1,8] %in% "DP"]),length(tmp[1,8][tmp[1,8] %in% "RB"]),length(tmp[1,8][tmp[1,8] %in% "RP"]))
ResultAll=rbind(ResultAll,cbind(i,nrow(tmp),DBPRBP[1],DBPRBP[2],DBPRBP[3],DBPRBP[4],gene_total[i],tmp))
} else {
DBPRBP=c(length(tmp[,8][tmp[,8] %in% "DB"]),length(tmp[,8][tmp[,8] %in% "DP"]),length(tmp[,8][tmp[,8] %in% "RB"]),length(tmp[1,8][tmp[,8] %in% "RP"]))
ResultAll=rbind(ResultAll,cbind(i,nrow(tmp),DBPRBP[1],DBPRBP[2],DBPRBP[3],DBPRBP[4],gene_total[i],tmp))
}
}

write.table(ResultAll,"01All_gene_cis.txt",quote=F,row.names=F)
awk '$2=="1" {print $1"\t"$2}' 01All_gene_cis.txt |sort |uniq |wc -l
awk '$2=="2" {print $1"\t"$2}' 01All_gene_cis.txt |sort |uniq |wc -l
awk '$2=="3" {print $1"\t"$2}' 01All_gene_cis.txt |sort |uniq |wc -l
awk '$2=="4" {print $1"\t"$2}' 01All_gene_cis.txt |sort |uniq |wc -l

awk 'NR>1&&$15=="DB" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >02DB_all.bed
awk 'NR>1&&$15=="DP" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >03DP_all.bed
awk 'NR>1&&$15=="RB" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >04RB_all.bed
awk 'NR>1&&$15=="RP" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >05RP_all.bed
###Raw replicates
intervene upset -i *all.bed --filenames -o 06All.upset
awk 'NR>1&&$15=="DB"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >02DB_pos.bed
awk 'NR>1&&$15=="DB"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >02DB_neg.bed
awk 'NR>1&&$15=="DP"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >03DP_pos.bed
awk 'NR>1&&$15=="DP"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >03DP_neg.bed
awk 'NR>1&&$15=="RB"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >04RB_pos.bed
awk 'NR>1&&$15=="RB"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >04RB_neg.bed
awk 'NR>1&&$15=="RP"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >05RP_pos.bed
awk 'NR>1&&$15=="RP"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 01All_gene_cis.txt >05RP_neg.bed

intervene upset -i *pos.bed --filenames -o 06Pos.upset
intervene upset -i *neg.bed --filenames -o 06Neg.upset
######
##r2 0.9 distribution
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/10Cis_gene/08Inner_gene/080.9_upset
cd $workdir/10Cis_gene/08Inner_gene/080.9_upset
All_gene=read.table("../06Relationship_0.05_All_gene_type.txt")
All_gene=All_gene[All_gene[,3]>=0.9,]
gene_total=sort(unique(All_gene[,9]))
print(length(gene_total))
ResultAll=NULL
for (i in 1:length(gene_total))
{
tmp=All_gene[All_gene[,9]==gene_total[i],]
if(dim(tmp)[1]==1)
{ DBPRBP=c(length(tmp[1,8][tmp[1,8] %in% "DB"]),length(tmp[1,8][tmp[1,8] %in% "DP"]),length(tmp[1,8][tmp[1,8] %in% "RB"]),length(tmp[1,8][tmp[1,8] %in% "RP"]))
ResultAll=rbind(ResultAll,cbind(i,nrow(tmp),DBPRBP[1],DBPRBP[2],DBPRBP[3],DBPRBP[4],gene_total[i],tmp))
} else {
DBPRBP=c(length(tmp[,8][tmp[,8] %in% "DB"]),length(tmp[,8][tmp[,8] %in% "DP"]),length(tmp[,8][tmp[,8] %in% "RB"]),length(tmp[1,8][tmp[,8] %in% "RP"]))
ResultAll=rbind(ResultAll,cbind(i,nrow(tmp),DBPRBP[1],DBPRBP[2],DBPRBP[3],DBPRBP[4],gene_total[i],tmp))
}
}

write.table(ResultAll,"010.9_gene_cis.txt",quote=F,row.names=F)

awk '$2=="1" {print $1"\t"$2}' 010.9_gene_cis.txt |sort |uniq |wc -l
awk '$2=="2" {print $1"\t"$2}' 010.9_gene_cis.txt |sort |uniq |wc -l
awk '$2=="3" {print $1"\t"$2}' 010.9_gene_cis.txt |sort |uniq |wc -l
awk '$2=="4" {print $1"\t"$2}' 010.9_gene_cis.txt |sort |uniq |wc -l

awk 'NR>1&&$15=="DB" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >02DB_0.9.bed
awk 'NR>1&&$15=="DP" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >03DP_0.9.bed
awk 'NR>1&&$15=="RB" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >04RB_0.9.bed
awk 'NR>1&&$15=="RP" {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >05RP_0.9.bed

intervene upset -i *0.9.bed --filenames -o 06All.upset
awk 'NR>1&&$15=="DB"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >02DB_pos.bed
awk 'NR>1&&$15=="DB"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >02DB_neg.bed
awk 'NR>1&&$15=="DP"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >03DP_pos.bed
awk 'NR>1&&$15=="DP"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >03DP_neg.bed
awk 'NR>1&&$15=="RB"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >04RB_pos.bed
awk 'NR>1&&$15=="RB"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >04RB_neg.bed
awk 'NR>1&&$15=="RP"&&$8>0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >05RP_pos.bed
awk 'NR>1&&$15=="RP"&&$8<0 {print "chr1\t"$1"\t"$1+1"\t"$15"\t"$16}' 010.9_gene_cis.txt >05RP_neg.bed

intervene upset -i *pos.bed --filenames -o 06Pos.upset
intervene upset -i *neg.bed --filenames -o 06Neg.upset


####intersect between cattle and sheep
mkdir -p $workdir/10Cis_gene/08Inner_gene/09CS
cd $workdir/10Cis_gene/08Inner_gene/09CS
module load R

cattle=read.table("../06Relationship_0.05_All_gene_type.txt")
sheep=read.table("~/analysis/02Sheep/10Cis_gene/08Inner_gene/06Relationship_0.05_All_gene_type.txt")
cattle9=cattle[cattle[,3]>=0.9,]
sheep9=sheep[sheep[,3]>=0.9,]
cs=intersect(cattle9[,7],sheep9[,7])

CH=cbind("cattle",cattle9[which(cattle9[,7] %in% cs),])
SH=cbind("sheep",sheep9[which(sheep9[,7] %in% cs),])
colnames(CH)[1]=colnames(SH)[1]="species"
CS_result=rbind(CH,SH)
write.table(CS_result,"Cattle_sheep_overlap_gene.txt",quote=F,row.names=F)

