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
* Datum: 16.08.2023															****
********************************************************************************
********************************************************************************
  
  DATA PREPARATION 
  ------------------
  
  01) Merging and preparing survey data
  
  The configuration file 'config.do' defines important 
  settings (= paths) as well as various programs needed for the analysis. 
  Before executing any other do-file, this file should always run first. 
  
------------------------------------------------------------------------------*/

// call the configuration file
if "${config}" != "1" do 00_0_config.do 	

capture log close
capture log using "$output/data_merge_${date}.log", replace

********************************************************************************
* MERGE ORIGINAL DATA
********************************************************************************

********************************************************************************
*** Retrieve variables from $ppathl
********************************************************************************

use $SOEPv38/ppathl.dta, clear 				//Using data ppathl
label language DE							//Using German language version

tab psample									//Overfew of sample

* Reducing sample to only include refugees 
keep if inlist(psample,17,18,19,24)			//17 = M3, 18 = M4, 19 = M5, 24 = M6
keep if syear >= 2016						//Only from 2016 wave on
tab syear, m								//Checking for missing wave info

isid pid syear								//Checking unique identification

********************************************************************************
*** merge with $pl 
********************************************************************************

merge 1:1 pid syear using $SOEPv38/pl.dta
keep if _merge == 3							//Keeping information for refugees
drop _merge
isid pid syear								//Checking unique identification

********************************************************************************
*** merge with $biol 
********************************************************************************

merge 1:1 pid syear using $SOEPv38/biol.dta
drop if _merge == 2							//Keeping information for refugees
drop _merge

********************************************************************************
*** merge with $pgen 
********************************************************************************

merge 1:1 pid syear syear using $SOEPv38/pgen.dta
drop if _merge == 2							//Keeping information for refugees
drop _merge
isid pid syear								//Checking unique identification

********************************************************************************
*** retrieve from $pbiospe, i.e., gen spelldata
********************************************************************************

preserve
keep pid									//Reducing data to person-ID
duplicates drop								//Dropping duplicated IDs
isid pid									//Checking unique identification
* Merging with spell data
merge 1:m pid using $SOEPv38/pbiospe.dta
drop if _merge == 2							//Keeping only relevant spells
drop _merge

keep pid spellnr spelltyp beginy endy		//Reducing data to relevant info

tab spelltyp								//Overfew of spells
save $dataout/biospe_temp.dta, replace 		//Save in temp file
restore

********************************************************************************
*** retrieve from $kidlong, i.e., gen spelldata
********************************************************************************

preserve
use $SOEPv38/kidlong.dta, clear				//Using information on children
keep if syear >= 2016						//Only from 2016 wave on
*Merging with household data
merge m:1 cid hid syear using $SOEPv38/hl.dta
drop if _merge == 2							//Keeping only relevant information
drop _merge

keep pid hid cid syear k_birthy_h 			//Reducing data to relevant info

save $dataout/kid_temp.dta, replace  		//Save in temp file
restore

********************************************************************************
*** merge with $hpathl 
********************************************************************************

* Merging weights/upscaling factors
merge m:1 hid syear using $SOEPv38/hpathl.dta, keepusing(hhrf hhrf0 hhrf1)
drop if _merge == 2							//Keeping only relevant information
drop _merge
isid pid syear								//Checking unique identification

********************************************************************************
*** merge with $hl 
********************************************************************************

merge m:1 hid syear using $SOEPv38/hl.dta
drop if _merge == 2							//Keeping only relevant information
drop _merge

********************************************************************************
*** merge with $hgen
********************************************************************************

* Merging household type
merge m:1 hid syear using $SOEPv38/hgen.dta, keepusing(hgtyp1hh)
drop if _merge == 2							//Keeping only relevant information
drop _merge

********************************************************************************
*** merge with $hbrutto
********************************************************************************

* Merging houshold size
merge m:1 hid syear using $SOEPv38/hbrutto.dta, keepusing(hhgr)
drop if _merge == 2							//Keeping only relevant information
drop _merge

********************************************************************************
*** Final preperation of data
********************************************************************************

** Dropping of empty variables:
foreach var of varlist _all {
	capture assert mi(`var')
	if !_rc {
	drop `var'
	}
}

* Dropping irrelevant variables
irrelevant_instr

save $dataout/INTER_iab_bamf_soep_v38_v1_full.dta, replace 

********************************************************************************

capture log close
clear
exit

********************************************************************************
