args <- commandArgs(trailingOnly = TRUE)

print(args[1])  #direction folder

#cattle
F1=read.table(paste0(args[1],"/",args[2]),head=T)
F2=read.table(paste0(args[1],"/",args[3]),head=T)
F3=read.table(paste0(args[1],"/",args[4]),head=T)
F4=read.table(paste0(args[1],"/",args[5]),head=T)
F5=read.table(paste0(args[1],"/",args[6]),head=T)
F6=read.table(paste0(args[1],"/",args[7]),head=T)
F7=read.table(paste0(args[1],"/",args[8]),head=T)
F8=read.table(paste0(args[1],"/",args[9]),head=T)
F9=read.table(paste0(args[1],"/",args[10]),head=T)
F10=read.table(paste0(args[1],"/",args[11]),head=T)
F11=read.table(paste0(args[1],"/",args[12]),head=T)
F12=read.table(paste0(args[1],"/",args[13]),head=T)


###Total gene
TGc=unique(c(F1[,1],F2[,1],F3[,1],F4[,1],F5[,1],F6[,1],F7[,1],F8[,1],F9[,1],F10[,1],F11[,1],F12[,1]))
F0=matrix(TGc,,1)
colnames(F0)="Gene"

###merge samples
F01=merge(F0,F1[,c(1,6,8,10:12)],by="Gene",all.x=T)
F012=merge(F01,F2[,c(1,6,8,10:12)],by="Gene",all.x=T)
F13=merge(F012,F3[,c(1,6,8,10:12)],by="Gene",all.x=T)

factor_levels_A <- c("DB", "DP", "RB","RP","TPM")
factor_levels_B <- c("car1", "car2", "car3")
combinations <- expand.grid(Factor_A = factor_levels_A, Factor_B = factor_levels_B)
colnames(F13)[2:16]=paste(combinations$Factor_A, combinations$Factor_B, sep = "_")

F14=merge(F13,F4[,c(1,6,8,10:12)],by="Gene",all.x=T)
F15=merge(F14,F5[,c(1,6,8,10:12)],by="Gene",all.x=T)
F16=merge(F15,F6[,c(1,6,8,10:12)],by="Gene",all.x=T)
factor_levels_B <- c("car4", "mam1", "mam2")
combinations <- expand.grid(Factor_A = factor_levels_A, Factor_B = factor_levels_B)
colnames(F16)[17:31]=paste(combinations$Factor_A, combinations$Factor_B, sep = "_")

F17=merge(F16,F7[,c(1,6,8,10:12)],by="Gene",all.x=T)
F18=merge(F17,F8[,c(1,6,8,10:12)],by="Gene",all.x=T)
F19=merge(F18,F9[,c(1,6,8,10:12)],by="Gene",all.x=T)
factor_levels_B <- c("mam3", "mam4", "spl1")
combinations <- expand.grid(Factor_A = factor_levels_A, Factor_B = factor_levels_B)
colnames(F19)[32:46]=paste(combinations$Factor_A, combinations$Factor_B, sep = "_")

F110=merge(F19,F10[,c(1,6,8,10:12)],by="Gene",all.x=T)
F111=merge(F110,F11[,c(1,6,8,10:12)],by="Gene",all.x=T)
F112=merge(F111,F12[,c(1,6,8,10:12)],by="Gene",all.x=T)
factor_levels_B <- c("spl2", "spl3", "spl4")
combinations <- expand.grid(Factor_A = factor_levels_A, Factor_B = factor_levels_B)
colnames(F112)[47:61]=paste(combinations$Factor_A, combinations$Factor_B, sep = "_")


####expression
allexp=F112[,c(6,11,16,21,26,31,36,41,46,51,55,61)]
custom_function <- function(x) {
  count_value <- length(x[x!=0])
  return(count_value)
}
allcount=apply(allexp,1,custom_function)
all_gene_exp=cbind(F112,allcount)

Gene_sample=all_gene_exp[all_gene_exp[,ncol(all_gene_exp)]>2,]
DB=Gene_sample[,c(2,7,12,17,22,27,32,37,42,47,52,57)]
DP=Gene_sample[,c(3,8,13,18,23,28,33,38,43,48,53,58)]
RB=Gene_sample[,c(4,9,14,19,24,29,34,39,44,49,54,59)]
RP=Gene_sample[,c(5,10,15,20,25,30,35,40,45,50,55,60)]
TPM=Gene_sample[,c(1,6,11,16,21,26,31,36,41,46,51,56,61)]

Allgene_n=Gene_sample[,1]
rownames(DB)=c(paste0("DB:",Allgene_n))
rownames(DP)=c(paste0("DP:",Allgene_n))
rownames(RB)=c(paste0("RB:",Allgene_n))
rownames(RP)=c(paste0("RP:",Allgene_n))

XR=rbind(as.matrix(DB),as.matrix(DP),as.matrix(RB),as.matrix(RP))
XR_name <- apply(XR, 1, paste, collapse = ",")
XR_M_name=cbind(XR_name,XR)
XRUniq=unique(XR_M_name)

combine_gene_XR=NULL
print(nrow(XRUniq))
for (i in 1:nrow(XRUniq))
{
combine_gene_XR[i]=paste(rownames(XR)[which(XR_M_name[,1] %in% XRUniq[i,1])],collapse="|")
}
XRUniq[,1]=combine_gene_XR
X=t(XRUniq)



#######
library(pbapply)
library(parallel)
library(glmnet)


core.number <- detectCores()
cl <- makeCluster(getOption("cl.cores", core.number))
clusterEvalQ(cl, {library(orthopolynom)})
clusterEvalQ(cl, {library(glmnet)})

clusterExport(cl,c("X","Gene_interaction_fun","TPM"),envir=environment())
####calculate each gene
Gene_X=pblapply(1:nrow(TPM),function(c) Gene_interaction_fun(Gene_s=TPM[c,],X=X,species="cattle"),cl=cl)
stopCluster(cl)



Gene_list=Gene_X
final_list=NULL
for (i in 1:length(Gene_list))
{
print(i)
if(length(Gene_list[[i]])>0)
{
tmp_list=do.call(cbind, Gene_list[[i]])
final_list=rbind(final_list,tmp_list)
}
}
result=final_list[,c(2,1,3:ncol(final_list))]
samplename=c("car1","car2","car3","car4","mam1","mam2","mam3","mam4","spl1","spl2","spl3","spl4")
colnames(result)=c("From","To","reg_coefficient","lm_R2","P-value","NonzeroX#","UniqNozeroX#","cor_Coefficient","int.gene#","ExpressedY#",paste0("DNAm/RNAm:",samplename),paste0("TPM:",samplename))

write.table(result,"01cattle_network_interaction_GE_raw.txt",quote=F,row.names=F)
write.csv(result,"01cattle_network_interaction_GE_raw.csv",quote=F,row.names=F)


