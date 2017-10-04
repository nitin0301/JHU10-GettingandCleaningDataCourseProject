# JHU10-GettingandCleaningDataCourseProject

Date: Wed Oct  4 09:43:06 2017
==============================


UCI HAR Dataset
================
This is the dataset that is obtained from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data source and description can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


run_analysis.R 
================
(1) This script does all the work of combining and cleaning the data. Initially, it first creates a "UCI HAR Dataset/combo/" folder that contains the merged data from the "UCI HAR Dataset/train/" and "UCI HAR Datasettest/" sets. 

(2) Thereafter, the code extracts the data on only Mean and Standard deviation measured variable and also adds the Subject and the Activity Labels performed for getting the data. The new file generated with proper labels is called "CleanData.txt".

(3) In the last step, a smaller tidy data set is extracted by averaging all the variables for each subject doing each activity. The new file generated with column names is called "AverageGroupedData.txt".


CodeBook.md
================
This contains the description of the variables and data transformation done in the "run_analysis.R" script


Code Environment
==================================
NOTE: This script is written and tested in the environment: "R(3.4.1) in RStudio(1.0.153) on Mac(10.13)" on "Wed Oct  4 09:43:06 2017" with the following versions of the packages:

stringr : 1.2.0
dplyr : 0.7.4

