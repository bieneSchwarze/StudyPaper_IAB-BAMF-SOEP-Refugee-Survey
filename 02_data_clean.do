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
  
  DATA CLEANING 
  -------------
  
  01) Cleaning and preparing survey data
  02) Selecting the analytical sample
  
  The configuration file 'config.do' defines important 
  settings (= paths) as well as various programs needed for the analysis. 
  Before executing any other do-file, this file should always run first. 

------------------------------------------------------------------------------*/

// call the configuration file
if "${config}" != "1" do 00_0_config.do  	

capture log close
capture log using "$output/data_clean_redu_${date}.log", replace

use $dataout/INTER_iab_bamf_soep_v38_v1_full.dta, clear

********************************************************************************
* RECODING OF DATA
********************************************************************************

mvdecode hgtyp1hh, mv(-1 = .)
drop piyear
rename pg* *

********************************************************************************
* DATA INFORMATION
********************************************************************************

capture drop welle						//Checking/Dropping old variable
gen welle = syear - 2015				//Generating new variable "welle"
gen minuswelle = -welle

* Label variable
#delimit
	lab de welle_lab 
		1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" 6 "2021", replace;
#delimit cr
lab val welle welle_lab
tab welle, m							//Information on waves

* Defining longitudinal data structure
xtset pid welle
* Getting information on longitudinal data structure
xtdescribe, pattern(20)

* Generating number of waves and sequence of waves for each respondent
bys pid (welle): gen n = _n				//Sequence of waves
bys pid (welle): gen N = _N				//Number of waves
tab N, m

********************************************************************************
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
** SOCIODEMIGRAPHICS
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
********************************************************************************

********************************************************************************
*** AGE
********************************************************************************

gen age = syear-ple0010_h if ple0010_h > 0				//Generating age
replace age = syear-gebjahr if age == . & gebjahr > 0	//Recode if missing
lab var age "Current Age"								//Label variable

* Recoding as categorical variable
recode age (18/25=1 "18-25") (26/35=2 "26-35") (36/max=3 "36+"), g(age_cat)
lab var age_cat "Age Cat."								//Label variable
recode age (18/25=1 "18-25") (26/35=2 "26-35") (36/45=3 "36-45") ///
	(46/59 = 4 "46-59") (60/max = 5 "60+"), g(age_cat2)
lab var age_cat2 "Age Cat."								//Label variable

tab welle, sum(age)							//Distribution over waves
tab age_cat2, m
tab age_cat2 welle, m

********************************************************************************
*** Sex
********************************************************************************

gen female = sex == 2 if sex < .			//Generating new dummy for sex
lab var female "Female"						//Label variable
lab define female_lab 0 "male" 1 "female"	//Label category
lab val female female_lab
tab female welle, m							//Distribution over waves

********************************************************************************
*** Country of origin/nationality
********************************************************************************
********************************************************************************
* ISO country code
********************************************************************************

clonevar country_name = plj0014_h						//New var for recoding
qui: do 00_1_iso_country_codes_to_refugee_sample.do		//ISO country codes
tab citizenship_var if iso_num_o == 0, m				//Check missings

* Renaming Iso country code variables
rename citizenship_var citizenship
rename iso3166 citizenship_iso
rename iso_num_o citizenship_iso_num

* Label variables 
label value citizenship_iso_num ISO_englisch_short_name
label var citizenship "Citizenship (string)"
label var citizenship_iso "Citizenship: ISO code (string)"
label var citizenship_iso_num "Citizenship: ISO code (numeric)"
numlabel ISO_englisch_short_name, add
drop country_name 

* Generating variable indicating stateless refugees
gen stateless = 1 if citizenship_iso == "miss"
bys pid (welle): carryforward stateless, replace
bys pid (minuswelle): carryforward stateless, replace
recode stateless (. = 0) 
lab define stateless_lab 0 "no" 1 "yes"				//Label category
lab val stateless stateless_lab
tab citizenship welle								//Distribution over waves
tab stateless welle									//Distribution over waves

