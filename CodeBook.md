## CodeBook

The data used in this assignment was linked to from the course website and represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Please refer to the README.txt file in the original zipped file for a full description of the original dataset.

First, column names were appended to each file based on the contents of the files ("subject" for the "subject" files and "activity" for the "y" files). For the "X" files, the "features.txt" file was used as the source of the column names.

Then, the three main files (X, y, and subject) in each of the two folders (train and test) were combined into one file for each folder using cbind.

After which, those two files were combined into one main file using rbind.

A new data set was created including the subject, activity and those fields with mean and standard deviation (using "grep" to select those columns with mean() and std() in the column names).

Using the data provided in the "activity_label.txt" file, the coded activity data was updated to activity descriptions.

Finally, using the dplyr package, the data frame was converted into a data table and summarized with the mean of each remaining variable for each activity and each subject.
