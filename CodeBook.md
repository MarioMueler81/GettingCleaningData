# Getting-and-Cleaning-Data-Week-3

### Code Book

#### Intro

As dicussed in README.md [link pending], the assignment is: 

> You should create one R script called run_analysis.R that does the following. 
>
> 1. Merges the training and the test sets to create one data set.
>
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
>
> 3. Uses descriptive activity names to name the activities in the data set
>
> 4. Appropriately labels the data set with descriptive variable names. 
>
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### Step 1

> 1. Merges the training and the test sets to create one data set.

The test and trainig data files are

	./UCI HAR Dataset/test/y_test.txt
	
	./UCI HAR Dataset/train/y_train.txt

#### Step 2

> 2. Extracts only the measurements on the mean and standard deviation for each measurement.

The merged data set after has no column labels. That's why now we need to connect them to know which are mean and standard deviation or std.

The column labels are contained in the file:

	./UCI HAR Dataset/features.txt

We need the grep-method of mean, std, sub.id and act.id to throw the unwanted columns of the form and *meanFreq* which are removed in a second step.

#### Step 3

> 3. Uses descriptive activity names to name the activities in the data set

Now we replace the numeric values in one column from domain to a character string held in the following file:

	./UCI HAR Dataset/activity_labels.txt

After that, the activity column is given the name "activity".

#### Step 4

> 4. Appropriately labels the data set with descriptive variable names. 

This has already been done in step 2. 

#### Step 5

> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This is the most complex data transformation. There are 30 subjects and 6 activities.

The next step is to reduce the data frame to only these four columns using the melt function:

	*activity
	
	*subject
	
	*measurement
	
	*mean value
