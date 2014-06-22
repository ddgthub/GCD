###############################################################################
#### Getting and Cleaning Data - Coursera - Class Project - run_analysis.R ####
###############################################################################
##
## This script assumes that:
## 1. The raw data file has been downloaded from: 
##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 2. Downloaded zip file 'getdata_projectfiles_UCI HAR Dataset.zip' has been uncompressed 
##    in the working directory and the folder containing the raw files has been renamed to 'UCIHAR'
## 3. Working directory contains the 'run_analysis.R' (this file) and the folder UCIHAR' with 
##    its original folder structure and all the raw .txt files
##
###############################################################################

## Read the raw files
features <- read.table("UCIHAR/features.txt")
subject.train <- read.table("UCIHAR/train/subject_train.txt")
X.train <- read.table("UCIHAR/train/X_train.txt")
Y.train <- read.table("UCIHAR/train/Y_train.txt")
subject.test <- read.table("UCIHAR/test/subject_test.txt")
X.test <- read.table("UCIHAR/test/X_test.txt")
Y.test <- read.table("UCIHAR/test/Y_test.txt")

## Bind the raw sets (training and test) together to form the initial datasets
measurements <- rbind(X.train, X.test)
activities <- rbind(Y.train, Y.test)
subjects <- rbind(subject.train, subject.test)

## Tidy up of the variable names which need to serve as column headers: eliminate 
## parentheses and rename those with "meanFreq" string to enable easier subsetting/elimination later 
features$V2 <- gsub("meanFreq", "mF", features$V2)
## Futhermore, use the make.names function to make sure that the column names are "R-enabled"
colnames(measurements) <- make.names(gsub("\\(.*\\)", "", features$V2))

## There is for sure an automated procedure/function to rename the activities read from the raw files to 
## labels, and had there been more than 6 of them, I would have certainly explored that option
activity.labels <- c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "Standing", "Laying")

## Subset only the data in the columns with mean and standard deviation values
mean.std.data <- measurements[ ,grep("(mean|std)", colnames(measurements))]

## Column bind the subjects and activities to the subsetted measurements in one dataset
Subjects <- subjects$V1
Activities <- activities$V1
data <- cbind(Subjects, Activities, mean.std.data)

## Calculate the average for each subject-activity pair
tidy.data <- data.frame(t(sapply(split(data, list(data$Subjects, data$Activities)), colMeans)))

## Revert activities to factor and apply the labels
tidy.data$Activities <- factor(tidy.data$Activities, labels = activity.labels)

## Export the final tidy data as a text file 
write.table(tidy.data, file = "Samsung_final_tidy_data.txt", sep = "\t", row.names = F)