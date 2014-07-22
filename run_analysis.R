## This script merges data from a number of .txt files and produces 
## a tidy data set which may be used for further analysis.

##check for required packages
if (!require("reshape2") ) {
  print("Please install required package \"reshape2\" before proceeding")
  return
} else {
  
  ## Open required libraries
  library(reshape2)
    
    ## Do download and unzip, if file does not exist.
  myfile <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile="UCI_HAR_data.zip"
    if (!file.exists(zipfile)) {
    message ("Downloading and unzipping File")
    download.file(myfile, destfile=zipfile, method="auto", mode="wb")
    unzip(zipfile)
  } else
  {message ("Downloading and unzipping File not needed")
  }
  
  ## Read all required .txt files and label the datasets
  message("Read all required files and label the datasets")
  ## Read all activities
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_name"))
  ## Read the dataframe's column names and their names and label the aproppriate columns 
  features <- read.table("UCI HAR Dataset/features.txt")
  feature_names <-  features[,2]
  
  ## Read the test data and label the dataframe's columns
  test.X <- read.table("UCI HAR Dataset/test/X_test.txt")
  colnames(test.X) <- feature_names
  
  ## Read the training data and label the dataframe's columns
  train.X <- read.table("UCI HAR Dataset/train/X_train.txt")
  colnames(train.X) <- feature_names
  
  ## Read the ids of the test subjects and label the the dataframe's columns
  test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  colnames(test.subject) <- "subject_id"
  
  ## Read the activity id's of the test data and label the the dataframe's columns
  test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
  colnames(test.y) <- "activity_id"
  
  ## Read the ids of the test subjects and label the the dataframe's columns
  train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  colnames(train.subject) <- "subject_id"
  
  ## Read the activity id's of the training data and label the dataframe's columns
  train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
  colnames(train.y) <- "activity_id"
  
  message("Combining data")
  ##Combine the test subject id's, the test activity id's 
  ##and the test data into one dataframe
  test_data <- cbind(test.subject, test.y, test.X)
  
  ##Combine the test subject id's, the test activity id's and the test data into one dataframe
  train_data <- cbind(train.subject, train.y, train.X)
  
  ##Combine the test data and the train data into one dataframe
  all_data <- rbind(train_data,test_data)
  
  message("Extracting data")
  ##Keep only columns refering to mean() or std() values
  mean_col_idx <- grep("mean()",names(all_data),ignore.case=TRUE)
  mean_col_names <- names(all_data)[mean_col_idx]
  std_col_idx <- grep("std()",names(all_data),ignore.case=TRUE)
  std_col_names <- names(all_data)[std_col_idx]
  meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]
  
  message("Merging data")
  ##Merge the activities datase with the mean/std values dataset to get one dataset with descriptive activity names
  descriptivenames <- merge(activity_labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)
  
  ##Melt the dataset with the descriptive activity names for better handling
  data_melt <- melt(descriptivenames,id=c("activity_id","activity_name","subject_id"))
  
  ##Cast the melted dataset according to  the average of each variable for each activity and each subject
  mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)
  
  message("Writing tidy data")
  ## Write tidy dataset as csv
  write.csv(mean_data, "UCI_HAR_tidy.csv", row.names=FALSE)
  
}
