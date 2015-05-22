
## Downloading the dataset
if (!file.exists("UCI HAR Dataset"))  {
    dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(dataset_url, "UCI HAR Dataset.zip")
    unzip("UCI HAR Dataset.zip")
    file.remove("UCI HAR Dataset.zip")
}

## 1. Merging the test and train dataset
Xmerged <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"),read.table("UCI HAR Dataset/test/X_test.txt"))
subjectmerged <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),read.table("UCI HAR Dataset/test/subject_test.txt"))
Ymerged <- rbind(read.table("UCI HAR Dataset/train/Y_train.txt"),read.table("UCI HAR Dataset/test/Y_test.txt"))


## 2. 
features <- read.table("UCI HAR Dataset/features.txt")[,2]
index_useful_features <- grep("-mean\\(\\)|-std\\(\\)", features)
Xmerged <- Xmerged[,index_useful_features]
names(Xmerged) <- features[index_useful_features]
names(Xmerged) <- gsub("\\(|\\)", "", names(Xmerged))
names(Xmerged) <- tolower(names(Xmerged))

## 3. Use descriptive activity names to name the activities in the data set
activity <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
activity <- gsub("_", " ", tolower(as.character(activity)))
library(Hmisc) ## Library to capitalise the first letter
activity <- capitalize(activity) ## Comment out this line if Hmisc package is not installed.
Ymerged[,1] <- activity[Ymerged[,1]]
names(Ymerged) <- "activity"

## 4. Appropriately label the data set with descriptive variable names
names(subjectmerged) <- "subject"
cleanData <- cbind(subjectmerged, Ymerged, Xmerged)
write.table(cleanData, "merged_clean_data.txt")

## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
subjects <- unique(subjectmerged)[,1]
lengthSubject <- length(subjects)
lengthActivity <- length(activity)
numberofColumns <- dim(cleanData)[2]
output <- cleanData[1:lengthSubject*lengthActivity,]

rowIndex = 1

for (x in 1:lengthSubject)  {
    for (y in 1:lengthActivity)  {
        output[rowIndex,1] <- subjects[x]
        output[rowIndex,2] <- activity[y]
        temp <- cleanData[cleanData$subject==x & cleanData$activity==activity[y],]
        output[rowIndex,3:numberofColumns] <- colMeans(temp[,3:numberofColumns])
        rowIndex = rowIndex + 1
    }
}
write.table(output,"average_of_dataset.txt",row.names = FALSE)