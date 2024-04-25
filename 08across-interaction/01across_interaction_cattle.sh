#!/bin/bash
#SBATCH --job-name=interaction
#SBATCH --partition=reg
#SBATCH --cpus-per-task=40
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

###cattle
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/12Interaction/02Interaction_GE
cd $workdir/12Interaction/02Interaction_GE
rm -rf 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05
mkdir -p 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05

"~/4analysis/01Cattle/10Cis_gene/06DNAm_RNAm_RNAe",
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
"02Gene_spl_4_ML_PN_TPM.txt"


###DB
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/12Interaction/03Interaction_DB1
cd $workdir/12Interaction/03Interaction_DB1
rm -rf 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05
mkdir -p 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05




###DP
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/12Interaction/04Interaction_DP1
cd $workdir/12Interaction/04Interaction_DP1
rm -rf 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05
mkdir -p 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05



###RB
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/12Interaction/05Interaction_RB1
cd $workdir/12Interaction/05Interaction_RB1
rm -rf 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05
mkdir -p 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05


###RP
species=Cattle
workdir=~/analysis/01$species
mkdir -p $workdir/12Interaction/06Interaction_RP1
cd $workdir/12Interaction/06Interaction_RP1
rm -rf 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05
mkdir -p 02RelathionshipTXT_eachgene 03Plot_R9 04Relathionship_0.05



