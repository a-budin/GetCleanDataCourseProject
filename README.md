


**This repository is created according to coursera.org "Getting and Cleaning Data Course" project assignment**

There are following files in that repo:

#### R scripts:

* run_analysis.R - contains R script that downloads, unpacks orginal data and transforms it accorging the assignment

There are two options to run this script:

1. Run entire script
In this case original data set will be downloaded, extracted and all needed actions with data will be done. 

As a result you get:

*two objects*
  
  * main_set - main data set that is created according to steps 1 to 4 of the assingment (data set based on original one that merges the training and the test, contains only the measurements on the mean and standard deviation for each measurement, uses descriptive activity names to name the activities in the data set, appropriately labels the data set with descriptive variable names)
  * set_of_averages - independent tidy data set based on dataset main_set with the average of each variable for each activity and each subject.

*and three files:*
  
  * averages_std_mean.csv - data set based on original one that merges the training and the test, contains only the measurements on the mean and standard deviation for each measurement, uses descriptive activity names to name the activities in the data set, appropriately labels the data set with descriptive variable names.
  * averages_std_mean.txt - the same as above, but in txt format and with row.names = FALSE
  * std_mean_all.csv - creates a second, independent tidy data set based on dataset in file "averages_std_mean.csv" with the average of each variable for each activity and each subject.



2. Run a script starting from section "# 1 Merge the training and the test sets of original dataset to create one data set."

In that case it is expected that original data set is downloaded and extracted, Working directory is set to one where "UCI HAR Dataset" directory is stored.

The same objects and files are created as in option 1 above.

#### CodeBook:

* CodeBook.md - indicates all the variables and summaries calculated, along with units, and any other relevant information

#### Cleaned Data:

* averages_std_mean.csv - data set based on original one that merges the training and the test, contains only the measurements on the mean and standard deviation for each measurement, uses descriptive activity names to name the activities in the data set, appropriately labels the data set with descriptive variable names.

* averages_std_mean.txt - the same as above, but in txt format and with row.names = FALSE


* std_mean_all.csv - creates a second, independent tidy data set based on dataset in file "averages_std_mean.csv" with the average of each variable for each activity and each subject.


#### Readme info

* README.md - overview of files