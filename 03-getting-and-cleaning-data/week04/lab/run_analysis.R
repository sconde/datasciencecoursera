# File: run_analysis.R
# Author: Sidafa Conde
# Email: sconde@umassd.edu
# School: UMass Dartmouth
# Date: 03/17/2017
# Purpose: Getting and Cleaning Data Course Project
# does the following:
    #1. Merges the training and the test sets to create one data set.
    #2. Extracts only the measurements on the mean and standard deviation for each measurement.
    #3. Uses descriptive activity names to name the activities in the data set
    #4. Appropriately labels the data set with descriptive variable names.
    #5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2);
outputfileName <- "tidy.txt";
citeAddress <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
fileName <- "getdata_dataset.zip";
direcName <- "UCI HAR Dataset";

# download the file if it does not exist
if (!file.exists(fileName)){ download.file(citeAddress, fileName, method="curl");}
if (file.exists(fileName)){ unzip(fileName);}
#make sure everything worked
#stopifnot(!dir.exists(direcName));

#load activity/features
activityLabel <- read.table(paste(direcName, "activity_labels.txt", sep="/"));
activityLabel[,2] <- as.character(activityLabel[,2]);
features <- read.table(paste(direcName, "features.txt", sep = "/"));
features[,2] <- as.character(features[,2]);

#get only the data for mean/std-dev
grepFeature <- grep(".*mean.*|.*std.*", features[,2])
grepFeature.names <- features[grepFeature,2]
grepFeature.names = gsub('-mean', 'Mean', grepFeature.names)
grepFeature.names = gsub('-std', 'Std', grepFeature.names)
grepFeature.names <- gsub('[-()]', '', grepFeature.names)

#get the training data
trainXData <- read.table(paste(direcName,"train/X_train.txt", sep = "/"))[grepFeature];
trainYData <- read.table(paste(direcName,"train/Y_train.txt", sep = "/"));
trainSubjectData <- read.table(paste(direcName,"train/subject_train.txt", sep = "/"));
trainData <- cbind(trainSubjectData, trainYData, trainXData);

#get the test data
testXData <- read.table(paste(direcName,"test/X_test.txt", sep = "/"))[grepFeature];
testYData <- read.table(paste(direcName,"test/Y_test.txt", sep = "/"));
testSubjectData <- read.table(paste(direcName,"test/subject_test.txt", sep = "/"));
testData <- cbind(testSubjectData, testYData, testXData);

#merge/add labels
data <- rbind(trainData, testData);
colnames(data) <- c("subject", "activity", grepFeature.names);

#convert into factors
data$activity <- factor(data$activity, levels = activityLabel[,1], labels = activityLabel[,2]);
data$subject <- as.factor(data$subject);
data.melted <- melt(data, id = c("subject", "activity"));
data.mean <- dcast(data.melted, subject + activity ~ variable, mean);

#save the clean data to the file "tidy.txt"
write.table(data.mean, outputfileName, row.names = FALSE, quote = FALSE);
