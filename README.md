### Course project for GettingAndCleaningData

- To run the script, user must download the "run_analysis.R" script and run it in R.
- This script does not require the source data to be pre-downloaded. However, if the data is already downloaded, 
user must ensure that this script is downloaded in the parent folder of "UCI HAR Dataset" folder.
- This R script also uses Hmisc library for text capitalization. So, the user must install the library before running
the script, or if user doesn't want to install it, then they need to comment out line #27 and #28 from the "run_analysis.R" file.
- For final result, the script will generate two text files: 1. merged_clean_data.txt and 2. average_of_dataset.txt
