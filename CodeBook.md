###Getting and Cleaning Data Course--Peer Assessment Project CodeBook

This file describes the data cleaning process and the variables used. 

* Original repo site from where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

The data for the project has been downloaded from:  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The unzipped "UCI HAR Dataset" folder has been renamed as "data". It is referred as the "data" folder in this codebook and the *run_analysis.R* script. 

* Steps taken to clean the data in the *run_analysis.R* script:
 
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *trainingData*, *trainingLabel* and *trainSubject* variables respectively.       
 
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in *testData*, *testLabel* and *testsubject* variables respectively.  
 
 3. Merge *testData* to *trainingData* to generate a 10299x561 data frame called *mergedData*. Concatenate *testLabel* to *trainingLabel* to generate a 10299x1 data frame, *joinLabel*. Concatenate *testSubject* to *trainSubject* to generate a 10299x1 data frame, *joinSubject*.  
 
 4. Read the features.txt file from the "/data" folder and store the data in a variable called *features*. We extract the measurements on the mean and standard deviation, resulting in a 66 indices list. We get a subset of *mergedData* with the 66 corresponding columns.  
 
 5. Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.   
 
 6. Read the activity_labels.txt file from the "./data"" folder and 
 store the data in a variable called *activity*.  
 
 7. Clean the activity names in the second column of *activity*, all names are transformed to lower case. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore (this is called camelCase format).  
 
 8. Transform the values of *joinLabel* according to the *activity* data frame.  Combine the columns of *joinSubject*, *joinLabel* and *mergedData* to get a tidy 10299x68 data frame, *tidyData*. Assign the names subject and activity to the first two columns. The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.  
 
 9. Write the *tidyData* out to "merged_data.txt" file in the current working directory (same level as "run_analysis.r" and the "data" folder).
 
 10. Generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 180 combinations corresponding to 30 unique subjects with 6 unique activities. For each combination of subject and activity, we calculate the mean of each measurement. After initializing the *result* data frame and looping through the data, we get a 180x68 data frame.
 
 11. Write the *result* out to "dataMeans.txt" file in current working directory. 