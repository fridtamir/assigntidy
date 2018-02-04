# CodeBook

The code in run_analysis, will download a zip file (if not exist), unzip it and create a tidy dataset from different files. 
subject_test : subject IDs for test

## First part - Read data, create data set by merging

subject_train : subject IDs for train

x_test : values of variables in test

x_train : values of variables in train

y_test : activity ID in test

y_train : activity ID in train

activity_labels : Description of activity IDs in y_test and y_train

features : description(label) of each variables in X_test and X_train

dataset : bind of X_train and X_test

## Second part - Extract only mean and standard deviation 

Start by creatig a "meanstd" vector using grep package (for regular expression) on the "mean" and "std" words.
Apply it on the dataset. 

## Third part - descriptive activity names to name the activities in the data set

Binding the activities and subject together. Then, use the descriptive factor from the activity label file in the zip 

## Forth part - Appropriately labels the data set with descriptive variable names.

cleaning the names in the dataset (get rid of "(())", "[]"), bind the subject and activity tables to the dataset. 
inserting names to all columns. applying the factor of activity on activty column of the dataset. 

## Fifth part - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Melting dataset, to create a neat data set. then, casting it to a tidy data using the means of variables. both action were done with rshape2 package. 


### when done creating a new tidy_data csv with the tidy table.
