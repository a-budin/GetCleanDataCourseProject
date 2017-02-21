# R script that does cleaning and transformation of dataset that can be find by following link.
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# A full description of original dataset is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# This script does following:
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 6 Saves transformed data to csv files
#download and exract files

  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
  unzip("dataset.zip")

# 1 Merge the training and the test sets of original dataset to create one data set.

  # Load data on subjects 

  subjects <- read.csv(file.path("UCI HAR Dataset","train", "subject_train.txt"), col.names = "subject.id", header = FALSE)
  subjects <- rbind(subjects, read.csv(file.path("UCI HAR Dataset","test", "subject_test.txt"), col.names = "subject.id", header = FALSE))
  
  # Load data on activities
  
  activities <- read.csv(file.path("UCI HAR Dataset","train", "y_train.txt"), col.names = "activity.id", header = FALSE)
  activities <- rbind(activities, read.csv(file.path("UCI HAR Dataset","test", "y_test.txt"), col.names = "activity.id", header = FALSE))
  
  # Load column names
  
  column_names <- make.unique(as.character(read.csv(file.path("UCI HAR Dataset", "features.txt"), header = FALSE, sep = " ")[,2]), sep = "-")
  
  # Load main data
  
  train_set <- read.csv(file.path("UCI HAR Dataset","train", "X_train.txt"), col.names = column_names, header = FALSE, sep = "", check.names=FALSE)
  train_set <- rbind(train_set, read.csv(file.path("UCI HAR Dataset","test", "X_test.txt"), col.names = column_names, header = FALSE, sep = "", check.names=FALSE))

  
# 2 Extract only the measurements on the mean and standard deviation for each measurement.
 
   # create a combined dataset 
  library(dplyr)
  
  main_set <- cbind(subjects, activities,select(train_set, grep("std|mean",names(train_set))) )
  
  main_set <- arrange(main_set, subject.id, activity.id)
  
  rm(train_set) # remove large original dataset from memory
  
# 3 Set descriptive activity names to name the activities in the data set

  activity_names <- read.csv(file.path("UCI HAR Dataset", "activity_labels.txt"), 
                             col.names = c("activity.id", "activity.name"), 
                             header = FALSE, sep = " ", 
                             colClasses = "character")
  
  main_set <- mutate(main_set, activity.id = activity_names[activity.id, 2])
  
  main_set <- rename(main_set, activity = activity.id)
  

# 4 Label appropriately the data set with descriptive variable names
  # done in step 1 while loading data
  
# 5 From the data set in step 4, create a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
  
    split_set <- split(main_set, list(factor(main_set$subject.id), factor(main_set$activity)))
                     
    set_of_averages <- sapply(split_set, function(x) {
     colMeans(x[, c(3:ncol(x))])
     })
  
  
# now we save datasets to csv files
    dir.create(file.path("res_dataset"), showWarnings = FALSE)
    
    write.csv(main_set, file = file.path("res_dataset","std_mean_all.csv"),row.names=FALSE, col.names = TRUE)
    write.csv(set_of_averages, file = file.path("res_dataset","averages_std_mean.csv"),row.names=TRUE)
    