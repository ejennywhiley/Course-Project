---
title: "CodeBook"
author: "ejw"
date: "June 4, 2016"
output: html_document
---

#Coursera Getting and Cleaning Data Course Project

###Project background
The project requires candidates to tidy and summarise data collected from subjects performing different activities whilst wearing smartphones. This codebook describes the data, variables and transformations applied to get to the (a) the tidy data set and (b) the summarised data set.

###Data files
- The data for the project was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- The downloaded data was extracted into the working directory in a folder called **"UCI_HAR_Dataset"**
- The directory "UCI_HAR_Dataset" contained the following files and sub-directories:
     + 'test/x_test.txt' ... test set of 2,947 observations
     + 'test/y_test.txt' ... test labels
     + 'train/x_train.txt' ... training set of 7,352 observations
     + 'train/y_train.txt' ... training labels
     + 'activity_labels.txt' ... links 6 activity class labels with the activity name
     + 'features.txt' ... list of all 561 features (metrics)
     + 'features_info.txt' ... info on the experimental design, data treatment and feature metric calculation
     + 'README.txt' ... describes data set
- Further information on the data set is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Variables
- Information on the feature variables is available in 'features.txt' and 'features_info.txt' files
- Additional variables added were:
     + 'Group': captures whether subject was part of test or training group
     + 'Activity_ID': class label for the activities
     + 'Activity_Name': descriptive name for the activites
     + 'Feature_ID': class label for the features
     + 'Feature_Name': descriptive title for the features
     + 'Activity_Subject_Pair': unique combination of each subject and each activity
     
###Transformations
This contains details of the steps that are captured within the 'run_analysis.R' code file. Please note that the code is fulled commented within the R script.

#####**Obtaining first data set**
- Load all datasets into data tables using read.table and label columns appropriately. This step gives 8 data frames:
     + 'ActivityLabel'
     + 'Features'
     + 'TrainSet'
     + 'TrainLabels'
     + 'TrainSubject'
     + 'TestSet'
     + 'TestLabels'
     + 'TestSubject'

- Merge training datasets, add column to label this as training group, then add descriptive Activity Names. Resulting data frame is called 'TrainData'.
- Merge test datasets and add column to label this as test group, then add descriptive Activity Names. Resulting data frame is called 'TestData'.
- Combine training and test datasets together to give data frame called 'TotalData'
- load plyr and dplyr
- make a tbl_df from 'TotalData'
- define a vector 'ColSelect' that contains logical values defining columns that should be retained (these are columns containing subject and activity detail, plus features that are either mean or std)
- use 'ColSelect' to filter only the required columns from TotalData, resulting data frame is called 'TotalData'
- 'TotalData' is the final data set required for part 1 of the project and is written to the working directory

#####**Obtaining second data set, which is a summary of first data set containing the mean feature value for each activity and subject**
- Add new column containing activity_subject pairs and save result in new data frame 'TotalDataSummary'
- Remove cols 2 through 5 as no longer needed (info is captured by activity_subject pairs)
- Calculate mean for each feature for each level of activity_subject pair
- Update column names to add "Mean_" prefix for variables that had a mean calculated using 'NewNames' vector
- 'TotalDataSummary' is the final data set required for part 2 of the project and is written to the working directory







