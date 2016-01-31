#Remember to place this script at the same level as the "data" folder 

# Step 1. Merges the training and the test sets to create one data set.

trainingData <- read.table("./data/train/X_train.txt")

trainingLabel <- read.table("./data/train/y_train.txt")
table(trainingLabel)

trainSubject <- read.table("./data/train/subject_train.txt")
testData <- read.table("./data/test/X_test.txt")

testLabel <- read.table("./data/test/y_test.txt") 
table(testLabel) 

testSubject <- read.table("./data/test/subject_test.txt")
mergedData <- rbind(trainingData, testData)


joinLabel <- rbind(trainingLabel, testLabel)

joinSubject <- rbind(trainSubject, testSubject)


# Step 2. Extract the mean and standard deviation for each measurement


features <- read.table("./data/features.txt")
dim(features)  # 561 rows, 2 columns
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66
mergedData <- mergedData[, meanStdIndices]
dim(mergedData) # 10299 rows, 66 columns
names(mergedData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # take out "()"
names(mergedData) <- gsub("mean", "Mean", names(mergedData)) 
names(mergedData) <- gsub("std", "Std", names(mergedData)) 
names(mergedData) <- gsub("-", "", names(mergedData)) 

# Step 3. Use descriptive activity names for the dataset

activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step 4. Label the data set with descriptive activity 
# names. 
names(joinSubject) <- "subject"
tidyData <- cbind(joinSubject, joinLabel, mergedData)
dim(tidyData) # 10299 x 68

#save the joint dataset
write.table(tidyData, "merged_data.txt") 

# Step 5. Creates a second, independent tidy data set 
# with the average of 
# each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(tidyData)[2]

result <- matrix(NA, nrow=subjectLen * activityLen, ncol=columnLen) 
result <- as.data.frame(result)

colnames(result) <- colnames(tidyData)

row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == tidyData$subject
        bool2 <- activity[j, 2] == tidyData$activity
        result[row, 3:columnLen] <- colMeans(tidyData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
write.table(result, "dataMeans.txt") 

#check result
data <- read.table("./dataMeans.txt")
