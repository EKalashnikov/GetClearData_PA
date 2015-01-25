# Unzip data files
unzip("Dataset.zip")

# Read and merge the training and the test sets to create one data set.
data <- read.table("UCI_HAR_Dataset//test//X_test.txt")
data <- rbind(data, read.table("UCI_HAR_Dataset//train//X_train.txt"))

# Read measurements names and assign it to measurements data set
names(data) <- read.table("UCI_HAR_Dataset//features.txt", 
                          col.names = c("Num","Name"))$Name

# Create data frame, which contains only the measurements on the mean and
# standard deviation for each measurement.
data <- data[,grep("-mean\\(\\)|-std\\(\\)", names(data))]

# Add subject ID and activity ID (for test and train measurements) to data set
data <- cbind(data, 
              Subject = rbind(read.table("UCI_HAR_Dataset//test//subject_test.txt"),
                              read.table("UCI_HAR_Dataset//train//subject_train.txt")
                              )[,1])
data <- cbind(data, Num = rbind(read.table("UCI_HAR_Dataset//test//y_test.txt"),
                                read.table("UCI_HAR_Dataset//train//y_train.txt")
                                )[,1])

# Add descriptive activity names to name the activities in the data set
act_labels <- read.table("UCI_HAR_Dataset//activity_labels.txt", 
                         col.names = c("Num","Activity"))
data <- merge(x = data, y = act_labels, by = "Num")
ColNum <- ncol(data)-2
data <- cbind(Activity = data$Activity, Subject = data$Subject, 
              data[,2:ColNum])

# Sort data by activity name and subject ID
data <- data[order(data$Activity, data$Subject),]
row.names(data) <- 1:nrow(data)

# Change lables in the data set to appropriately descriptive variable names.
# There are several descriptive variable names principles have been choosen:
# 1. Remove "()" from names
# 2. Use symbol "_" between words
# 3. Use full words instead of shortcuts (below few exeptions)
# 4. "StD" shortcut is used for standart deviation) 
# 5. "FTT" shortcut is used for variables with Fast Fourier Transform
lbls <- names(data)
lbls <- sub("tBody","Body ",lbls)
lbls <- sub("tGravity","Gravity ",lbls)
lbls <- sub("fBodyBody","fBody",lbls)
lbls <- sub("fBody","FFT Body ",lbls)
lbls <- sub("Acc","Acceleration ",lbls)
lbls <- sub("Jerk","Jerk ",lbls)
lbls <- sub("Mag","Magnitude ",lbls)
lbls <- sub("Gyro","Gyroscope ",lbls)
lbls <- sub("-mean\\(\\)","Mean",lbls)
lbls <- sub("-std\\(\\)","StD",lbls)
lbls <- gsub(" ","_",lbls)
lbls <- gsub("-","_",lbls)
names(data) <- lbls

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
dataAg <- aggregate(x = data[,3:ncol(data)], 
                    by = list(Activity = data$Activity, Subject = data$Subject), 
                    FUN = "mean")
dataAg <- dataAg[order(dataAg$Activity, dataAg$Subject),]
row.names(dataAg) <- 1:nrow(dataAg)

# Write second data set with the averages to file Mean_SD_Agg.txt
write.table(dataAg, file = "Mean_SD_Agg.txt", row.name=FALSE) 
