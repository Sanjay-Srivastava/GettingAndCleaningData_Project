
###############################################################################################
## GET THE ACTIVITY LABELS
###############################################################################################
acts = read.table("./activity_labels.txt")
setnames(acts, c("V1", "V2"), c("ActivityId", "ActivityName"))

###############################################################################################
## GET THE REQUIRED FEATURE LIST: MEAN AND STANDARD DEVIATION
###############################################################################################
tmp = read.table("./features.txt")
setnames(tmp, c("V1", "V2"), c("FeatureId", "FeatureName"))
relevant_features = grep("-(mean|std)\\(\\)", tmp$FeatureName)

###############################################################################################
## GET THE TRAINING DATA FOR THE RELEVANT FEATURES AND MERGE THEM TOGETHER
###############################################################################################
x_train = read.table("./Train/X_Train.txt")[relevant_features]
y_train = read.table("./Train/y_train.txt")
setnames(y_train, "V1", "ActivityId")
y_train = join(y_train, acts, by = "ActivityId")
subject_train = read.table("./Train/subject_train.txt")
setnames(subject_train, "V1", "SubjectId")
training_data = cbind(x_train, y_train, subject_train)
training_data$SubjectType = "Training"

###############################################################################################
## GET THE TEST DATA FOR THE RELEVANT FEATURES AND MERGE THEM TOGETHER
###############################################################################################
x_test  = read.table("./Test/x_Test.txt")[relevant_features]
y_test = read.table("./Test/y_Test.txt")
setnames(y_test, "V1", "ActivityId")
y_test = join(y_test, acts, by = "ActivityId")
subject_test = read.table("./Test/subject_test.txt")
setnames(subject_test, "V1", "SubjectId")
test_data = cbind(x_test, y_test, subject_test)
test_data$SubjectType = "Test"

###############################################################################################
## MERGE TEST AND TRAINING DATA, AND ASSIGN PROPER NAMES TO THE COLUMNS
###############################################################################################
all_data = rbind(training_data, test_data)
final_results = ddply(all_data, .(SubjectId, ActivityName), function(x) colMeans(x[, 1:66]))
write.table(final_results, "./tidy.txt", row.names = F)
