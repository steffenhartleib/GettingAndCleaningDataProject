

library(dplyr)
library(tidyr)
# merge training and test data sets
trainSet <- read.table("X_train.txt", header = FALSE, sep = "")
testSet <- read.table("X_test.txt", header = FALSE, sep = "")
fullSet <- rbind(trainSet, testSet)

# clean column names
columnNames <- read.table("features.txt", header = FALSE, sep = "")
columnNamesClean <- gsub("\\(","",columnNames$V2)
columnNamesClean2 <- gsub("\\)","",columnNamesClean)
columnNamesClean3 <- gsub("\\-","",columnNamesClean2)
columnNamesClean4 <- gsub("\\,","",columnNamesClean3)

# add columnames to
colnames(fullSet) <- columnNamesClean4 # adding column names
        
# select mean and standard deviation columns for each measurement
meanSet <- select(fullSet,contains("mean"))
stdSet <- select(fullSet, contains("std"))
meanStdSet <- cbind(meanSet,stdSet)

# combine training and test subject columns
trainSubject <- read.delim("subject_train.txt", header = FALSE)
testSubject <- read.delim("subject_test.txt", header = FALSE)
subject <- rbind(trainSubject,testSubject)

# combine training and test activity columns
trainLabels <- read.delim("Y_train.txt", header = FALSE)
testLabels <- read.delim("Y_test.txt", header = FALSE)
activity <- rbind(trainLabels,testLabels)

# add subject & activity columns 
meanStdSubActSet <- cbind(subject,activity, meanStdSet)

# add descriptive Activity labels
activityLabels <- read.delim("activity_labels.txt", header = FALSE)
meanStdSubActSet[,2] <- factor(meanStdSubActSet[,2], levels = c(1,2,3,4,5,6), labels = activityLabels$V1)

# add descriptive Variable names
names(meanStdSubActSet)[1] <- "Subject"
names(meanStdSubActSet)[2] <- "Activity"

# create new set calculating means
tidySet <- tbl_df(meanStdSubActSet)
tidySetGr <- group_by(tidySet,Subject, Activity)
tidySetGrM <- summarise_each(tidySetGr,funs(mean))

# add "mean" to variable names
names(tidySetGrM)<-paste("mean",names(tidySetGrM),sep ="")
names(tidySetGrM)[1] <- "Subject"
names(tidySetGrM)[2] <- "Activity"
write.table(tidySetGrM, file = "tidySetGrM.txt", row.name = FALSE)

# see the final tidy table:
finalTable <- read.table("tidySetGrM.txt", header = TRUE)
View(finalTable)




