# Of course before all of this, i have already downloaded the .zip file and unzipped it in working directory

#let's merge the training and test sets
## read test's data
XTest_file<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest_file<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest_file <-read.table("UCI HAR Dataset/test/subject_test.txt")

## read train's data
XTrain_file<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain_file<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain_file <-read.table("UCI HAR Dataset/train/subject_train.txt")

## read features and activity
features_file<-read.table("UCI HAR Dataset/features.txt")
activity_file<-read.table("UCI HAR Dataset/activity_labels.txt")

#############################################################
# part 1 : merge
X<-rbind(XTest_file, XTrain_file)
Y<-rbind(YTest_file, YTrain_file)
Subject_merged<-rbind(SubjectTest_file, SubjectTrain_file)
#############################################################


#############################################################
# part 2 : extract
index<-grep("mean\\(\\)|std\\(\\)", features[,2]) 
length(index) 
X<-X[,index]
#############################################################


#############################################################
# part 3 : uses descriptive activity names to name the activities in the data set
Y[,1]<-activity[Y[,1],2]
#############################################################



#############################################################
# part 4 : labels the data set with descriptive variable names

names<-features[index,2] 
names(X)<-names
names(Subject)<-"Subject_id"
names(Y)<-"Activity"

goodData<-cbind(Subject, Y, X)
head(goodData[,c(1:4)])
#############################################################


#############################################################
# part 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
goodData<-data.table(goodData)
tidyData <- goodData[, lapply(.SD, mean), by = 'Subject_id,Activity'] 
dim(tidyData)

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
head(tidyData[order(Subject_id)][,c(1:4), with = FALSE],12) 
#############################################################