#Download Dataset
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, destfile = "file.zip", method = "curl")
unzip("file.zip")

#1. Merges the training and the test sets to create one data set.
library(data.table)
library(dplyr)
#read data
dat1 <- fread("UCI HAR Dataset//train//X_train.txt")
dat2 <- fread("UCI HAR Dataset//test//X_test.txt")
dat_all <- rbind(dat1, dat2)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
feature <- fread("UCI HAR Dataset//features.txt")
num_mean <- grepl("mean()", feature$V2)
num_std <- grepl("std()", feature$V2)
l <- num_mean | num_std
dat_new <- dat_all[, l, with=FALSE]

#4. Appropriately labels the data set with descriptive variable names.
fname <- feature$V2[l]
fname <- gsub("mean", "Mean", fname) 
fname <- gsub("std", "Std", fname) 
fname <- gsub("[()-]", "", fname) 
names(dat_new) <- fname

#3. Uses descriptive activity names to name the activities in the dataset
#read label
act1 <- fread("UCI HAR Dataset//train//y_train.txt")
act2 <- fread("UCI HAR Dataset//test//y_test.txt")
label <- fread("UCI HAR Dataset//activity_labels.txt")
act_all <- rbind(act1, act2)
dat_with_activity <- cbind(act_all, dat_new)
dat_with_activity <- rename(dat_with_activity, "activity" = "V1")
dat_with_activity$activity <- factor(dat_with_activity$activity, 
                                     levels = c(1,2,3,4,5,6), 
                                     labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#5. Independent tidy data set with the average of each variable for each activity and each subject
id1 <- fread("UCI HAR Dataset//train//subject_train.txt")
id2 <- fread("UCI HAR Dataset//test//subject_test.txt")
id_all <- rbind(id1,id2)
dat_with_id <- cbind(id_all, dat_with_activity)
dat_with_id <- rename(dat_with_id, "subjectID" = "V1")
dat_with_id <- arrange(dat_with_id, subjectID)

dat_melt <- melt(dat_with_id, id = c("subjectID", "activity"))
dat_final <- dcast(dat_melt, subjectID + activity ~ variable, mean)
write.table(dat_final, "tidydata.txt", row.names=FALSE)
