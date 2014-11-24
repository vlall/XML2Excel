# Vishal Lall 2014
# MAKE SURE YOU ARE IN THE RIGHT DIRECTORY!
# Just change this variable 'subjectList' to include all of the subjects you wants to run.

import xlwt

#Flag A. This is for making an excel workbook.
wb = xlwt.Workbook()


subjectList = ['SCM01','SCM02','SCM03','SCM04','SCM05','SCM06','SCM07','SCM08','SCM09','SCM10','SCM11']

for j in subjectList:
    subject = j
    
    #Flag A
    ws = wb.add_sheet('%s', % (subject))
    
    path = subject + '/sceneFace/'
    with open(path+"NEW_ROI_Names.txt", "r") as myfile:
        roiFile = myfile.readlines()
        myfile.close()
    with open(path+"%s_DYN_func_face.txt" % (subject), "r") as myfile2:
        faceFile = myfile2.readlines()
        myfile2.close()
    with open(path+"%s_DYN_func_scene.txt" % (subject), "r") as myfile3:
        sceneFile = myfile3.readlines()
        myfile3.close()
    with open(path+"%s_STAT_func_face.txt" % (subject), "r") as myfile4:
        sceneFile = myfile4.readlines()
        myfile4.close()
    with open(path+"%s_STAT_func_scene.txt" % (subject), "r") as myfile5:
        sceneFile = myfile5.readlines()
        myfile5.close()
        
    if (len(roiFile) != len(faceFile)):
        print ('\nWARNING: Your Number of ROIs and data are mismatched!\n')

    csvFile = open(path+"%s_Data.csv" % (subject), "w")
    for i in range (0,len(roiFile)):
        print ( "%s,%s,%s" % (roiFile[i].rstrip(),faceFile[i].rstrip(),sceneFile[i].rstrip()))
        csvFile.write( "%s,%s,%s\n" % (roiFile[i].rstrip(),faceFile[i].rstrip(),sceneFile[i].rstrip()))
    csvFile.close()
    print len(roiFile)
    
    
    
    # Flag A: Adding Excel wrting Features
#    ws.write(row, 0, str(y*i) + unit)
#    row = row + 1