********************************************************************************
* Time-constant citizenship, numeric
********************************************************************************

* Keeping first reported citizenship
capture drop n
bys pid (syear): gen n = _n
recode citizenship_iso_num citizenship_iso_num  (0 = .)
capture drop helpvar							//Checking/Dropping old variable
gen helpvar = citizenship_iso_num if n == 1		//Use first reported citizenship
bys pid (syear): carryforward helpvar, replace	//Use value in all waves
* Replacing missings in first reported citizenship using valid answers
replace helpvar = citizenship_iso_num if helpvar >=.
sum n
foreach num of numlist 2/`r(max)' {
	replace helpvar = citizenship_iso_num if helpvar >= . & n == `num'
	bys pid (syear): carryforward helpvar, replace
	bys pid (minuswelle): carryforward helpvar, replace
}

capture drop citizenship_iso_num_tc				//Checking/Dropping old variable 
ren helpvar citizenship_iso_num_tc				//Renaming variable

recode citizenship_iso_num_tc (. = 0)
label variable citizenship_iso_num_tc "1st rep. nonmiss Citizenship: ISO code (numeric)"

********************************************************************************
* Time-constant citizenship, string
********************************************************************************

* Keeping first reported citizenship 
capture drop cou_help							//Checking/Dropping old variable 
gen cou_help = ""
qui: do 00_2_iso.do
ren cou_help citizenship_iso_tc					//Renaming variable
label variable citizenship_iso_tc "1st reported nonmiss Citizenship: ISO code (string)"
replace citizenship_iso_tc = "missing" if citizenship_iso_tc == ""
 
********************************************************************************
* Time-constant citizenship, aggregated
********************************************************************************

* Aggregated citizenship
#delimit
	lab de staatsang_tc1_lab 
		1 "Syrien" 2 "Afghanistan" 3 "Irak"        4 "Eritrea" 
		5 "MENA"   6 "West Balkan" 7 "Ehem. UdSSR" 8 "Rest Afrika" 
		9 "Andere/Staatenlos", replace;
#delimit cr

capture drop staatsang_tc1						//Checking/Dropping old variable 
gen staatsang_tc1 = .
* 1. Syrien
replace staatsang_tc1 = 1 if inlist(citizenship_iso_tc,"SYR")
* 2. Afghanistan
replace staatsang_tc1 = 2 if inlist(citizenship_iso_tc,"AFG")
* 3. Irak
replace staatsang_tc1 = 3 if inlist(citizenship_iso_tc,"IRQ")
* 4. Eritrea
replace staatsang_tc1 = 4 if inlist(citizenship_iso_tc,"ERI")
* 5. MENA
replace staatsang_tc1 = 5 if inlist(citizenship_iso_tc, 					 ///
							 "DZA","EGY","IRN","JOR","LBN","LBY","MAR")
replace staatsang_tc1 = 5 if inlist(citizenship_iso_tc, 					 ///
							 "PSE","ARE","PAK")
replace staatsang_tc1 = 5 if inlist(citizenship_iso_tc,"SAU","TUN","YEM")
* 6. West Balkan
replace staatsang_tc1 = 6 if inlist(citizenship_iso_tc,"ALB","BIH","KOS",	 ///
							 "MKD","MNE","SRB")
* 7. Ehem. UdSSR
replace staatsang_tc1 = 7 if inlist(citizenship_iso_tc,"ARM","AZE","GEO","KGZ","MDA")
replace staatsang_tc1 = 7 if inlist(citizenship_iso_tc,"RUS","TJK","TKM","UKR","UZB")
* 8. Rest Afrika
replace staatsang_tc1 = 8 if inlist(citizenship_iso_tc,"BFA","CIV","CMR",	 ///
							 "COG","COD","ETH","GHA","GIN","GMB")
