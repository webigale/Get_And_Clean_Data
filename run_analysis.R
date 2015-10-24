## Assume that the following has been done to download and unzip the source files:
## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
## unzip("getdata-projectfiles-UCI HAR Dataset.zip")
setwd("UCI HAR Dataset")

## Merges the training and the test sets to create one data set and
## appropriately labels the data set with descriptive variable names. 
features <- read.table("features.txt")
feat_lbl <- features$V2

train_x <- read.table("train/X_train.txt")
colnames(train_x) <- feat_lbl
train_y <- read.table("train/y_train.txt")
colnames(train_y) <- c("activity")
train_s <- read.table("train/subject_train.txt")
colnames(train_s) <- c("subject")
train_set <- cbind(train_s, train_y, train_x)
train_set$set <- c("train")

test_x <- read.table("test/X_test.txt")
colnames(test_x) <- feat_lbl
test_y <- read.table("test/y_test.txt")
colnames(train_y) <- c("activity")
test_s <- read.table("test/subject_test.txt")
colnames(test_s) <- c("subject")
test_set <- cbind(test_s, test_y, test_x)
test_set$set <- c("test")

data_set <- rbind(test_set, train_set)

## Extracts the measurements on the mean and standard deviation for each measurement. 
mean_fields <- grep("mean[()]", colnames(data_set))
std_fields <- grep("std[()]", colnames(data_set))
## Column 1 is the Subject, column 2 is the activity, and column 564 is the data set.
short_data <- data_set[, sort(c(1, 2, mean_fields, std_fields, 564))]

## Uses descriptive activity names to name the activities in the data set.
act_lbl <- read.table("activity_labels.txt")
short_data$activity_name <- as.factor(act_lbl$V2[short_data$activity])

## From the data set above, creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

