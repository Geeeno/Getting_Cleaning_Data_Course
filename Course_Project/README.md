# Getting and Cleaning Data Course Project
This repository contains my solution for the "Getting and Cleaning Data" course assignment.
## Description of the assignment
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Assignment solution
To run the analysis and to have a tidy data set, follow these steps:
- Download the file from this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
- Extract the downloaded file in your working directory.
- Copy the following files in your working directory: "cleaning_functions.R", "run_analysis.R".
- Load the source "run_analysis.R" at your session in R, with `source("run_analysis.R")`.
- Execute 'run.analysis()' in R.

`analysis.run()` uses the functions from "analysis_functions.R", and generates a file called "tidy_dataset.txt" in your working directory.
