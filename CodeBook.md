==================================================================
        Getting and Cleaning Data Course Project
==================================================================
Date: 10-04-2017

Pre-requisite
---------------

The file (URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is downloaded and unzipped at the current working directory.
-----------------------------------------------------------------------------------------------------------------------


Code Environment
----------------
The script written and tested in "R(3.4.1) in RStudio(1.0.153) on Mac(10.13)"
-----------------------------------------------------------------------------------------------------------------------


Description of the Variables and Files Generated from the "run_analysis.R" script:
-----------------------------------------------------------------------------------
"UCI HAR Dataset/combo/ : This folder is created to save all the merged files from the "UCI HAR Dataset/test/" and "UCI HAR Dataset/train/"

This is followed by a big for loop to go through all the files inside "UCI HAR Dataset/test/" and "UCI HAR Dataset/train" and inside their subdirectories. This loop contains many variables as described below:

dirs: looping through directory names

files: looping through file names

subDirName: looping through sub-directory names

newSubDirectory: sub-directory name for the folder inside "/combo/"

testfiles: file name for files in "/test"

trainfiles: file name for files in "/train"

combofiles: file name for files in "/combo"

dirTest: full path for files in "/test"

dirTrain: full path for files in "/train"

dirCombo: full path for files in "/combo"

test: loads the data from the "/test" and saves in a data frame

train: loads the data from the "/train" and saves in a data frame

mydata:  this contains the rowwise combined data from test and train data frame


After the above mentioned recursive procedure of joining all data we get into labelling and subsetting the 
data as required for the project.

varNames: contains the variable names as stored in the "UCI HAR Dataset/features.txt" file.

df1: data frame containing "/UCI HAR Dataset/combo/X_combo.txt" data with proper heading labels

subjects: data frame containing the id of the subjects as mentioned in the "UCI HAR Dataset/combo/subject_combo.txt" 

activity: data frame contianig the id of the activities performed as given in "UCI HAR Dataset/combo/y_combo.txt"


activityLabels: data frame contianig the labels corresponding to the id of the activities performed as given in "UCI HAR Dataset/activity_labels.txt"

df: the final data frame that contains the id of the subjects, activity labels and requisite subset of the main data

CleanData.txt: This is the file that is written to the disk containing the "df".

df3: groups the "df" into Subjects and Activities performed by them

tidyData: grouped data by "Subjects" and "Activities" with rest of the variables averaged. This result in a 30 (number of subjects) x 6(number of activities) i.e. a total of 180 record (or number of rows) with rest of the variables averaged

AverageGroupedData.txt: This is the file that is written to the disk containing the "tidyData"

-----------------------------------------------------------------------------------------------------------------------
