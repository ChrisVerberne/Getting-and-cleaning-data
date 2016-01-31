library(dplyr)
#
# Download & read the training and test sets, including features (column names) and activity labels.
#
if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_projectfiles_UCI HAR Dataset.zip")
  unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}
dt_features <- read.table("UCI HAR Dataset/features.txt", check.names=FALSE)
dt_activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
dt_x_test<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = dt_features$V2, check.names=FALSE)
dt_y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
dt_subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
dt_x_train<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = dt_features$V2, check.names=FALSE)
dt_y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")
dt_subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
#
# Assignment1  
# Combine test and training sets into one dataset:
#         - add Y_xxxx.txt and subject_xxxx.txt as additional columns (cbind),
#         - rename these columns to respectively "Y1" for Y_xxxx.txt and "S1" for subject_xxxx.txt and
#         - append resulting test set and train set into the end result for step1 (= dt_both).
#
dt_test<-cbind(dt_y_test, dt_x_test)
colnames(dt_test)[1]<-"Y1"
dt_test<-cbind(dt_subject_test, dt_test)
colnames(dt_test)[1]<-"S1"
#
dt_train<-cbind(dt_y_train, dt_x_train)
colnames(dt_train)[1]<-"Y1"
dt_train<-cbind(dt_subject_train, dt_train)
colnames(dt_train)[1]<-"S1"
#
dt_both<-rbind(dt_test, dt_train) # this data set is the answer to assignment1
#
# Assignment2
# Create a dataset dt_meanstd from dt_both with the columns "S1", "Y1", and the columns containing "std()" or "mean()".
# The dataset dt_meanstd is the answer to assignment2
#
dt_meanstd<-dt_both[,grepl ("mean\\(\\)|std\\(\\)|^Y1|^S1", colnames(dt_both))] # This subset contains 68 columns
#
# Assignment3
# Replace the numeric representation of the activity (column Y1) by it's character representation (i.e. STANDING, ...).
# This will be done in dt_meanstd.
#
v_activitylabels<-as.vector(dt_activitylabels[,2])
dt_meanstd$Y1<-v_activitylabels[dt_meanstd$Y1]
#
# Assignment4
# Appropriately labels the data set with descriptive variable names. The only non-descriptive columns are column 1 (S1) and column 2 (Y1).
# These will be replaced respectively by the decriptive names  "subject" and "activity"
# This will again be done in dt_meanstd.
#
colnames(dt_meanstd)[1] <- "subject"
colnames(dt_meanstd)[2] <- "activity"
#
# Assignment5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# This will be done by grouping by subject and activity, followed by a summarise_each on all columns using function mean.
# The result is in data set tidy.
# 
by_subject_activity<-group_by(dt_meanstd, subject, activity)
tidy<-summarise_each(by_subject_activity, funs(mean))
write.table(tidy, file = "tidy.txt")