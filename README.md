### Getting and Cleaning Data Course Project README

The goal of this project is to prepare tidy data that can be used for later analysis and to demonstrate an ability to collect, work with, and clean a data set.

## Relevant Project files
* README.md
* CodeBook.md
* run_analysis.r
* UCI HAR Dataset.zip

## Project Overview
In this Git repo, there is an R script titled, "run_analysis.R", that works to gather and clean certain measurements from a folder of untidy data.
This untidy data, which can be downloaded from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), comes from several experiments by volunteers performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on their waist. The included R script tidies this data to extract various means and standard deviations for each subject volunteer while they perform each activity.

When you unzip the untidy data at the link above to obtain the "UCI HAR Dataset" folder in your working directory, you will find it contains various text files detailing the different activities performed and the features measured through the wearable technology. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. These can be found in the test and train folders of the dataset.

The run_analysis.R script will work to label the untidy training and test datasets, extract only desired mean and standard deviation features, merge the two sets, and then finally summarize the mean and standard deviation measurements for each subject performing each activity and save the final tidy set in a text file named "tidy_data.txt".
