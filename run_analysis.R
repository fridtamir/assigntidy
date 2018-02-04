# check if packages installed/installing and opening packages
if (!"reshape2" %in% installed.packages()) {
        install.packages("reshape2")
}
library("reshape2")

if (!"data.table" %in% installed.packages()) {
        install.packages("data.table")
}
library("data.table")

if (!"dplyr" %in% installed.packages()) {
        install.packages("dplyr")
}
library("dplyr")



#check if a new folder "assigntidy" exists, if not create it.
if(!file.exists("assigntidy")){ 
        dir.create("./assigntidy")
        
}
setwd("./assigntidy")

#download zip file and unzip it.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./data.zip")
unzip("./data.zip", exdir = getwd())

## read relevant data 
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")


# 1. Merges the training and the test sets to create one data set.
dataset <- rbind(x_train,x_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanstd <- grep("[Mm]ean()|[Ss][Tt][Dd]()", features[, 2]) 
dataset <- dataset[,meanstd]


# 3. Uses descriptive activity names to name the activities in the data set
        
        #bind activities and subject together

activity <- rbind(y_train, y_test)
subject <-  rbind(subject_train, subject_test)
        #use the descriptive factors from activity labels.
activitygp <- factor(activity[,1])
levels(activitygp) <- activity_labels[,2]

# 4. Appropriately labels the data set with descriptive variable names.
cleannames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataset) <- cleannames[meanstd]

dataset <- cbind(subject, activity, dataset)
names(dataset)[1] <- "subjects"
names(dataset)[2] <- "activity"

#apply the factors for labels 
dataset$activity <- activitygp

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meltdataset <- melt(dataset, (idvars = c("subjects", "activity")))
tidy_data <- dcast(meltdataset, subjects + activity ~ variable, mean)
names(tidy_data)[-c(1:2)] <- paste("[mean of]" , names(tidy_data)[-c(1:2)] )

# writing a data set 
write.table(tidy_data, "tidy_data.txt", sep=",")
