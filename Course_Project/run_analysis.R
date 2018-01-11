################################################################################
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
################################################################################
analysis.run <- function(){
    
    # Asking if the user would like to install the nedeed packages to run the 
    # analysis
    message("> Would you like install 'dplyr' package? Yes/No")
    inst <- readline(prompt = "> ")
    if(grepl("[Yy]|[Yy]es" , inst)){
        install.packages(dplyr)
    }
    message("> Would you like install 'reshape2' package? Yes/No")
    inst <- readline(prompt = "> ")
    if(grepl("[Yy]|[Yy]es" , inst)){
        install.packages("reshape2")
    }
    message("> Would you like install 'data.table' package? Yes/No")
    inst <- readline(prompt = "> ")
    if(grepl("[Yy]|[Yy]es" , inst)){
        install.packages("data.table")
    }
    
    # Check if there is the right folder in the word directory
    if(!file.exists("./UCI HAR Dataset")){ 
        stop("The folder 'UCI HAR Dataset' doesn't exist")}
    
    # Load the needed functions for the analysis
    source("cleaning_functions.R")
    
    # Create the 'test' data set
    test.set <- data.read("test")
    
    # Create the 'train' data set
    train.set <- data.read("train")
    
    # Create total data set
    total.data <- rbind(test.set, train.set)
    
    # Read features.txt and create a vector containing the right names
    # of dataset columns
    colnames(total.data) <- right.col.names()
    
    # Select the column with subjects, activities and mean and standard 
    # deviation of measurements
    total.data <- select.col(total.data)
    
    # Create activity description column
    total.data <- create.activity.column(total.data)  
    
    # Create a tidy data set
    tidy.data <- tidy.dataset(total.data)
    # Convert numbers in scientific notation
    tidy.data <- cbind(subject.id = tidy.data[,1] , activity.description = 
                           tidy.data[,2], format(tidy.data[,3:81], 
                                                 scientific=TRUE, digits=7))
    # Write a file with tidy data set
    write.table(tidy.data, "tidy_dataset.txt", sep=",", 
                row.names = FALSE,
                quote = FALSE)
    print("Done! The tidy_dataset.txt file is in your working directory.")
}