replace staatsang_tc1 = 8 if inlist(citizenship_iso_tc,"MLI","NER","NGA",	 ///
							 "RWA","SDN","SEN","SLE","SOM","TCD") 
replace staatsang_tc1 = 8 if inlist(citizenship_iso_tc,"KEN")
replace staatsang_tc1 = 8 if inlist(citizenship_iso_tc,"UGA","AGO")
tab citizenship_iso_tc if staatsang_tc1>= .
* 9. Andere/Staatenlos
recode staatsang_tc1 (. = 9)
           
label variable staatsang_tc1 "Citizenship (aggr.)"
label values staatsang_tc1 staatsang_tc1_lb
 
tab staatsang_tc1, m
tab citizenship_iso_tc if staatsang_tc1 == 9, m

********************************************************************************
* Country of origin
********************************************************************************

** Aggregated citizenship
* Generating variable
gen herkunftsland = .
replace herkunftsland = 1 if inlist(citizenship_iso_tc,"SYR")
replace herkunftsland = 2 if inlist(citizenship_iso_tc,"AFG")
replace herkunftsland = 3 if inlist(citizenship_iso_tc,"IRQ")
replace herkunftsland = 4 if inlist(citizenship_iso_tc,"ERI","SOM")
replace herkunftsland = 5 if inlist(citizenship_iso_tc,"IRN")
recode herkunftsland . = 6 if staatsang_tc1 ==7
recode herkunftsland . = 7 if staatsang_tc1 ==6
recode herkunftsland . = 8 if staatsang_tc1 ==8
recode herkunftsland . = 9 if staatsang_tc1 ==9
recode herkunftsland . = 9 if staatsang_tc1 ==5

* Label variable
#delimit
	lab de herkunftsland_lab 
		1 "Syrien" 2 "Afghanistan" 3 "Irak"         4 "Eritrea/Somalia" 
		5 "Iran"   6"Ehem. UdSSR"  7 "West Balkan"  8 "Rest Afrika" 
		9 "Andere/Staatenlos", replace;
#delimit cr
label variable herkunftsland "Citizenship (aggr.)"
label values herkunftsland herkunftsland_lab
tab citizenship_iso_tc herkunftsland, m

tab herkunftsland welle, m

********************************************************************************
*** Arrival date
********************************************************************************

g arrival_yr = lr3130 if lr3130 > 0						//Arrival year
g arrival_mth = lr3131 if lr3131 > 0 					//Arrival month

* Keeping first reported date 
foreach var of varlist arrival_yr arrival_mth {
	bys pid (welle): carryforward `var', replace
	bys pid (minuswelle): carryforward `var', replace
	bysort pid (syear): gen help`var' = `var'[1] != `var'[_N] if _n != 1
	replace `var' = . if help`var' == 1
	bysort pid (syear): carryforward `var' if help`var' == 1, replace
}

* Calculating arrival date
g arrival_date = ym(arrival_yr,arrival_mth)
lab var arrival_date "Date of Arrival"
lab var arrival_yr "Arrival Year"
lab var arrival_mth "Arrival Month"
format arrival_date %tm

tab arrival_date welle, m

drop help*

********************************************************************************
*** Type of accomodation
********************************************************************************

* Generating variable
clonevar hwunt = hlj0005_h if hlj0005_h > 0
replace hwunt = hlj0005_v2 if hwunt >= .

* Label variable
#delimit ;
lab def hwunt_lab
	1 "Shared Accommodation" 
	2 "Privat Accommodation" 
	3 "Other"
	, replace;
#delimit cr
label value hwunt hwunt_lab
lab var hwunt "Type of accomodation"

********************************************************************************
*** Education level
********************************************************************************
********************************************************************************
* Years of education, before migration
********************************************************************************

** Years of School
* Study/vocational education outside of Germany
clonevar eduasl = lb0228
replace eduasl = 1 if plj0709 == 1		// Yes, study/vocational education abroad
replace eduasl = 2 if plj0709 == 2		// No study/vocational education abroad

