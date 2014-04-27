#setwd("c://Users//usernama//Dropbox//coursera//getdata//exam//")

library("reshape2") 
library("plyr")

#merges

tests <- read.table("test/subject_test.txt")
testx <- read.table("test/X_test.txt")
testy <- read.table("test/y_test.txt")
trains <- read.table("train/subject_train.txt")
trainx <- read.table("train/X_train.txt")
trainy <- read.table("train/y_train.txt")

test <- cbind(tests,testy,testx)
train <- cbind(trains,trainy,trainx)
data <- rbind(train,test)

feats <- read.table("features.txt")
colnames(data) <- c("Subject","ActivityCode",as.vector(feats$V2))

#stats

means <- data[grep("mean()",names(data),fixed=TRUE)]
stds <- data[grep("std()",names(data),fixed=TRUE)]

labels <- read.table("activity_labels.txt")
colnames(labels) <- c("ActivityCode","ActivityName")
data2 <- cbind(join(data[,1:2],labels),means,stds)

#out

tidydata <- melt(data2, id = c("Subject","ActivityCode","ActivityName"))
tidydata2 <- acast(tidydata, variable ~ Subject+ActivityName, mean)

write.csv(tidydata2, file="result.csv",row.names=TRUE)
