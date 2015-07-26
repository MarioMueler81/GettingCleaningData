library(data.table)

#Step 1
#Merges the training and the test sets to create one data set.

#load the training set
#table of subject-id
c_id <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="sub.id")

#table of activity-id
c_act <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names="act.id")

#list of headers for X_train
c_dataheader <- read.table("./UCI HAR Dataset/features.txt")

#training-data connected with the headers - only 2nd column of c_dataheader
c_data <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=c_dataheader[,2])

#create a big table with training data
t_train <- cbind(c_id,c_act,c_data)

#load the test set
#table of subject-id
c_id2 <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="sub.id")

#table of activity-id
c_act2 <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names="act.id")

#list of headers for X_train
c_dataheader2 <- read.table("./UCI HAR Dataset/features.txt")

#training-data with the headers - only 2nd column of c_dataheader2
c_data2 <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=c_dataheader2[,2])

#create a big table with test-data
t_test <- cbind(c_id2,c_act2,c_data2)

#bind the rows of the two tables with the train and test data
big_data <- rbind(t_train,t_test)

#Step2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
# grep all colums with mean, std and the first two ids
big_data = big_data[,grep ("mean|std|act|sub", names(big_data))]

# drop colums with meanFreq
big_data = big_data[,-grep ("meanFreq", names(big_data))]

#Step3
#Uses descriptive activity names to name the activities in the data set

#replace activity-id with the describing and renaming the header
t_actlab <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
big_data$act.id = factor (big_data$act.id, levels=c(1, 2, 3, 4, 5, 6), labels=t_actlab[,2])
setnames(big_data,"act.id","activity")

#Step4
#Appropriately labels the data set with descriptive variable names. 
#This was already done in Step 1 with the headers in the file 'features.txt'

#Step 5
#Create a second, independent tidy data set with the average of each variable for each activity and each subject.

#group activity and subject and calculate the mean (avg) of the variables
library(dplyr)
big_data <- group_by (big_data,activity,sub.id) %>% summarise_each(funs(mean))

#reshaping the data with the function 'melt'
#the many columns of measurement will be compressed in one column 'measurement'
library(reshape2)
tiny_data <- melt(big_data, id=c("activity","sub.id"), variable.name="measurement", value.name="mean.value") 

#save the data in a txt-file for the coursera-homework-frame
write.table (tiny_data, file="tiny_data.txt", row.names=FALSE)
