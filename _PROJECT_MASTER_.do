/*------------------------------------------------------------------------------
********************************************************************************
********************************************************************************
* Author: Silvia Schwanhäuser 			 									****
* Adapted from: Yuliya Kosyakova											****
*																			****
* Exploring Integration and Migration Dynamics: The Research Potentials     ****
* of a Large-Scale Longitudinal Household Study of Refugees in Germany		****
*																			****
* 3. SOCIO-DEMOGRAPHICS OF REFUGEES 										****
																			****
* Datum: 15.08.2023															****
********************************************************************************
********************************************************************************
  
  PROJECT MASTER FILE
  -------------------
  
  The syntax of the empirical analysis is divided into sub-files, each 
  of which completes a specific step in the analysis. 
  
  This master file runs each of these steps in the right order. 
  You can run the complete analysis by executing this file.
 
  The syntax for the project is split into the following steps:
  
  DATA PREPARATION 
  
	01) Merging and preparing survey data

  DATA CLEANING 
  
	01) Cleaning and preparing survey data
	02) Selecting the analytical sample
  
  DATA ANALYSIS 
  
	01) Analysing relevant data
  
  The configuration file '00_0_config.do' defines important 
  settings (= paths) as well as various programs needed for the analysis. 
  Before executing any other do-file, this file should always run first. 
  
------------------------------------------------------------------------------*/

********************************************************************************
* CONFIGURATION FILE
********************************************************************************

* Changing working directory to folder including all do-files:
global project_folder ".../IAB_BAMF-SOEP"
cd "${project_folder}/analyses/3_Socio-Demographics/dofile"

* Calling the configuration file
do 00_0_config.do

* Increasing number of variables allowed in memory
set maxvar 12000

********************************************************************************
* DATA PREPARATION 
********************************************************************************

do 01_data_merge.do

********************************************************************************
* DATA CLEANING 
********************************************************************************

do 02_data_clean.do

********************************************************************************
* DATA ANALYSIS 
********************************************************************************

* Dropping temporary datasets
erase $dataout/biospe_temp.dta
erase $dataout/kid_temp.dta
erase $dataout/temp.dta

* Analysis without weights
do 03_analysis_raw.do

* Analysis with weights
do 04_analysis_wgt.do

********************************************************************************
