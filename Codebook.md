#The Codebook
## Project Description:
This project uses data from a study on Human Activity Recognition using Samsung Galaxy Smartphones. The requirements for this project include:
  a-Cleaning Data
  b-Selecting Required Features
  c-Merging two sets of data
  d-Summarizing the aggregate dataset and saving
  
  
## Data Used:
#### a-Training Data Set that includes the following:
###### i)    A table of 30 subjects (humans): x_train.txt
###### ii)   A table containing activities by these subjects: y_train.txt
###### iii)  A fact table containing observations of these activities at different time intervals using sensors (gyroscope,                  accelerometer): subject_train.txt
#### b-Test Data Set that includes the following:
###### i)    A table of 30 subjects (humans): x_test.txt
###### ii)   A table containing activities by these subjects: y_test.txt
###### iii)  A fact table containing observations of these activities at different time intervals using sensors (gyroscope,                  accelerometer): subject_test.txt
#### c-Domains:
###### i)    A table containing the list of features: features.txt
###### ii)   A table containing labels for different activities: activity_labels.txt

## Procedure:
###### 1. First, extract the activity labels. Columns V1 and V2 are respecively named ActivityId and ActivityName
###### 2. Next, extract the required set of features from features.txt table using GREPL function. This is saved into a temporary variable
###### 3. Next, extract only the required features by subsetting x_train
###### 4. y_train, which has a pointer to the observations in x_train, only has Activity Id - by joining on the Activity table, Activity Name is derived
###### 5. finally, using CBIND, x_train, y_train and the subject data subject_train is combined into all_train dataset
###### 6. Steps 3,4 and 5 are then repeated over the test datasets: x_test, y_test and subject_test, and the result is saved in all_test dataset
###### 7. Next, RBIND is invoked to merge all_train and all_test datasets into a new dataset: all_data
###### 8. DDPLY is now used to summarize the data (means) by SubjectId + ActivityName, and the result is written to tidy.txt