* Years of schooling
clonevar years_sch0 = lb0187 				// Years of schooling
replace years_sch0 = 0 if lb0183 == 2  		// Never visited school
recode years_sch0 (. = 0) if lr3076 == 2 	// Visited no school abroad
label variable years_sch0 "School: years of education before migration"
recode years_sch0 (-10/-1 = .)

tab years_sch0 welle

** Years of study/vocational education
* Duration of study/vocational education
rename lm0076i01 voc1yr 	// On-the-job-training: Duration in years
rename lm0076i08 voc1mt 	// On-the-job-training: Duration in month
rename lm0076i02 voc2yr 	// Vocational training: Duration in years
rename lm0076i09 voc2mt 	// Vocational training: Duration in month
rename lm0076i03 voc3yr 	// Vocational schooling: Duration in years
rename lm0076i10 voc3mt 	// Vocational schooling: Duration in month
rename lm0076i04 uni1yr  	// Study, practical orientation: Duration in years
rename lm0076i11 uni1mt 	// Study, practical orientation: Duration in month
rename lm0076i05 uni2yr  	// Study, theoretical orientation: Duration in years
rename lm0076i12 uni2mt 	// Study, theoretical orientation: Duration in month
rename lm0076i06 phd1yr 	// Doctorate/PhD: Duration in years
rename lm0076i13 phd1mt		// Doctorate/PhD: Duration in month
rename lm0076i07 voc4yr 	// Other training/education: Duration in years
rename lm0076i14 voc4mt		// Other training/education: Duration in years

* Summary of study/vocational education
sum years_sch0 voc*yr voc*mt uni*yr uni*mt phd1yr phd1mt
recode voc*yr voc*mt uni*yr uni*mt phd1yr phd1mt (-8/-1 = .)
sum years_sch0 voc*yr voc*mt uni*yr uni*mt phd1yr phd1mt

* Combination of years and month of study-time
gen temp1 = voc1yr + voc1mt/12 
gen temp2 = voc2yr + voc2mt/12 
gen temp3 = voc3yr + voc3mt/12 
gen temp4 = voc4yr + voc4mt/12 
gen temp5 = uni1yr + uni1mt/12 
gen temp6 = uni2yr + uni2mt/12 
gen temp7 = phd1yr + phd1mt/12 

* Summarizing years/month of study/vocational education
egen years_train0 = rowtotal(temp*), missing
replace years_train0 = 0 if eduasl == 2
lab var years_train0 "Study/Vocational: years of education before migration"
bys welle: sum years_sch0 years_train0 

** Combined years of education
capture drop total_years_edu0
egen total_years_edu0 = rowtotal(years_sch0 years_train0), missing

* Keeping information for other waves
bys welle: sum total_years_edu0 
bys pid (welle): carryforward total_years_edu0 years_sch0 years_train0, replace
bys pid (minuswelle): carryforward total_years_edu0 years_sch0 years_train0, replace
lab var total_years_edu0 "Total: years of education before migration"

drop temp* voc*yr voc*mt uni*yr uni*mt phd1yr phd1mt 

********************************************************************************
* Types of education, before migration
********************************************************************************

* Recoding generated SOEP variables
recode bilzeit psbila pbbila eduasl isced11 (-8/-1 = .)
bys pid (welle): carryforward eduasl bilzeit, replace
bys pid (minuswelle): carryforward eduasl bilzeit, replace
numlabel pgpsbila pgpbbila, add
tab pbbila eduasl, m

* Type of education/degree, before migration
tab psbila lr3079, m
replace psbila = 1 if inlist(lr3079,1)
replace psbila = 2 if inlist(lr3079,2)
replace psbila = 3 if inlist(lr3079,3,4)
replace psbila = 5 if inlist(lr3079,5)
bys pid (welle): carryforward psbila, replace
bys pid (minuswelle): carryforward psbila, replace

