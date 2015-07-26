# Course3Proj
Course 3 Project Notes
The cord run_analysis.R begins with the Samsung data files and creates and output file measuring the means of certain fields
as described in more detail below.

This Readme file addresses how the code goes about meeting the requirments of the project.

The project looked for the following (as copied from the assignment):

You should create one R script called run_analysis.R that does the following. 
1 - Merges the training and the test sets to create one data set.
2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
3 -Uses descriptive activity names to name the activities in the data set
4 -Appropriately labels the data set with descriptive variable names. 
5 -From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In order to run the code you must have access to the dplyr and reshape2 packages. The necessary Samsung data files must be in
your working directory. The steps described below refer to the step numbers from the project instructions.

Step 1

The necessary text files are brought into R using the read.table command. This includes the main data sets, the activity
labels, the subject data and the feature informatiom

The main data sets (training and test) are then combined using rbind. There are two other rbind steps following this one. 
Care has been taken to make sure all rbind operations occur in the same order (Training as the first argument and Test as the
second) so that data from the subject and activity tables matches up properly to the main sets.

A similar rbind opeartion is done with the subject and activity sets.

Step 2

The data is then reduced to extract only fields that contain mean and standard deviation information. This is accomplished 
thorugh the select function.

Step 3

The data fields are assigned descriptive names from the feature file using a for loop and picking the field names that 
correspond to the fields extracted in Step 2.




