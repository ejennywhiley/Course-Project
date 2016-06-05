##This is a script for the Coursera Getting and Cleaning Data Course, Wk 4 course project
##J.Whiley Jun 3, 2016

##First make sure that the working directory is the one where the CourseProject folder is located
setwd("C:/Users/username/Coursera_DataSci/Getting_Cleaning_Data/CourseProject")

##Load all datasets into data tables
ActivityLabel<-read.table("UCI_HAR_Dataset/activity_labels.txt", col.names = c("Activity_ID", "Activity_Name"))
Features<-read.table("UCI_HAR_Dataset/features.txt", col.names = c("Feature_ID", "Feature_Name"))

TrainSet<-read.table("UCI_HAR_Dataset/train/x_train.txt", col.names = Features$Feature_Name) ##label columns with descriptive variable names
TrainLabels<-read.table("UCI_HAR_Dataset/train/y_train.txt", col.names="Activity_ID")
TrainSubject<-read.table("UCI_HAR_Dataset/train/subject_train.txt", col.names="Subject")

TestSet<-read.table("UCI_HAR_Dataset/test/x_test.txt", col.names = Features$Feature_Name) ##label columns with descriptive variable names
TestLabels<-read.table("UCI_HAR_Dataset/test/y_test.txt", col.names="Activity_ID")
TestSubject<-read.table("UCI_HAR_Dataset/test/subject_test.txt", col.names="Subject")

##Merge training datasets, add column to label this as training group, then add descriptive Activity Names
TrainData<-cbind(TrainLabels, TrainSubject, Group="Train", TrainSet)
TrainData<-merge(ActivityLabel, TrainData, by="Activity_ID")
##Merge test datasets and add column to label this as test group, then add descriptive Activity Names
TestData<-cbind(TestLabels, TestSubject, Group="Test", TestSet)
TestData<-merge(ActivityLabel, TestData, by="Activity_ID")

##Combine training and test datasets together
TotalData<-rbind(TrainData, TestData)

library(plyr)
library(dplyr)
TotalData<-tbl_df(TotalData)

##Extract only measurements on mean ("mean") and standard deviation ("std") for each measurement
ColSelect<-grepl("mean",names(TotalData)) | grepl("std",names(TotalData)) ##gives F or T for each column name as to whether contains string "mean" or "std"

## But want to keep the first 4 columns as these contain descriptive info for each record, so set these to T
ColSelect[1:4]<-"TRUE"

##Use ColSelect vector to return only required columns from TotalData data frame
TotalData<-TotalData[ColSelect==T] ##This is the final data set for the first part of the Course Project
write.table(TotalData, file="TotalData.txt", row.name=F) ##write data table to directory

##From the data set above, creates a 2nd data set with the average of each variable for each activity and each subject
##To do this we need to average the rows that correspond to each activity-subject pair

##First add a new column to contain the activity-subject pairs
Activity_Subject_Pair <- paste(TotalData$Activity_Name,"_",TotalData$Subject)
TotalDataSummary<-cbind(Activity_Subject_Pair, TotalData)
##Remove cols 2 through 5 as not needed any longer
TotalDataSummary<-select(TotalDataSummary, -(2:5))

##Then calculate the mean of each column variable for each factor level of the Activity_Subject_Pair
TotalDataSummary<-ddply(TotalDataSummary,.(Activity_Subject_Pair),colwise(mean, is.numeric))
##Update column names to add "Mean_" prefix for variables that had a mean calculated
NewNames<-paste("Mean_", colnames(TotalDataSummary[2:80]))
NewNames<-c(colnames(TotalDataSummary[1]),NewNames)
colnames(TotalDataSummary)<-NewNames ## this is the final data set for the second part of the Course Project
write.table(TotalDataSummary, file = "TotalDataSummary.txt", row.name=F) ##write data table to directory