* Occupational status/degree, before migration
replace pbbila = 0 if eduasl == 2
bys pid (welle): carryforward pbbila, replace
bys pid (minuswelle): carryforward pbbila, replace

********************************************************************************
* ISCED, before migration
********************************************************************************

* Label variable
#delimit ;
lab def isced_lab 	
	0 "(0) 0 Less than primary education/No school"
	1 "(1) Primary education"
	2 "(2) Lower secondary education"
	3 "(3) Upper secondary education"
	4 "(4) Post-secondary non-tertiary education"
	5 "(5) Short-cycle tertiary education"
	6 "(6,7) Bachelor's/ Master's or equivalent level"
	8 "(8) Doctoral or equivalent level"
	, replace;
#delimit cr

** School degree, before migration
* Recoding variable
gen edu_deg_a = .
replace edu_deg_a = 0 if psbila == 1 		// No degree
replace edu_deg_a = 1 if psbila == 2 		// Primary degree
replace edu_deg_a = 2 if psbila == 3 		// Secondary degree

* Label variable
#delimit ;
lab define edu_deg_a_lab 
	0 "No degree"
	1 "Compulsory school degree" 
	2 "Secondary degree"
	, replace;
#delimit cr
label value edu_deg_a edu_deg_a_lab
bys pid (syear): carryforward edu_deg_a, replace
bys pid (minuswelle): carryforward edu_deg_a, replace

** School visit, before migration
* Recoding variable
gen edu_visit_a = .
replace edu_visit_a = 1 if lr3078 == 1  		// Primary school
replace edu_visit_a = 2 if lr3078 == 2 			// Lower secondary school
replace edu_visit_a = 3 if inlist(lr3078,3,4)   // Upper secondary school

* Label variable
#delimit ;
lab define edu_visit_a_lab 
	1 "Grundschule" 
	2 "Mittelschule" 
	3 "weiterführende Schule"
	, replace;
#delimit cr
label value edu_visit_a edu_visit_a_lab
bys pid (syear): carryforward edu_visit_a, replace
bys pid (minuswelle): carryforward edu_visit_a, replace

** Occupational degree, before migration
* Recoding variable
gen occ_deg_a = .
replace occ_deg_a = 1 if inlist(pbbila,12,13)  	// Vocational degree 
replace occ_deg_a = 2 if inlist(pbbila,14)  	// University degree
replace occ_deg_a = 3 if inlist(pbbila,19) 		// PhD degree

* Label variable
#delimit ;
lab define occ_deg_a_lab 
	1 "Vocational degree"
	2 "University degree" 
	3 "PhD degree"
	, replace;
#delimit cr
label value occ_deg_a occ_deg_a_lab
bys pid (syear): carryforward occ_deg_a, replace
bys pid (minuswelle): carryforward occ_deg_a, replace

** Type of occupational training, before migration
* Recoding variable
gen occ_type_a = .
replace occ_type_a = 1 if inlist(pbbila,1,11) 		// On-the-job-training
replace occ_type_a = 2 if inlist(pbbila,2,3,12,13) 	// Vocational training
replace occ_type_a = 4 if inlist(pbbila,4,14) 		// Study/University
replace occ_type_a = 5 if inlist(pbbila,9,19) 		// PhD

* Label variable
#delimit ;
lab define occ_type_a_lab
	1 "On-the-job-training"
	2 "Vocational training"
	4 "Study/University" 
	5 "PhD"
	, replace;
#delimit cr
label value occ_type_a occ_type_a_lab

** No school, before migration
gen no_school = 1 if lr3076  == 2 | lb0183 == 2  
bys pid (syear): carryforward no_school, replace
bys pid (minuswelle): carryforward no_school, replace

** Durration of education
recode lb0187 (-8/-1 = .)
bys pid (syear): carryforward lb0187, replace
bys pid (minuswelle): carryforward lb0187, replace

************************************ ISCED A ***********************************
** ISCED, attained abroad

