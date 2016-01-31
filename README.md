##Getting and Cleaning Data Course Project

Things to do to get the *run_analysis* script to work:

* Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* Rename the "UCI HAR Dataset" folder as "data".

* Make sure that both the folder "data" and the run_analysis.R script are in the current working directory.

* Run the script using the command source("run_analysis.R") from RStudio. 

* Two output files will be generated in the current working directory:
 
  - merged_data.txt (8150 Kb): contains a data frame called tidyData with dimensions of 10299 x 68.
 
  - dataMeans.txt (220 Kb):contains a data frame called result with dimensions of 180 x 68.

* Use data <- read.table("dataMeans.txt") command in RStudio to read the file. We have 180 rows with the combinations of of features

