################################################################################
#
# This function read features.txt and create a vector containing the right names
# of dataset columns
#
################################################################################
right.col.names <- function(){
    # coading features.txt
    feat <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, 
                       col.names = c("features.id", "features.des"), 
                       colClasses = "character")
    # creating the vector with right names for dataset
    c("subject.id", "activity.id", feat$features.des)
}
################################################################################
#
# This function create the right dataset joining the data from the following 
# file: "subject_.txt", "X_.txt", y_.txt". The function input is "train" or 
# "test", the names of two folders that contains the data 
#
################################################################################
data.read <- function(data.type){
    # verifing if the input of the function is right
    if(!(data.type %in% c("test", "train"))){
        stop("invalid input: data.type must be 'test' or 'train'")
    }
    # defining the filepath for the file containing the subjets, the activities 
    # and the measurements 
    subj.path <- paste("./UCI HAR Dataset/", data.type, "/subject_", data.type,
                       ".txt", sep="")
    act.path <- paste("./UCI HAR Dataset/", data.type, "/y_", data.type,
                       ".txt", sep="")
    x.path <- paste("./UCI HAR Dataset/", data.type, "/X_", data.type,
                       ".txt", sep="")
    # reading the file containing the subjets, the activities 
    # and the measurements 
    subj <- read.table(subj.path, header = FALSE, col.names = "subject.id", 
                       colClasses = "integer")
    x.data <- read.table(x.path, header = FALSE, colClasses = "numeric")
    act.data <- read.table(act.path, header = FALSE, col.names = "activity")
    # creating a data set containing the subjets id, the activities id and the 
    # measurements
    merged.set <- cbind(subj, act.data, x.data)
}
################################################################################
#
# This function select the dataset right columns containing, subject_id,  
# activity_id and the measurements on the mean and standard deviation for each
# measurement.
#
################################################################################
select.col <- function(total.dataset){
    # creating a logical vector in wich each element correspond to a data set 
    # column: the elements have TRUE value if the column label contains 'mean' 
    # or 'std', or, if not, they are false
    log.col <- grepl("mean|std", names(total.dataset))
    # counting the number of columns containing 'mean' or 'std'
    num.col <- sum(log.col)
    # creating a vector containing the id of columns that must be selected
    id.col <- as.integer(rep(0, num.col))
    j = 1
    for(i in 1:length(log.col)){
        if(log.col[i] == TRUE){
            id.col[j] <- i
            j <- j + 1
        }
    }
    sel.col <- c(1, 2, id.col)
    # selecting the right column from data set
    total.dataset <- total.dataset[, sel.col]
}
################################################################################
#
# This function creates a new column in dataset with the right description of 
# the activity, based on the activity_id column.
#
################################################################################
create.activity.column <- function(total.dataset){
    library(dplyr)
    # read the file with the activity names
    act.lab <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ", 
                          header = FALSE,
                          col.names = c("activity.id","activity.description"),
                          colClasses = c("integer","factor"))
    # add a new column to data set with activity names
    total.dataset <- merge(act.lab,total.dataset, by = "activity.id")
    # sorting the data set columns, deleting the activity_id label too 
    total.dataset <- total.dataset[,c(3, 2, 4:82)]
    # sorting the data set row
    total.dataset <- arrange(total.dataset, subject.id)
}
################################################################################
#
# This function, starting from total.dataset, creates a second, independent tidy  
# data set with the average of each variable for each activity and each subject
#
################################################################################
tidy.dataset <- function(total.dataset){
    library(reshape2)
    library(dplyr)
    # melting the dataset using following variables: subject.id, 
    # activity.description
    melt.dataset <- melt(total.dataset, id.vars = c("subject.id", 
                                                    "activity.description"), 
                         measure.vars = c(3:81))
    # creating a new dataset with the mean value of each measurement for activity 
    # and each subject 
    tidy.dataset <- dcast(melt.dataset, subject.id + activity.description  ~ 
                              variable, mean)
    # sorting the dataset
    tidy.dataset <- arrange(tidy.dataset, subject.id, activity.description)
}