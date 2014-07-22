---
title: "Codebook"
author: "Thomas H"
date: "Tuesday, July 22, 2014"
output: html_document
---
# Introduction

  The R script called run_analysis.R does the following. 
  
- downloads the data from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html)

- Merges the training and the test sets to create one data set.

- Extracts only the measurements on the mean and standard deviation for each measurement. 

- Uses descriptive activity names to name the activities in the data set

- Appropriately labels the data set with descriptive variable names. 

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  The processed tidy data set is exported as csv file.


# The original data set

The original data set is split into a training and a test set (70% and 30%,
respectively). Each part is also split into three files that contains the measurements from the accelerometer and gyroscope, activity label and an identifier for the subject.
  
# run_analysis.R

The script is commented with the different functions and informs about the processed steps.

The script gives the following messages when run, showing the respective phases:

- Downloading and unzipping File not needed (or "Downloading and unzipping File")
- Read all required files and label the datasets
- Combining data
- Extracting data
- Merging data
- Writing tidy data

The script also assumes that `reshape2` library is already installed.

The scripts performs one of the steps described above, in more detail:

* This script merges data from a number of .txt files and produces a tidy data set which may be used for further analysis.

* checks for required packages

* Do download and unzip, if file does not exist.

* Read all required .txt files and label the datasets

* Read all activities

* Read the dataframe's column names and their names and label the aproppriate columns 

* Read the test data and label the dataframe's columns

* Read the training data and label the dataframe's columns

* Read the ids of the test subjects and label the the dataframe's columns

* Read the activity id's of the test data and label the the dataframe's columns

* Read the ids of the test subjects and label the the dataframe's columns

* Read the activity id's of the training data and label the dataframe's columns

* Combine the test subject id's, the test activity id's and the test data into one dataframe

* Combine the test subject id's, the test activity id's and the test data into one dataframe

* Combine the test data and the train data into one dataframe

* Keep only columns refering to mean() or std() values

* Merge the activities datase with the mean/std values dataset to get one dataset with descriptive activity names

* Melt the dataset with the descriptive activity names for better handling

* Cast the melted dataset according to  the average of each variable for each activity and each subject

* Write tidy dataset as csv
