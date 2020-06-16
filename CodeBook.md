The analysis is performed using the run_analysis.R script. 

This analysis consists of acquiring data, cleaning the data and saving the data. 

1. The dataset is downloaded from the link given. This is a zip file hence it is unzipped. The results is a file called UCI HAR Dataset containing the different files necessary for the analysis. 

2. Each file is saved as a variables: 
- activity_labels.txt is saved under the variable activity_labels: 6 obs for 2 var
- features.txt is saved under the variable features: 561 obs for 2 var
- subject_test.txt from the folder test is saved under subject_test: 2947 obs for 1 var
- X_test.txt from the folder test is saved under X_test: 2947 obs for 561 var
- y_test.txt from the folder test is saved under y_test: 2947 obs for 1 var
- subject_train.txt from the folder train is saved under subject_train: 7352 for 2 var
- X_train.txt from the folder train is saved under X_train: 7352 for 561 var
- y_train.txt from the folder train is saved under y_train: 7352 for 1 var

3. The variables train and test are merged together to have variables: subject, X and y
- Subject is Subject_train and Subject_test merge using rbind(): 10299 obj for 1 var
- X is X_train and X_test merge using rbind(): 10299 obs for 561 var
- y is y_train and y_test merge using rbind(): 10299 obs for 1 var

4. These variables are joing to make one final dataset
- Subject, X and y are merged using cbind() into the variable data: 10299 obs for 563 var 

5. The columns that relate to mean and std are the only ones of interest. We therefore filter them. 
- data_mean_std is the subset of data with the columns subject and code and only the mean and std measurement. This is done by filtering the strings 'mean'and 'std'

6. The labels of the activities are now replaced by their activity in the dataset 

7. Some of the labels are changed in order to be more explicit. This is done by looking at the information given in the folder.
- 'label' is replaced by 'activity'
- 't' is replaced by time 
- 'f' is replaced by 'frequency'
- '-mean()is replaced by 'Mean'
- '-std()is replaced by 'Std'
- 'Mag' is replaced by 'Magnitude'
- 'Acc' is replaced by 'AccelerationSignal'

8. Another dataset is created, tidy_data_average, which contains the averages of each variables for eahc of the subjects, grouped by activity

9. This dataset is exported as a txt file. 