capture drop isceda11a
gen isceda11a = .
label value isceda11a isced_lab
label var isceda11a "ISCED A, before migration"

* "(0) 0 Less than primary education/No school"
replace isceda11a = 0 if no_school == 1 |  									///
		(edu_visit_a == 1 & inlist(years_sch0,0,1,2,3,4,5)) | 				///
		(edu_deg_a == 0 & inlist(years_sch0,0,1,2,3,4,5))
* "(1) Primary education"	
replace isceda11a=1 if (edu_deg_a == 0 & years_sch0 >= 6 & years_sch0 < .) | ///
		(edu_visit_a == 1 & years_sch0 >= 6 & years_sch0 < .) | 			 ///
		inlist(edu_visit_a,2,3) 
* "(2) Lower secondary education"
replace isceda11a = 2 if edu_deg_a == 1 | 									///
		inlist(edu_visit_a,3) | 											///
		(inlist(occ_type_a,1,2) & occ_deg_a != 1)
* "(3) Upper secondary education"
replace isceda11a = 3 if edu_deg_a == 2 | occ_deg_a == 1 | 					///
		inlist(occ_type_a,4,5)  
* "(4) Post-secondary non-tertiary education
replace isceda11a = 4 if (edu_deg_a == 2 | inlist(occ_type_a,4,5)) & 		///
		occ_deg_a == 1 
*"(6,7) Bachelor's/ Master's or equivalent level"			
replace isceda11a = 6 if occ_deg_a == 2 | occ_type_a == 5
*"(8) Doctoral or equivalent level", replace
replace isceda11a = 8 if occ_deg_a == 3
	
tab isceda11a, m
bys pid (welle): carryforward isceda11a, replace
bys pid (minuswelle): carryforward isceda11a, replace

************************************ ISCED P ***********************************
** ISCED, partocipated abroad

capture drop iscedp11a
gen iscedp11a = .
label value iscedp11a isced_lab
label var iscedp11a "ISCED P, before migration"

* "(0) 0 Less than primary education/ No school"
replace iscedp11a = 0 if no_school == 1
* "(1) Primary education"	
replace iscedp11a = 1 if edu_deg_a == 0 | edu_visit_a == 1 
* "(2) Lower secondary education"
replace iscedp11a = 2 if edu_deg_a == 1 | inlist(edu_visit_a,2) 
* "(3) Upper secondary education"
replace iscedp11a = 3 if edu_deg_a == 2 | occ_deg_a == 1  | 				///
		inlist(edu_visit_a,3) | inlist(occ_type_a,1,2)
* "(4) Post-secondary non-tertiary education
replace iscedp11a = 4 if (edu_deg_a == 2 & occ_deg_a == 1) | 				///
		(edu_deg_a == 2 & inlist(occ_type_a,1,2))
*"(6,7) Bachelor's/ Master's or equivalent level"			
replace iscedp11a = 6 if occ_deg_a == 2 | occ_type_a == 4
*"(8) Doctoral or equivalent level", replace
replace iscedp11a = 8 if occ_deg_a == 3 | occ_type_a == 5

tab iscedp11a, m
bys pid (welle): carryforward iscedp11a, replace
bys pid (minuswelle): carryforward iscedp11a, replace

************************************ ISCED A ***********************************
** ISCED, aggregated

* Label variable
#delimit ;
lab def isceda11a_aggr_lab
	0 "ISCED 0 - Less than primary education" 
	1 "ISCED 1 - Primary education"
	2 "ISCED 2 - Lower secondary education" 
	3 "ISCED 3/4 - Upper secondary education/Post-secondary non-tertiary education" 
	4 "ISCED 5/6/7/8 - Bachelor's/Master's/Doctoral or equivalent level"
	, replace;
#delimit cr

