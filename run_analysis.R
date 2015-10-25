## Assume that the following has been done to download and unzip the source files:
## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
## unzip("getdata-projectfiles-UCI HAR Dataset.zip")

run_analysis <- function () {
## Merges the training and the test sets to create one data set. (STEP 1)
    train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
    train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
    train_s <- read.table("UCI HAR Dataset/train/subject_train.txt")
    train_data <- cbind(train_x, train_y, train_s)

    test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
    test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
    test_s <- read.table("UCI HAR Dataset/test/subject_test.txt")
    test_data <- cbind(test_x, test_y, test_s)

    full_data <- rbind(train_data, test_data)

## Extracts the measurements on the mean and standard deviation for each measurement.  (STEP 2)
    features <- read.table("UCI HAR Dataset/features.txt")
    mean_fields <- grep("mean[()]", features$V2)
    std_fields <- grep("std[()]", features$V2)
    ms_data <- full_data[, sort(c(mean_fields, std_fields, 562, 563))]

## Uses descriptive activity names to name the activities in the data set. (STEP 3)
    act_lbl <- read.table("UCI HAR Dataset/activity_labels.txt")
    ms_data$V1.1 <- as.factor(act_lbl$V2[ms_data$V1.1])

## Appropriately labels the data set with descriptive variable names.  (STEP 4)
    feat_names <- as.vector(features$V2[sort(c(mean_fields, std_fields))])
    colnames(ms_data) <- c(feat_names, "activity", "subject")

## From the data set above, creates a second, independent tidy data set with the
## average of each variable for each activity and each subject. (STEP 5)
    if(!("dplyr" %in% installed.packages()[,"Package"])) {
        install.packages("dplyr")
    }
    require(dplyr)

## Convert data frame to a data table
    ms_dt <- tbl_df(ms_data)
    sum_dt <- summarize_each(group_by(ms_dt, subject, activity), funs(mean))

    write.table(sum_dt, file = "final.txt", row.names = FALSE)
}
