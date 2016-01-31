A tidy dataset was created according to the instructions in the assignment "Getting and Cleaning Data Course Project". 
This project assignment is part of the Coursera course "Getting and Cleaning Data".

The tidy dataset is constructed from the assignment's source data by the R-program "run_analysis.R".

THE STEPS THAT WERE TAKEN TO CREATE THIS TIDY DATASET:

I. Create the full test data set (intermediate result):
- Read X_test.txt in a data table using the column names as specified in features.txt.
- Read Y_test.txt in a data table.
- Read subject_test.txt in a data table.
- Combine a new dataset as a column-wise union of these three:
	- first column from subject_test.txt with column name "S1".
	- second column from Y_test.txt with column name "Y1".
	- then all columns from X_test.txt (using the already available column names from features.txt).
	
II. Create the full training data set (intermediate result):
- Read X_train.txt in a data table using the column names as specified in features.txt.
- Read Y_train.txt in a data table.
- Read subject_train.txt in a data table.
- Combine a new dataset as a column-wise union of these three:
	- first column from subject_train.txt with column name "S1".
	- second column from Y_train.txt with column name "Y1".
	- then all columns from X_train.txt (using the already available column names from features.txt).

III. Create the full data set of test and training data (intermediate result):
- Combine (row-wise) the test and training data sets from the previous steps.

IV. Select only the measurements on mean and standard deviation from the data set from step III.

V. Replace the numeric representation of the activity names in the dataset from step IV by their textual descriptions. The textual description was taken from "activity_labels.txt".

VI. Rename the columns containing the activities and subjects by meaningful names ("subject" and "activity").

VII. Create the requested tidy data set from the data set from step VI with the average (mean) of each variable for each subject and activity.

Note:
- refer to the comments and code in "run_analysis.R" for more details.
