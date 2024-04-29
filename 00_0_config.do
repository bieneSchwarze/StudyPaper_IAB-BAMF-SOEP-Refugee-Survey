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
    
  CONFIGURATION FILE
  ------------------
  
  Defines important settings (= paths) as well as various programs needed 
  for the analysis. 

------------------------------------------------------------------------------*/

clear										// Deleting settings and memory
version 16.1 								// Setting to version 16.1
capt log close _all							// Closeing all log files

********************************************************************************
* Defining all paths
********************************************************************************

* Version of Revision
global version "A"

* Working directory
global project_folder ".../IAB_BAMF-SOEP"
global workingDir "${project_folder}/analyses/3_Socio-Demographics/dofile"

* Original data 
global datapath ".../Data/"
global SOEPv38 "${datapath}/IAB-BAMF-SOEP/ORIGINAL/SOEP-CORE.v38.1"
global datageo "${datapath}/Geodaten/ORIGINAL_DATA/regio_SOEPv38.1"

* Working data
global dataout "${project_folder}/analyses/3_Socio-Demographics/savedata"

* Ado-file search path	
adopath +  ".../STATA/bocode" 
adopath ++ ".../Data/IAB-BAMF-SOEP/coding/ado" 

********************************************************************************
* Further configurations and settings
********************************************************************************

* Log-file path
global output "${workingDir}/log"

* Changing working directory
cd "$workingDir"

* Creating directory for temporary files and log files
capt mkdir "$tempDir" 		// create directory for temp files (if not there)
capt mkdir "$logDir" 		// create directory for log files (if not there)

* Turining off feature of abbrevating variables in tables and lists
set varabbrev off
* Turining "more"-paging  off
set more off
* Indicator for config-file
global config = 1			// a flag that config file was executed already

* Clearing different globals/locals
clear matrix
clear mata

* Setting date formate
global date = string( d(`c(current_date)'), "%tdCYND" )
* Identifing macros with prefix 'date'
mac list date

* Adding comma as decimal seperator
set dp comma

* Defining grafic scheme
set scheme plotplain

* Creating program to drop irrelevant variables
capture program drop irrelevant_instr	//Drop if program already existing
program define irrelevant_instr			//Defining program
d,s										//Information on data and variables
preserve
	local vlist							//Defining local for variable list
	quietly ds,has(type numeric)		//Filter numeric variables
	
	* Summarizing variables and checking if all == -8 | == - 5 or inbetween
	foreach variable of varlist `r(varlist)' {
		quietly summarize `variable'
		if (`r(mean)' ==-8) local vlist `vlist' `variable'
		if (`r(mean)' ==-5) local vlist `vlist' `variable'
		if (`r(min)' ==-8 & `r(max)' ==-5) local vlist `vlist' `variable'
	}
restore
drop `vlist'
d,s
end

********************************************************************************
