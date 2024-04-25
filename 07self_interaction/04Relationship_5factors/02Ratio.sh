

cd ~/analysis/01Cattle/10Cis_gene/07Relation_5Factors 
for i in $(ls */*ERatio*.txt)
do
echo $i
samplename=$(echo $i |awk '{split($1,a,"/"); print a[1]}')
echo $samplename
awk -v samp=$samplename 'NR<=3 {print samp"\t"$0}' $i >>01GERation.total.txt
done


##DB
for i in $(ls */*DBRatio*.txt)
do
echo $i
samplename=$(echo $i |awk '{split($1,a,"/"); print a[1]}')
echo $samplename
awk -v samp=$samplename 'NR<=3 {print samp"\t"$0}' $i >>02DBRation.total.txt
done

###DP
for i in $(ls */*DPRatio*.txt)
do
echo $i
samplename=$(echo $i |awk '{split($1,a,"/"); print a[1]}')
echo $samplename
awk -v samp=$samplename 'NR<=3 {print samp"\t"$0}' $i >>03DPRation.total.txt
done

###RB
for i in $(ls */*RBRatio*.txt)
do
echo $i
samplename=$(echo $i |awk '{split($1,a,"/"); print a[1]}')
echo $samplename
awk -v samp=$samplename 'NR<=3 {print samp"\t"$0}' $i >>04RBRation.total.txt
done

###RP
for i in $(ls */*RPRatio*.txt)
do
echo $i
samplename=$(echo $i |awk '{split($1,a,"/"); print a[1]}')
echo $samplename
awk -v samp=$samplename 'NR<=3 {print samp"\t"$0}' $i >>05RPRation.total.txt
done



