#################################################################################################################
#################################################################################################################
#                              R(3.4.1) in RStudio(1.0.153) on Mac(10.13)                                       #
#################################################################################################################
#################################################################################################################


#################################################################################################################
# Requirement: The working directory is the place where the data folder "UCI HAR Dataset" is kept               #
#################################################################################################################

scriptLocation <- getwd()

# Going to the folder that has the data
dataLocation <- paste(scriptLocation,"/UCI HAR Dataset/",sep="")
setwd(dataLocation)

#################################################################################################################
#############                            Merging Training and Test Set Folders                      #############
#################################################################################################################
#
# The objective of code chunk below is to automatically create a folder called "combo"
# that contains all the combined values of "/test" and "/train" folders
# The benefit of this approach is the ability to reuse the combined data for future analysis
#

# Creating a common folder called "combo" to store the merged data and setting that as working directory
if(!file.exists("combo")){
        dir.create("combo")
}

# Setting the working directory inside the combo folder
joinedDataLoc <- paste(dataLocation,"combo/",sep="")
setwd(joinedDataLoc)

# Looping through "/test" and "/train" folders to merge the files and write it in the "combo" folder
for (dirs in list.dirs("../test")){ 
        # Going through Folders
        for (files in list.files(dirs,pattern = "\\.txt$")){
                # Going through Files
                if(dirs != "../test"){
                        
                        #Going through sub-directories
                        subDirName <- strsplit(dirs,"\\/")[[1]][3]
                        
                        newSubDirectory <- paste("../combo/",subDirName,sep="")
                        
                        # Creating any requisite sub-directories
                        if(!file.exists(newSubDirectory)){
                                dir.create(newSubDirectory)
                        }

                        #
                        filname <- paste(strsplit(files,"_")[[1]][1],
                                         strsplit(files,"_")[[1]][2],
                                         strsplit(files,"_")[[1]][3],sep="_")
                        
                        # Getting the file names
                        testfiles <- paste(filname,"_test.txt",sep="")
                        trainfiles <- paste(filname,"_train.txt",sep="")
                        combofiles <- paste(filname,"_combo.txt",sep="")
                        
                        # Getting the full file location relative to current working directory
                        dirTest <- paste("../test",subDirName,testfiles,sep="/")
                        dirTrain <- paste("../train",subDirName,trainfiles,sep="/")
                        dirCombo <- paste("../combo",subDirName,combofiles,sep="/")
                        
                        
                } else {
                        #Going through main directories i.e. inside "../test/" and "../train/"
                        filname <- strsplit(files,"_")[[1]][1]
                        
                        # Getting the file names
                        testfiles <- paste(filname,"_test.txt",sep="")
                        trainfiles <- paste(filname,"_train.txt",sep="")
                        combofiles <- paste(filname,"_combo.txt",sep="")
                        
                        # Getting the full file location relative to current working directory
                        dirTest <- paste("../test",testfiles,sep="/")
                        dirTrain <- paste("../train",trainfiles,sep="/")
                        dirCombo <- paste("../combo",combofiles,sep="/")
                        
                }
                
                # Reading Files
                test <- read.table(dirTest,header = FALSE)
                train <- read.table(dirTrain,header = FALSE) 
                
                # Combining Files using rbind function
                mydata <- rbind(test,train)
                
                # Writing Files
                write.table(mydata,dirCombo,col.names = FALSE, row.names = FALSE)
        }
}

#################################################################################################################
#################################################################################################################
#################################################################################################################


# Moving back the working directory to the place where this script is located
setwd(scriptLocation)


#################################################################################################################
#############                                  Creating a Single Data Set                           #############
#############                                      Mean and Std Only                                #############
#############                                  Descriptive Activity Names                           #############
#############                                  Descriptive Variable Names                           #############
#################################################################################################################

# Here onwards we will work on the "/combo/" folder

#--------------------------------------------------------#
#            Getting 561 Feature vector Names            #
#--------------------------------------------------------#
varNames <- readLines("UCI HAR Dataset/features.txt")

# Function to tidy up the name
clean <- function(x){
        tempo <- strsplit(x," ")
        dem <- tempo[[1]][2]
        return (dem)
}

# Recrusively applying the 'clean' function
cleanNames <- lapply(varNames,clean)

# a Vector of clean variable names to 
varNameVector <- unlist(cleanNames)


#--------------------------------------------------------#
#          Loading X_combo.txt into a data frame         #
#--------------------------------------------------------#
# check.names = FALSE ensures that full names of the column are taken
df1 <- read.table("./UCI HAR Dataset/combo/X_combo.txt",header = FALSE,col.names = varNameVector, check.names = FALSE)

#--------------------------------------------------------#
#        Keeping columns that has the mean and std       #
#--------------------------------------------------------#

library(stringr)
for (i in names(df1)){
        #print(i)
        if(str_detect(i,regex("mean",ignore_case = TRUE)) | str_detect(i,regex("std",ignore_case = TRUE))){
                # Leave the Columns Intact
        } else {
                # As mentioned in the Project Assignment Delete These
                df1[i] <- NULL
        }
}

#--------------------------------------------------------#
#              Reading the participants                  #
#--------------------------------------------------------#
subjects <- read.table("UCI HAR Dataset/combo/subject_combo.txt",header = FALSE,col.names = c("Subjects"))


#--------------------------------------------------------#
#        Reading the Activities with Labelling           #
#--------------------------------------------------------#
activity <- read.table("UCI HAR Dataset/combo/y_combo.txt",header = FALSE,col.names = c("Activities"),colClasses = "integer")

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)

#Ascribing activity types instead of just numbers
for (i in 1:dim(activity)[1]){
        for (j in 1:dim(activityLabels)[1]){
                if (activity[i,1]==activityLabels[j,1]){
                        activity[i,1] <- as.character(activityLabels[j,2])
                  }
        }
}

df <- cbind(subjects,activity,df1)

# Writing Final data file as CleanData.txt at the current working directory

write.table(df,"./CleanData.txt",row.names = FALSE)

#################################################################################################################
#################################################################################################################
#################################################################################################################



#################################################################################################################
#############                                 New Averaged Tidy Data Set                            #############
#################################################################################################################

library(dplyr)

df3 <- group_by(df,Subjects,Activities) 

tidyData <- summarize_all(df3,funs(mean))

write.table(tidyData,"./AverageGroupedData.txt",row.names = FALSE)

#################################################################################################################
#################################################################################################################
#################################################################################################################