* Generating variable
recode isceda11a (0=0) (1=1) (2=2) (3/4 = 3) (6/8 = 4), gen(isceda11a_aggr)
lab val isceda11a_aggr isceda11a_aggr_lab
recode iscedp11a (0=0) (1=1) (2=2) (3/4 = 3) (6/8 = 4), gen(iscedp11a_aggr)
lab val iscedp11a_aggr isceda11a_aggr_lab
lab var iscedp11a_aggr "Aggregated ISCED A, before migration"
lab var isceda11a_aggr "Aggregated ISCED P, before migration"

********************************************************************************
*** Labour market participation
********************************************************************************
********************************************************************************
* Gainfully employed (paid)
********************************************************************************

* Generating variable for paid employed
gen paid_work = .
replace paid_work = 1 if inlist(plb0022_h,1,2,3,4,10,12)
replace paid_work = 0 if inlist(plb0022_h,5,7,9)
replace paid_work = 0 if labgro == 0 

* Label variable
lab define paid_work_lab 1 "Yes" 0 "No", replace
lab val paid_work paid_work_lab
lab var paid_work "Gainfully employed (paid)"

********************************************************************************
* Employment status
********************************************************************************

* Generating variable for emplyment status
gen emp_status_3cat = .
recode emp_status_3cat . = 1 if paid_work == 1
recode emp_status_3cat . = 2 if plb0424_v2 == 1
recode emp_status_3cat . = 3 if plb0424_v2 == 2
recode emp_status_3cat . = 3 if paid_work == 0

* Label variable
#delimit
	lab def emp_status_3cat_lab
		1 "Gainfully employed (paid)" 
		2 "Actively looking for work (last 4 weeks)" 
		3 "Inactive"
		, replace;
#delimit cr
lab val emp_status_3cat emp_status_3cat_lab
lab var emp_status_3cat "Employment status, 3 cat."

********************************************************************************
** Residence title
********************************************************************************

* Generating variable
recode plj0680_v1 plj0680_v2 (-10/-1 = .)
gen resid_title = .
replace resid_title = 1 if inlist(plj0680_v1,1)
replace resid_title = 1 if inlist(plj0680_v2,1,9)
replace resid_title = 2 if inlist(plj0680_v2,5) 
replace resid_title = 2 if inlist(plj0680_v1,5) 
replace resid_title = 3 if inlist(plj0680_v1,2,3,6,7)
replace resid_title = 3 if inlist(plj0680_v2,2,3,4,6,7)  
replace resid_title = 4 if inlist(plj0680_v1,4) 
replace resid_title = 4 if inlist(plj0680_v2,8)
replace resid_title = 5 if inlist(plj0680_v2,11) 
replace resid_title = 6 if inlist(plj0680_v1,8) 
replace resid_title = 6 if inlist(plj0680_v2,10) 

* Label variable
#delimit
lab def resid_title_lab
	1 "In process/Not yet decided"
	2 "Exceptional permission to remain (Duldung)"
	3 "Residence permit/temporary residence title"
	4 "Settlement permit/temporary unlimited residence title"
	5 "No residence permission"
	6 "Other title", replace;
#delimit cr
lab val resid_title resid_title_lab
label var resid_title "Current residence title, aggr"

********************************************************************************
** Cleaning Varibales
********************************************************************************

#delimit
keep
	cid hid pid syear sampreg instrument intid eduasl welle psample  
	female age age_cat age_cat2 citizenship citizenship_iso 
	citizenship_iso_num stateless citizenship_iso_num_tc citizenship_iso_tc 
	staatsang_tc1 herkunftsland arrival_yr arrival_mth arrival_date 
	years_sch0 years_train0 total_years_edu0 isceda11a iscedp11a 
	isceda11a_aggr iscedp11a_aggr isced11 resid_title hhgr hgtyp1hh hwunt
	phrf hhrf emp_status_3cat;
#delimit cr

********************************************************************************
** Saving Data
********************************************************************************

save $dataout/INTER_iab_bamf_soep_v38_redu_clean.dta, replace

capture log close

********************************************************************************
