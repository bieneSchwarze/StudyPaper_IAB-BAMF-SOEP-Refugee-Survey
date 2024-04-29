/*------------------------------------------------------------------------------
********************************************************************************
********************************************************************************
* Author: Silvia Schwanhäuser 			 									****
*																			****
* Exploring Integration and Migration Dynamics: The Research Potentials     ****
* of a Large-Scale Longitudinal Household Study of Refugees in Germany		****
*																			****
* 3. SOCIO-DEMOGRAPHICS OF REFUGEES 										****
																			****
* Datum: 16.08.2023															****
********************************************************************************
********************************************************************************
  
  DATA ANALYSIS 
  
  01) Analysing relevant data
  
  The configuration file 'config.do' defines important 
  settings (= paths) as well as various programs needed for the analysis. 
  Before executing any other do-file, this file should always run first. 
  
------------------------------------------------------------------------------*/

capture log close
capture log using "$output/analysis_wgt_${date}.log", replace

use $dataout/INTER_iab_bamf_soep_v38_redu_clean.dta, clear
set dp period

********************************************************************************
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
** Household level analysis
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
********************************************************************************

********************************************************************************
** Household size
********************************************************************************

preserve

duplicates drop hid syear, force

tab hhgr welle [aweight = hhrf]
tab hgtyp1hh welle [aweight = hhrf]

#delimit
	table hgtyp1hh welle [aweight = hhrf],
	stat(freq)
	stat(prop, across(hgtyp1hh))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Type of residence
********************************************************************************

tab hwunt welle [aweight = hhrf]

#delimit
	table hwunt welle [aweight = hhrf],
	stat(freq)
	stat(prop, across(hwunt))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

restore

********************************************************************************
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
** Person level analysis
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
********************************************************************************

********************************************************************************
** Age
********************************************************************************

tab age_cat2 welle [aweight = phrf]

#delimit
	table age_cat2 welle [aweight = phrf],
	stat(freq)
	stat(prop, across(age_cat2))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Sex
********************************************************************************

tab female welle [aweight = phrf]

#delimit
	table female welle [aweight = phrf],
	stat(freq)
	stat(prop, across(female))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Residence title
********************************************************************************

tab resid_title welle [aweight = phrf]

#delimit
	table resid_title welle [aweight = phrf],
	stat(freq)
	stat(prop, across(resid_title))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Country of origin/nationality
********************************************************************************

tab herkunftsland welle [aweight = phrf]

#delimit
	table herkunftsland welle [aweight = phrf],
	stat(freq)
	stat(prop, across(herkunftsland))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Education level
********************************************************************************

tab isceda11a_aggr welle [aweight = phrf]

#delimit
	table isceda11a_aggr welle [aweight = phrf],
	stat(freq)
	stat(prop, across(isceda11a_aggr))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

tab isceda11a welle [aweight = phrf]

#delimit
	table isceda11a welle [aweight = phrf],
	stat(freq)
	stat(prop, across(isceda11a))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

tab isced11 welle [aweight = phrf]

#delimit
	table isced11 welle [aweight = phrf],
	stat(freq)
	stat(prop, across(isced11))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Employment status
********************************************************************************

tab emp_status_3cat welle [aweight = phrf]

#delimit
	table emp_status_3cat welle [aweight = phrf],
	stat(freq)
	stat(prop, across(emp_status_3cat))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************
** Arrival Year
********************************************************************************

* Arrival Year aggregiert
gen arriv_yr_aggr = .
replace arriv_yr_aggr = 1 if arrival_yr <= 2013 & arrival_yr != .
replace arriv_yr_aggr = 2 if arrival_yr == 2014 
replace arriv_yr_aggr = 3 if arrival_yr == 2015
replace arriv_yr_aggr = 4 if arrival_yr == 2016
replace arriv_yr_aggr = 5 if arrival_yr >= 2017 & arrival_yr != .

lab var arriv_yr_aggr "Year of Arrival (aggregiert)"
#delimit
	lab def arriv_yr_aggr_lab 
		1 "2013 or earlyer" 
		2 "2014" 
		3 "2015"
		4 "2016"
		5 "2017 or later"
		, replace;
#delimit cr
lab val arriv_yr_aggr arriv_yr_aggr_lab

* ---------------------------------------------------------------------------- *

tab arriv_yr_aggr welle [aweight = phrf]

#delimit
	table arriv_yr_aggr welle [aweight = phrf],
	stat(freq)
	stat(prop, across(arriv_yr_aggr))
	nformat(%9.3f) nformat(%9.0f frequency);
#delimit cr

********************************************************************************

capture log close
clear
exit

********************************************************************************
