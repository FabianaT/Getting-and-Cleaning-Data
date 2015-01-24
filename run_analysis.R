############################################################################
##### 1. Merges the training and the test sets to create one data set.
############################################################################

## Read all data from files
features <- read.table("./UCI-HAR-Dataset/features.txt", stringsAsFactors = FALSE) 
activities <- read.table("./UCI-HAR-Dataset/activity_labels.txt", stringsAsFactors = FALSE) 
colnames(features) <- c("Feature.Code", "Feature.Name")
colnames(activities) <- c("Activity.Code", "Activity.Name")

y_train <- read.table("./UCI-HAR-Dataset/train/y_train.txt", stringsAsFactors = FALSE) 
X_train <- read.table("./UCI-HAR-Dataset/train/x_train.txt", stringsAsFactors = FALSE) 
subject_train <- read.table("./UCI-HAR-Dataset/train/subject_train.txt", stringsAsFactors = FALSE) 

y_test <- read.table("./UCI-HAR-Dataset/test/y_test.txt", stringsAsFactors = FALSE) 
X_test <- read.table("./UCI-HAR-Dataset/test/x_test.txt", stringsAsFactors = FALSE) 
subject_test <- read.table("./UCI-HAR-Dataset/test/subject_test.txt", stringsAsFactors = FALSE) 

## Merge vertically all similar sets
allXs <- rbind(X_train, X_test)
allYs <- rbind(y_train, y_test)
allSubjects <- rbind(subject_train, subject_test)

colnames(allSubjects) <- "Subject"

## Add as new collums the activity code and the subject Id

setComplete <- allXs
setComplete$Activity.Code <- allYs[,1]
setComplete$Subject <- allSubjects[,1]

# Checking data:
# dim(setComplete)
# str(setComplete)
# summary(setComplete)

############################################################################
##### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
############################################################################

library(dplyr)
library(tidyr)

## Rename columns
featuresNames <- as.character(features[,2])
featuresNames <- make.names(featuresNames, unique=TRUE)
features$Unique.Name <- featuresNames
colnames(setComplete)[1:561] <- featuresNames

completeDataTbl <- tbl_df(setComplete)

selectedDataTbl <- select(completeDataTbl, contains("mean"), contains("std"), Activity.Code, Subject)

############################################################################
##### 3. Uses descriptive activity names to name the activities in the data set
############################################################################

# Add new column for activity name
selectedDataTbl <- mutate(selectedDataTbl, Activity.Name = as.character(Activity.Code))

# Function returns activity name associated to an activity code

getActivityName <- function(activityCode){
	activities[activityCode, "Activity.Name"]
}

# Call function getActivityName to replace the activity name (based on activity code)
selectedDataTbl <- mutate(selectedDataTbl, Activity.Name = getActivityName(Activity.Code))

############################################################################
##### 4. Appropriately labels the data set with descriptive variable names. 
############################################################################

# Already done on step 2.

############################################################################
##### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
############################################################################

averagesBySubject <- selectedDataTbl %>%
			group_by(Subject, Activity.Code, Activity.Name) %>%
			summarise_each(funs(mean))


############################################################################
##### 6. Save the tidy data
############################################################################

write.table(averagesBySubject , "tidyData.txt", sep=" ")