==================================================================
Tidy version of the Human Activity Recognition Using Smartphones Dataset
==================================================================

Running the script:
====================

The run_analysis.R script will automatically download and unzip the Human Activity Recognition Using Smartphones Dataset into the current working directory if it has not already been downloaded. Then it loads the raw training and test set data for the x, subject, and y before it concatenates each file together -- training x gets concatenated with test x, training subject with test subject and training y with test y. Once the data sets have been concatenated, they are labeled with better descriptive variable names and we filter out all columns from the combined x dataset that doesn't contain a mean() or std() string in embedded in its column name. This means both something-mean() and something-mean()-X are included in this dataset. After filtering out, the three combined datasets (x, subject and y) are bound together column-wise. The activity label from the y dataset is replace with the descriptive name, and then we compute the means on the dataset grouping by (activity, subject).

Output columns:
==============
subject: This contains the subject data files that identifies who carried out the experiment.
activity_label: This is the original y dataset that has been mapped to a more descriptive name of the action being performed. 
xxx-mean / xxx-mean-xxx: These are the average of all of the "mean" columns, grouped by subject and activity.
xxx-std / xxx-std-xxx: These are the average of all of the "std" columns, grouped by subject and activity.