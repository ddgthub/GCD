Course Project
===================
### Getting & Cleaning Data, Coursera Data Science, June 2014

The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set, and prepare tidy data that can be used for later analysis. This file contains the description of the transformations performed by **run_analysis.R** script to clean up the raw data.


##### This repo contains 4 files:

* ReadMe.md (this document)
* Samsung_final_tidy_data.txt (the resulting tidy dataset)
* CodeBook.md (description of the variables in the resulting tidy dataset)
* run_analysis.R (R script that perfoms the tidying)

##### Structure of the raw data

A series of measurements from 30 subjects while performing 6 different activities were captured and 561 features (variables) were recorded in the following 6 files:

* 'X_train.txt'  -- (7352 x 561) numerical feature variable vectors
* 'y_train.txt'  -- (7352 x 1) activity labels, coded numerically
* 'subject_train.txt' -- (7252 x 1) subject ID labels labels
* 'X_test.txt'  --  (2947 x 561) numerical feature variable vectors
* 'y_test.txt' -- (2947 x 1) activity labels, coded numerically
* 'subject_test.txt' -- (2947 x 1) sujbect ID labels

Subjects and activity labels were recorded in separate files:

* features.txt
* activity_labels.txt

 
##### R script **run_analysis.R** assumes that:

1. The raw data file has been downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Downloaded zip file **'getdata_projectfiles_UCI HAR Dataset.zip'** has been uncompressed in the working directory and the **folder containing the raw files has been renamed to '_UCIHAR_'**

3. Working directory contains the **'run_analysis.R'** file and the folder **UCIHAR** with its original folder structure and all the raw .txt files

***
#### How does the script tidy the raw data?

***
Read the raw text files with the ``read.table`` function:

```
features <- read.table("UCIHAR/features.txt")    
subject.train <- read.table("UCIHAR/train/subject_train.txt")    
X.train <- read.table("UCIHAR/train/X_train.txt")    
Y.train <- read.table("UCIHAR/train/Y_train.txt")    
subject.test <- read.table("UCIHAR/test/subject_test.txt")    
X.test <- read.table("UCIHAR/test/X_test.txt")    
Y.test <- read.table("UCIHAR/test/Y_test.txt")    
```


***
Bind the raw sets (training and test) together to form the initial datasets:

```{r}
measurements <- rbind(X.train, X.test)
activities <- rbind(Y.train, Y.test)
subjects <- rbind(subject.train, subject.test)
```


***
My assesment was that the variable names **(features$V2)** were sufficiently descriptive and the only thing needed was the elimination of parentheses. To further ensure that the column names will not create problems in R, I used the `make.names` function. Another transformation in this step was to rename column headers with "meanFreq" string pattern to enable the easier subsetting/elimination later with the `grep` function:

```{r}
features$V2 <- gsub("meanFreq", "mF", features$V2)
colnames(measurements) <- make.names(gsub("\\(.*\\)", "", features$V2))
```


***
There is for sure an automated procedure/function to rename the activities read from the raw file into labels, and had there been more than 6 of them, I would have certainly explored that option. To save time, here I simply concatenated the manually formated labels:   

```{r}
activity.labels <- c("Walking", "Walking.Upstairs", "Walking.Downstairs", "Sitting", "Standing", "Laying")
```


***
Subset only the data in the columns with `mean` and `standard` deviation values:

```{r}
mean.std.data <- measurements[ ,grep("(mean|std)", colnames(measurements))]
```


***
Column bind the subjects and activities to the subsetted measurements in one dataset:

```{r}
Subjects <- subjects$V1
Activities <- activities$V1
data <- cbind(Subjects, Activities, mean.std.data)
```


***
Calculate the average for each subject-activity pair:

```{r}
tidy.data <- data.frame(t(sapply(split(data, list(data$Subjects, data$Activities)), colMeans)))
```


***
Revert activities to factor and apply the labels:

```{r}
tidy.data$Activities <- factor(tidy.data$Activities, labels = activity.labels)
```


***
Export the final tidy dataset as a text file:

```{r}
write.table(tidy.data, file = "Samsung_final_tidy_data.txt", sep = "\t", row.names = F)
```
