library(dplyr)

# Download and unzip the file from the given URL
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'Getting_Cleaning_Data_Assignmnent.zip')
unzip('Getting_Cleaning_Data_Assignmnent.zip')

# Read the data of type txt as tables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c('i', 'funct'))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('label', 'activity'))

# Read the data from the test folder
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = 'subject')
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$funct)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = 'label')

# Read the data from train folder
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = 'subject')
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$funct)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = 'label')

# Merging the training and test sets for Subject, X, y
# We yse rbin because...
subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

# Create a final data set 
# We use cbind because 
data <- cbind(subject,X,y)

# We restrict to the columns containing the string mean or std
data_mean_std <- select(data, subject, label, contains('mean'), contains('std'))
data_mean_std$label <- activity_labels[data_mean_std$label, 'activity'] 

# We use the features info file to make the variable names more intuitive
names(data_mean_std) <- gsub('label', 'activity', names(data_mean_std))
names(data_mean_std) <- gsub('^t', 'time', names(data_mean_std))
names(data_mean_std) <- gsub('^f', 'frequency', names(data_mean_std))
names(data_mean_std) <- gsub('-mean()', 'Mean', names(data_mean_std))
names(data_mean_std) <- gsub('-std()', 'Std', names(data_mean_std))
names(data_mean_std) <- gsub('Mag', 'Magnitude', names(data_mean_std))
names(data_mean_std) <- gsub('Acc', 'AccelerationSignal', names(data_mean_std))

data_mean_std <- group_by(data_mean_std, subject, activity) 
tidy_data_average <- summarise_all(data_mean_std, mean)

write.table(tidy_data_average, "tidy_data_average.txt")

