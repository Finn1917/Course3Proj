library(dplyr); library(reshape2)
##
## read in training and test tables along with labels
## also read in activity field descriptors
## also read in subject data
dtTraining <- read.table("X_train.txt")
dtTest <- read.table("X_test.txt")
dtTrainingLabels <- read.table("y_train.txt")
dtTestLabels <- read.table("y_test.txt")
dtFeatures <- read.table("features.txt")
dtTrainSubject <- read.table("subject_train.txt")
dtTestSubject <- read.table("subject_test.txt")
##
## Create combined table of training and test data
dtComb <- rbind(dtTraining, dtTest)
##
## Extract only mean and std fields. For this purpose, field names
## in "features.txt" containing either "-mean" or "-std" are considered
## applicable fields
mean_std_Fields <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 227:228, 240:241, 253:254, 
                     266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
dtCombSelect <- select(dtComb, mean_std_Fields)
##
##
##
## Apply features field descriptors
for(i in 1:64) {
        names(dtCombSelect)[i] <- toString(dtFeatures[mean_std_Fields[i],2])
}

## Create combined subject table
## This is a combination of the subject data for the training and test sets
dtCombSubject <- rbind(dtTrainSubject, dtTestSubject)
dtCombSubject <- rename(dtCombSubject, subj_id = V1)
##
## Combine subject information and main data
dtCombSelect <- cbind(dtCombSubject, dtCombSelect)
##
## Create combined labels table
## This is a combination of the lables data for the training and test sets
dtCombLabels <- rbind(dtTrainingLabels, dtTestLabels)
dtCombLabels <- rename(dtCombLabels, act_id = V1)
##
## Combine labels and data
dtCombSelect <- cbind(dtCombLabels, dtCombSelect)
##
## read in label ID description. This is based on the assumption that the user
## has the file "activity_labels.txt" in the working directory
dtDescLabels <- read.table("activity_labels.txt")
##
## rename fields in dtDescLabels so
## it can be merged with dtCombSelect
dtDescLabels <- rename(dtDescLabels, act_id = V1)
dtDescLabels <- rename(dtDescLabels, act_descr = V2)
##
## Merge in activity labels
dtMerge <- merge(dtDescLabels, dtCombSelect, by.x = "act_id", by.y = "act_id")
##
## Use melt and dcast to summarize dtMerge by activity and subjecy
## Output resulting data as a text file
##
dtMelt <- melt(dtMerge, id = c("act_descr", "subj_id"))
dtFin <- dcast(dtMelt, act_descr + subj_id ~ variable, mean)
write.table(dtFin, file = "tidy_dat.txt", row.name = FALSE)
