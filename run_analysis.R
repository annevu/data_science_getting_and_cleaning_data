# Install data.table package if not already 
if (!require("data.table")) {
  install.packages("data.table")
}
# Load data.table package
library(data.table)

# Read in different activities 
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
# Read labels of in different measurements(features) in dataset
features <- read.table("UCI HAR Dataset/features.txt")[,2]
# Determine which features we want to extract - only those containing mean() or std()
extractmeasures <- grepl("mean\\(\\)|std\\(\\)", features)

# Read in Activities from Test Group
testactivities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="activityid")
# Add Activity Label column to test activities data set by referencing activityLabels using activityid
testactivities$activitylabel = activitylabels[testactivities$activityid]

# Read in feature data from Test Group
testset <- read.table("UCI HAR Dataset/test/X_test.txt", col.names= features)
# Extract only desired columns using logical factor, extractmeasures
extractedtestset <- testset[, extractmeasures]
# Read in subject data from Test Group
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# Combine subject, activty and feature data for test group
testdata <- cbind(testsubjects, testactivities, extractedtestset)

# Read in Activities from Train Group
trainactivities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="activityid")
# Add Activity Label column to train activities data set by referencing activityLabels using activityid
trainactivities$activitylabel = activitylabels[trainactivities$activityid]
# Read in feature data from Train Group
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", col.names= features)
# Extract only desired columns using logical factor, extractmeasures
extractedtrainset <- trainset[, extractmeasures]
# Read in subject data from train Group
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
# Combine subject, activty and feature data for train group
traindata <- cbind(trainsubjects, trainactivities, extractedtrainset)


# Merge test and train data
mergeddata = rbind(testdata, traindata)

#creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

# Install reshape2 if not already so we can use melt and dcast
if (!require("reshape2")) {
  install.packages("reshape2")
}
library(reshape2)

# Get MeasureVariables by getting all variables in merged data except subject, activityid, and activitylabel
datalabels <- setdiff(colnames(mergeddata), c("subject", "activityid", "activitylabel"))
# Melt data to long format so we can aggregate with dcast
meltdata      = melt(mergeddata, id =  c("subject", "activityid", "activitylabel"), measure.vars = datalabels)
# Convert long format to short format based on aggregated mean
tidydata <- dcast(meltdata, subject + activitylabel ~ variable,mean)

# Write tidy data to text file
write.table(tidydata, file = "./tidy_data.txt")

# Read in tidy data file and View it
# loadedtidy <- read.table("tidy_data.txt");
# View(loadedtidy)
