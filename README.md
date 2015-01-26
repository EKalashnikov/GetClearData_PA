#README.md

##Synopsis  
One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

**run_analysis.R** script creates a tydy data set from raw data.

**run_analysis.R** script does the following:   
1. Merges the training and the test sets to create one data set.    
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set (see below principles).   
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
6. Save data set created on step 5 to file **Mean_SD_Agg.txt**  
  
There are several descriptive variable names principles have been choosen:  
1. Remove "()" from names.   
2. Use symbol "_" between words.  
3. Use full words instead of shortcuts (below few exeptions).  
4. "StD" shortcut is used for standart deviation).   
5. "FTT" shortcut is used for variables with Fast Fourier Transform.  

##Input 
**run_analysis.R** requires **Dataset.zip** file in the current directory.  
**Dataset.zip** file with the data could be downloaded from the <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 

##Output  
**Mean_SD_Agg.txt** with the result data set is created after running **run_analysis.R**   
**CodeBook.md** contains the description of data set created after running **run_analysis.R**   

To read data set from **Mean_SD_Agg.txt** to R use command:  
```{r, results='hide'}
read.table("Mean_SD_Agg.txt", header = TRUE)
```

