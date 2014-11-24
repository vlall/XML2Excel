#!/bin/bash

# ROI analysis
# last edits fk (1/7/13)

# BEFORE RUNNING: make folder "ROIspreads" in dir (main directory) and add files "xnoROI" and "xROI_list.txt" to that folder. Rename after finished (if necessary). Also, do not forget to change the ROIs in "xROI_list.txt" to your ROIs.

subj_list="SCM01"

#SCM02 SCM03 SCM04 SCM05 SCM06 SCM07 SCM08 SCM09 SCM10 SCM11"
cond="DYN_func STAT_func"

new_file=""
roi_list="lFFA lOFA lOPA lPPA lpSTS lRSC raFFA rFFA rpFFA rOPA rPPA rpSTS rRSC"

# Finished=""

# main directory where setup files are stored
dir=/Volumes/Zeus/SCM
#dir=/Volumes/freddybackup/Data/MRI/DilksStudies
#noROI=/Users/fkamps/Desktop/OPAP/Sub01/Func/Task1_OPAParts/ROIspreads/xnoROI

for i in $subj_list
do

mkdir $dir/ROIspreads/$i
mkdir $dir/ROIspreads/$i/nii

#echo $new_file$'\n' > $subjDir/sceneFace/NEW_ROI_Names.txt
for c in $cond
do

maskDir=$dir/$i/ROIs      #Set ROIs to use here
subjDir=$dir/ROIspreads/$i
condDir=$dir/$i/$c/HighLevel_SmoothExp.gfeat
#scrambDir=$dir/$i/${c}Exp/${c}Exp_fixFX_SCRAMBLED.gfeat  #not sure i need this

mkdir $dir/ROIspreads/$i/sceneFace
faceStat=$condDir/cope1.feat
sceneStat=$condDir/cope2.feat


for j in $roi_list
do

# percent signal change
if [ -f $dir/${i}/ROIs/${j}.nii.gz ]   #change ROI dir
  then
    fslmaths $faceStat/stats/cope1.nii.gz -div $faceStat/mean_func.nii.gz -mul 100 -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_face
    fslmaths $sceneStat/stats/cope1.nii.gz -div $sceneStat/mean_func.nii.gz -mul 100 -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_scene
    if [ 2=3 ]
        then
            new_file=$j
            echo $new_file >> $subjDir/sceneFace/NEW_ROI_Names.txt
    fi
fi

if [ -f $subjDir/${i}_${c}_${j}_face.nii.gz ]
  then
    fslstats $subjDir/${i}_${c}_${j}_face.nii.gz -M >> $subjDir/${i}_${c}_face.txt
    fslstats $subjDir/${i}_${c}_${j}_scene.nii.gz -M >> $subjDir/${i}_${c}_scene.txt

  else
    cat "$noROI" >> "$subjDir/${i}_${c}_face.txt"
    cat "$noROI" >> "$subjDir/${i}_${c}_scene.txt"
    echo "subject ${i} does not have a ${j}!!!"
fi

# Beta
#if [ -f $dir/${i}/ROI/${j}.nii.gz ]
#then
#fslmaths $faceStat/stats/cope1.nii.gz -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_face_Beta
#fslmaths $bodyStat/stats/cope1.nii.gz -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_body_Beta
#fslmaths $sceneStat/stats/cope1.nii.gz -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_scene_Beta
#fslmaths $objectStat/stats/cope1.nii.gz -mul $maskDir/${j}.nii.gz $subjDir/${i}_${c}_${j}_object_Beta
#fi
#
#if [ -f $subjDir/${i}_${c}_${j}_face.nii.gz ]
#then
#fslstats $subjDir/${i}_${c}_${j}_face_Beta.nii.gz -M >> $subjDir/${i}_${c}_face_Beta.txt
#fslstats $subjDir/${i}_${c}_${j}_body_Beta.nii.gz -M >> $subjDir/${i}_${c}_body_Beta.txt
#fslstats $subjDir/${i}_${c}_${j}_scene_Beta.nii.gz -M >> $subjDir/${i}_${c}_scene_Beta.txt
#fslstats $subjDir/${i}_${c}_${j}_object_Beta.nii.gz -M >> $subjDir/${i}_${c}_object_Beta.txt
#else
#cat "$noROI" >> "$subjDir/${i}_${c}_face_Beta.txt"
#cat "$noROI" >> "$subjDir/${i}_${c}_body_Beta.txt"
#cat "$noROI" >> "$subjDir/${i}_${c}_scene_Beta.txt"
#cat "$noROI" >> "$subjDir/${i}_${c}_object_Beta.txt"
#echo "this subject does not have a ${j}!!!"
#fi

done
mv $subjDir/*.txt $subjDir/sceneFace
mv $subjDir/*.nii.gz $subjDir/nii
done
done

### concatenate across subjects ###

stims="face stat"

dir=/Volumes/Zeus/SCM/ROIspreads
#dir=/Users/fkamps/Desktop/OPAP/ROIspreads

#for c in $conds
#do

for i in $stims
do

paste $dir/xROI_list.txt $dir/SCM01/sceneFace/SCM01_${c}_${i}.txt

#$dir/dl02/$c/sceneFace/dl02_${c}_${i}.txt $dir/dl03/$c/sceneFace/dl03_${c}_${i}.txt $dir/ea1/$c/sceneFace/ea1_${c}_${i}.txt $dir/ea2/$c/sceneFace/ea2_${c}_${i}.txt $dir/ea3/$c/sceneFace/ea3_${c}_${i}.txt $dir/ea4/$c/sceneFace/ea4_${c}_${i}.txt $dir/ea6/$c/sceneFace/ea6_${c}_${i}.txt $dir/ea8/$c/sceneFace/ea8_${c}_${i}.txt $dir/ea13/$c/sceneFace/ea13_${c}_${i}.txt $dir/ea14/$c/sceneFace/ea14_${c}_${i}.txt $dir/ea15/$c/sceneFace/ea15_${c}_${i}.txt $dir/ea16/$c/sceneFace/ea16_${c}_${i}.txt $dir/ea17/$c/sceneFace/ea17_${c}_${i}.txt $dir/ea20/$c/sceneFace/ea20_${c}_${i}.txt $dir/ea27/$c/sceneFace/ea27_${c}_${i}.txt >> $dir/${c}_${i}.txt

done
done
