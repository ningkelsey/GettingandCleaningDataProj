setwd("~/r/gcd")
#load file
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,getdata_dataset.zip,method="curl")
unzip(getdata_dataset.zip)

#load data
feature<-read.table("UCI HAR Dataset/features.txt")
dt1<-read.table("UCI HAR Dataset/train/X_train.txt")
names(dt1)<-gsub("[^A-Za-z///' ]","",feature[,2])
int<-dt1[,grepl("mean|std",names(dt1))]
xtr<-int[,!grepl("Freq",names(int))]
actidtr<-read.table("UCI HAR Dataset/train/Y_train.txt")
idtr<-read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(idtr,actidtr,xtr)
colnames(train)<-c("id","activity",names(xtr))

dt2<-read.table("UCI HAR Dataset/test/X_test.txt")
names(dt2)<-gsub("[^A-Za-z///' ]","",feature[,2])
int<-dt2[,grepl("mean|std",names(dt2))]
xte<-int[,!grepl("Freq",names(int))]
actidte<-read.table("UCI HAR Dataset/test/Y_test.txt")
idte<-read.table("UCI HAR Dataset/test/subject_test.txt")
test<-cbind(idte,actidte,xte)
colnames(test)<-c("id","activity",names(xte))

#Merge data

dt<-rbind(train,test)

#Creat dataset with averages of all the variables
data-ave <- ddply(dt, .(id, activity), function(x) colMeans(x[, 3:68]))

write.table(data-ave,"tidy.txt",row.names=FALSE, quote=FALSE)


