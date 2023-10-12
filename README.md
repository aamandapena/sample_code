# R & Python Code Samples

This repository contains code samples in R and Python to showcase my programming skills in these languages.

## Contents

1. Python code sample (https://github.com/aamandapena/sample_code/blob/main/Python_sample_code.ipynb)
2. R code sample (https://github.com/aamandapena/sample_code/blob/main/R_sample_code.R)

## R Code Sample

This R code is part of a data cleaning and preprocessing process for a database related to the UFES entrance exam. It is authored by Amanda Pena and is a part of a Master's dissertation/thesis project. The code focuses on cleaning and preparing the data for further analysis.

### How to Run

#Prerequisites
R and RStudio: Ensure you have R and RStudio installed on your machine. If not, you can download and install them from the official websites:

#R: Download R
RStudio: Download RStudio
Install Required Packages: Open RStudio and run the following commands to install the necessary packages using pacman:

#Running the Code
Follow these steps to run the R code:

#Download the Data: Ensure you have the data file "data_ufes_approved_reserve.xlsx" available at the specified location or adjust the path accordingly within the script.

#Execute the Code in Sections: Open the R script in RStudio or copy and paste each section of the code into the R console and run them sequentially.

#Inspect Results: As you run the code, it will read the data, clean, preprocess, and save the processed data into Excel files in the "data" folder.

## Python Code Sample

This Python script is designed to handle a large dataset that couldn't be efficiently processed using R. It reads a CSV file, processes the data, and prints the first 200 characters of each line to the console. The processed data is then saved to an output file.

### How to Run
Open the input file in read mode and the output file in write mode.
Write the header line to the output file.
Iterate through each line in the input file.
Split the line into columns based on the ";" delimiter.
Check if the first column starts with "32" and the 10th field is greater than or equal to 9.
If the conditions are met, write the line to the output file.
Close the input and output files.
Import the pandas library.
Open the output file in read mode.
Iterate through each line in the output file.
Replace ';' with '\t' and print the first 200 characters of the line.
Keep track of the number of lines printed and break the loop after printing 10 lines.
Close the output file.
