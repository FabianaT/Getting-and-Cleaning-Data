==================================================================
run_analysis.R
Version 1.0
==================================================================
Fabiana Tamburrini
favat@hotmail.com
==================================================================

## Getting and Cleaning Data Course Project (Coursera course)

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This repo contains 4 files:
1. README.md
	Current file you are reading.
2. run_analysis.R
	R program that process the raw data and generates a the tidy dataset.
3. tidyData.txt
	The tidy dataset result after running run_analysis.R
4. CodeBook.md
	Codebook explaining the process and the variables included on the tidyData.txt file.

About the "run_analysis.R":
This program analyses Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
 
To open the tidy data, do the following:
tidyDataSet <- read.table("./tidyData.txt")

Fabiana Tamburrini, January 2015.