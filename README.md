
This script requires ddplyr and tidyr packages

The script performs the following steps:

1. reads the training and test sets and combines them via rbind() into a the complete data set

2. reads the features.txt file and removes characters such as commas and parentheses to create descriptive column names (using gsub())

3. adds the column names to the complete data set through the colnames() function

4. selects only  those measurement columns that include mean or standard deviations via the contains() function

5. adds 2 additional columns:
	1. subject column  - combines via rbind() the subject_train and subject_test files, then adds them it the complete set via cbind() 
	2. activity column  - combines via rbind() the Y_test and Y_train files and  binds then adds it to the complete data sets via cbind()
	3. name these columns “Subject” and “Activity”


6. creates a new data set calculating means for each column, grouping by subject and activity (using summarize_each)
7. adds “mean” to each column name
8. writes this data set to a file called “tidySetGrM.txt”
9. Displays the final tidy set in a table to make it easy for the the reviewer to verify that the scrip creates a valid tidy data set


