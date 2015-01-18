library(dplyr)

if(!file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                method = "curl")
  unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")  
}

## Load raw data and combine the training and test sets (1a) 
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)
x <- rbind(x_train, x_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = F)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = F)
y <- rbind(y_train, y_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = F)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F)
subject <- rbind(subject_train, subject_test)

## Label with better descriptive variables (4)
features <- read.table("UCI HAR Dataset/features.txt", header = F, colClasses=c('NULL','character'), col.names = c("index","feature"))
colnames(x) <- gsub("\\(\\)", "", features$feature)
colnames(y) <- "activity"
colnames(subject) <- "subject"

## Extract only the mean and std for each measurement (2)
raw <- x[, grepl("-mean-|-std-", names(x))]


## Combine all data into one set (1b)
combined <- cbind(raw, subject, y)

## Replace activity name with descriptive name (3)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = F)
colnames(activity_labels) <- c("activity", "activity_label")
data <- combined %>% 
  left_join(activity_labels) %>%
  select(-activity)

## Average of each variable for each activity and subject (5)
averages <- data %>%
  group_by(subject, activity_label) %>%
  summarise_each(funs(mean))

## Write summary table
write.table(averages, "output.txt", row.name=FALSE)
