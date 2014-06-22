Course Project CodeBook
=========================================================

### Getting & Cleaning Data, Coursera Data Science, June 2014


#### Origin of the raw data

This project works with the data from _Human Activity Recognition Using Smartphones_. The original data is available from the **Center for Machine Learning and Intelligent Systems** website: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The original study collected activities data on 30 human subjects (ages from 19-48) on pre-installed accelerometers and gyroscopes on Samsung Galaxy S2 phones. This project aims to examine the categorical means of variables (column in the numerical data set). The dataset consists of measurements on 30 subjects while performing 6 activities: 

1) walking   
2) walking upstairs     
3) walking downstairs    
4) standing   
5) sitting   
6) laying  


#### Raw data structure

The script **run_analysis.R** assumes that all the necessary data is in a folder called **UCIHAR** on the working directory. This folder conserves the original structure from the downloaded ZIP file:

features.txt - List of all features     
train/X_train.txt - Training set      
train/y_train.txt - Training labels     
test/X_test.txt - Test set     
test/y_test.txt - Test labels      
train/subject_train.txt     
test/subject_test.txt      


#### Variables used in the **run_analysis.R** script

* X.train - data.frame with raw data from X_train.txt
* X.test - data.frame with raw data from X_test.txt
* features - data.frame with the raw data from features.txt
* Y.train - data.frame with raw data from y_train.txt (labels)
* Y.test - data.frame contains the raw data from y_test.txt (labels)
* subject.train - data.frame with raw data from subject_train.txt
* subject.test - data.frame with the raw data from subject_test.txt
* activities - data.frame resulting from `rbind`-ing of Y.train and Y.test
* subjects - data.frame resulting from `rbind`-ing of subject.train and subject.test
* measurements - data.frame resulting from `rbind`-ing of X.train and X.test
* activity.labels -  vector resulting from concatenating manually formated labels from activity_labels.txt
* Subjects - integer vector resulting from subsetting the `subjects` dataframe
* Activities - integer vector resulting from subsetting the `activities` dataframe
* mean.std.data - data.frame which contains only measurements on the mean and standard deviation for each measurement
* data - data.frame resulting from `cbind`-ing of Subjects, Activities and mean.std.data dataframes
* tidy.data - data.frame which contains a tidy data set with the average of each variable for each activity-subject pair


#### Variable Naming Choices

Various code styles and naming strategies were discussed on the forums. My assesment was that the variable names **(features$V2)** were sufficiently descriptive and the only thing needed was the elimination of parentheses. My personal preference goes to "camel naming" instead of all lowercase variable names, for legibility reasons. To further ensure that the column names will not create problems in R, I used the `make.names` function.


#### Output Data

The tidy dataset was created as a **Samsung_final_tidy_data.txt** file with a `write.table` command.

The tidy data set contains average measurements of means and standard deviations in the subset of 65 variables (columns) of the original 561:

tBodyAcc.mean.X        
tBodyAcc.mean.Y       
tBodyAcc.mean.Z	
tBodyAcc.std.X	
tBodyAcc.std.Y	
tBodyAcc.std.Z	
tGravityAcc.mean.X	
tGravityAcc.mean.Y	
tGravityAcc.mean.Z	
tGravityAcc.std.X	
tGravityAcc.std.Y	
tGravityAcc.std.Z	
tBodyAccJerk.mean.X    	
tBodyAccJerk.mean.Y    	
tBodyAccJerk.mean.Z    	
tBodyAccJerk.std.X    	
tBodyAccJerk.std.Y    	
tBodyAccJerk.std.Z    	
tBodyGyro.mean.X	
tBodyGyro.mean.Y	
tBodyGyro.mean.Z	
tBodyGyro.std.X   	    
tBodyGyro.std.Y    	
tBodyGyro.std.Z    	
tBodyGyroJerk.mean.X    	
tBodyGyroJerk.mean.Y    	
tBodyGyroJerk.mean.Z    	
tBodyGyroJerk.std.X    	    
tBodyGyroJerk.std.Y    	
tBodyGyroJerk.std.Z    	
tBodyAccMag.mean	
tBodyAccMag.std	
tGravityAccMag.mean   	
tGravityAccMag.std   	
tBodyAccJerkMag.mean    	
tBodyAccJerkMag.std	   
tBodyGyroMag.mean    	
tBodyGyroMag.std    	
tBodyGyroJerkMag.mean    	
tBodyGyroJerkMag.std    	
fBodyAcc.mean.X	   
fBodyAcc.mean.Y   	
fBodyAcc.mean.Z	
fBodyAcc.std.X	
fBodyAcc.std.Y	
fBodyAcc.std.Z	
fBodyAccJerk.mean.X    	
fBodyAccJerk.mean.Y   	
fBodyAccJerk.mean.Z    	
fBodyAccJerk.std.X    	
fBodyAccJerk.std.Y    	
fBodyAccJerk.std.Z    	
fBodyGyro.mean.X    	
fBodyGyro.mean.Y    	
fBodyGyro.mean.Z    	
fBodyGyro.std.X    	
fBodyGyro.std.Y    	
fBodyGyro.std.Z    	
fBodyAccMag.mean   	
fBodyAccMag.std   	
fBodyBodyAccJerkMag.mean   	
fBodyBodyAccJerkMag.std	    
fBodyBodyGyroMag.mean    	
fBodyBodyGyroMag.std   	
fBodyBodyGyroJerkMag.mean   	
fBodyBodyGyroJerkMag.std    
