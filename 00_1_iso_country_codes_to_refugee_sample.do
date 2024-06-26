
*** gen country of birth and citizenship_var with iso 3166 country codes
*** make country of birth from "lgebal" and citizenship_var from "ppnat". 
*** add iso codes for merges.
*** Attention: some might be missing in the end
*** Kosovo gets KOS and 999
*** Tschetschenien will be Russia
*** there are also stateless people in the data


* value label for iso num
#delimit
label define ISO_englisch_short_name
  4 "Afghanistan" 
  248 "Åland Islands" 
  8 "Albania" 
  12 "Algeria" 
  16 "American Samoa" 
  20 "Andorra" 
  24 "Angola" 
  660 "Anguilla" 
  10 "Antarctica" 
  28 "Antigua and Barbuda" 
  32 "Argentina" 
  51 "Armenia" 
  533 "Aruba" 
  36 "Australia" 
  40 "Austria" 
  31 "Azerbaijan" 
  44 "Bahamas (the)" 
  48 "Bahrain" 
  50 "Bangladesh" 
  52 "Barbados" 
  112 "Belarus" 
  56 "Belgium" 
  84 "Belize" 
  204 "Benin" 
  60 "Bermuda" 
  64 "Bhutan" 
  68 "Bolivia (Plurinational State of)" 
  535 "Bonaire, Sint Eustatius and Saba" 
  70 "Bosnia and Herzegovina" 
  72 "Botswana" 
  74 "Bouvet Island" 
  76 "Brazil" 
  86 "British Indian Ocean Territory (the)" 
  96 "Brunei Darussalam" 
  100 "Bulgaria" 
  854 "Burkina Faso" 
  108 "Burundi" 
  132 "Cabo Verde" 
  116 "Cambodia" 
  120 "Cameroon" 
  124 "Canada" 
  136 "Cayman Islands (the)" 
  140 "Central African Republic (the)" 
  148 "Chad" 
  152 "Chile" 
  156 "China" 
  162 "Christmas Island" 
  166 "Cocos (Keeling) Islands (the)" 
  170 "Colombia" 
  174 "Comoros (the)" 
  180 "Congo (the Democratic Republic of the)" 
  178 "Congo (the)" 
  184 "Cook Islands (the)" 
  188 "Costa Rica" 
  384 "Côte d'Ivoire" 
  191 "Croatia" 
  192 "Cuba" 
  531 "Curaçao" 
  196 "Cyprus" 
  203 "Czechia" 
  208 "Denmark" 
  262 "Djibouti" 
  212 "Dominica" 
  214 "Dominican Republic (the)" 
  218 "Ecuador" 
  818 "Egypt" 
  222 "El Salvador" 
  226 "Equatorial Guinea" 
  232 "Eritrea" 
  233 "Estonia" 
  231 "Ethiopia" 
  238 "Falkland Islands (the) [Malvinas]" 
  234 "Faroe Islands (the)" 
  242 "Fiji" 
  246 "Finland" 
  250 "France" 
  254 "French Guiana" 
  258 "French Polynesia" 
  260 "French Southern Territories (the)" 
  266 "Gabon" 
  270 "Gambia (the)" 
  268 "Georgia" 
  276 "Germany" 
  288 "Ghana" 
  292 "Gibraltar" 
  300 "Greece" 
  304 "Greenland" 
  308 "Grenada" 
  312 "Guadeloupe" 
  316 "Guam" 
  320 "Guatemala" 
  831 "Guernsey" 
  324 "Guinea" 
  624 "Guinea-Bissau" 
  328 "Guyana" 
  332 "Haiti" 
  334 "Heard Island and McDonald Islands" 
  336 "Holy See (the)" 
  340 "Honduras" 
  344 "Hong Kong" 
  348 "Hungary" 
  352 "Iceland" 
  356 "India" 
  360 "Indonesia" 
  364 "Iran (Islamic Republic of)" 
  368 "Iraq" 
  372 "Ireland" 
  833 "Isle of Man" 
  376 "Israel" 
  380 "Italy" 
  388 "Jamaica" 
  392 "Japan" 
  832 "Jersey" 
  400 "Jordan" 
  398 "Kazakhstan" 
  404 "Kenya" 
  296 "Kiribati" 
  408 "Korea (the Democratic People's Republic of)" 
  410 "Korea (the Republic of)" 
  414 "Kuwait" 
  417 "Kyrgyzstan" 
  418 "Lao People's Democratic Republic (the)" 
  428 "Latvia" 
  422 "Lebanon" 
  426 "Lesotho" 
  430 "Liberia" 
  434 "Libya" 
  438 "Liechtenstein" 
  440 "Lithuania" 
  442 "Luxembourg" 
  446 "Macao" 
  807 "Macedonia (the former Yugoslav Republic of)" 
  450 "Madagascar" 
  454 "Malawi" 
  458 "Malaysia" 
  462 "Maldives" 
  466 "Mali" 
  470 "Malta" 
  584 "Marshall Islands (the)" 
  474 "Martinique" 
  478 "Mauritania" 
  480 "Mauritius" 
  175 "Mayotte" 
  484 "Mexico" 
  583 "Micronesia (Federated States of)" 
  498 "Moldova (the Republic of)" 
  492 "Monaco" 
  496 "Mongolia" 
  499 "Montenegro" 
  500 "Montserrat" 
  504 "Morocco" 
  508 "Mozambique" 
  104 "Myanmar" 
  516 "Namibia" 
  520 "Nauru" 
  524 "Nepal" 
  528 "Netherlands (the)" 
  540 "New Caledonia" 
  554 "New Zealand" 
  558 "Nicaragua" 
  562 "Niger (the)" 
  566 "Nigeria" 
  570 "Niue" 
  574 "Norfolk Island" 
  580 "Northern Mariana Islands (the)" 
  578 "Norway" 
  512 "Oman" 
  586 "Pakistan" 
  585 "Palau" 
  275 "Palestine, State of" 
  591 "Panama" 
  598 "Papua New Guinea" 
  600 "Paraguay" 
  604 "Peru" 
  608 "Philippines (the)" 
  612 "Pitcairn" 
  616 "Poland" 
  620 "Portugal" 
  630 "Puerto Rico" 
  634 "Qatar" 
  638 "Réunion" 
  642 "Romania" 
  643 "Russian Federation (the)" 
  646 "Rwanda" 
  652 "Saint Barthélemy" 
  654 "Saint Helena, Ascension and Tristan da Cunha" 
  659 "Saint Kitts and Nevis" 
  662 "Saint Lucia" 
  663 "Saint Martin (French part)" 
  666 "Saint Pierre and Miquelon" 
  670 "Saint Vincent and the Grenadines" 
  882 "Samoa" 
  674 "San Marino" 
  678 "Sao Tome and Principe" 
  682 "Saudi Arabia" 
  686 "Senegal" 
  688 "Serbia" 
  690 "Seychelles" 
  694 "Sierra Leone" 
  702 "Singapore" 
  534 "Sint Maarten (Dutch part)" 
  703 "Slovakia" 
  705 "Slovenia" 
  90 "Solomon Islands" 
  706 "Somalia" 
  710 "South Africa" 
  239 "South Georgia and the South Sandwich Islands" 
  728 "South Sudan" 
  724 "Spain" 
  144 "Sri Lanka" 
  729 "Sudan (the)" 
  740 "Suriname" 
  744 "Svalbard and Jan Mayen" 
  748 "Swaziland" 
  752 "Sweden" 
  756 "Switzerland" 
  760 "Syrian Arab Republic" 
  158 "Taiwan (Province of China)" 
  762 "Tajikistan" 
  834 "Tanzania, United Republic of" 
  764 "Thailand" 
  626 "Timor-Leste" 
  768 "Togo" 
  772 "Tokelau" 
  776 "Tonga" 
  780 "Trinidad and Tobago" 
  788 "Tunisia" 
  792 "Turkey" 
  795 "Turkmenistan" 
  796 "Turks and Caicos Islands (the)" 
  798 "Tuvalu" 
  800 "Uganda" 
  804 "Ukraine" 
  784 "United Arab Emirates (the)" 
  826 "United Kingdom of Great Britain and Northern Ireland (the)" 
  581 "United States Minor Outlying Islands (the)" 
  840 "United States of America (the)" 
  858 "Uruguay" 
  860 "Uzbekistan" 
  548 "Vanuatu" 
  862 "Venezuela (Bolivarian Republic of)" 
  704 "Viet Nam" 
  92 "Virgin Islands (British)" 
  850 "Virgin Islands (U.S.)" 
  876 "Wallis and Futuna" 
  732 "Western Sahara*" 
  887 "Yemen" 
  894 "Zambia" 
  716 "Zimbabwe" 
  999 "Kosovo"
  0 "Stateless/Missing"
 , replace
 ;
#delimit cr

gen citizenship_var = country_name
label var citizenship_var "citizenship_var"

*** make iso code

gen iso3166 = "miss"
replace iso3166 = "miss" if citizenship_var == 9999
replace iso3166 = "AFG" if citizenship_var == 4
replace iso3166 = "ALB" if citizenship_var == 8
replace iso3166 = "DZA" if citizenship_var == 12
replace iso3166 = "AGO" if citizenship_var == 24
replace iso3166 = "ARM" if citizenship_var == 51
replace iso3166 = "AZE" if citizenship_var == 31
replace iso3166 = "BGD" if citizenship_var == 50
replace iso3166 = "BIH" if citizenship_var == 70
replace iso3166 = "BGR" if citizenship_var == 100
replace iso3166 = "BFA" if citizenship_var == 854
replace iso3166 = "CMR" if citizenship_var == 120
replace iso3166 = "TCD" if citizenship_var == 148
replace iso3166 = "COL" if citizenship_var == 170
replace iso3166 = "COD" if citizenship_var == 180
replace iso3166 = "COG" if citizenship_var == 178
replace iso3166 = "CIV" if citizenship_var == 384
replace iso3166 = "EGY" if citizenship_var == 818
replace iso3166 = "ERI" if citizenship_var == 232
replace iso3166 = "ETH" if citizenship_var == 231
replace iso3166 = "GMB" if citizenship_var == 270
replace iso3166 = "GEO" if citizenship_var == 268
replace iso3166 = "DEU" if citizenship_var == 276
replace iso3166 = "GHA" if citizenship_var == 288
replace iso3166 = "GIN" if citizenship_var == 324
replace iso3166 = "GNB" if citizenship_var == 328
replace iso3166 = "HUN" if citizenship_var == 348
replace iso3166 = "IND" if citizenship_var == 356
replace iso3166 = "IRN" if citizenship_var == 364
replace iso3166 = "IRQ" if citizenship_var == 368
replace iso3166 = "JOR" if citizenship_var == 400
replace iso3166 = "KEN" if citizenship_var == 404
replace iso3166 = "KGZ" if citizenship_var == 417
replace iso3166 = "LBN" if citizenship_var == 422
replace iso3166 = "LBY" if citizenship_var == 434
replace iso3166 = "MKD" if citizenship_var == 807
replace iso3166 = "MLI" if citizenship_var == 466
replace iso3166 = "MDA" if citizenship_var == 498
replace iso3166 = "MNG" if citizenship_var == 496
replace iso3166 = "MNE" if citizenship_var == 499
replace iso3166 = "MAR" if citizenship_var == 504
replace iso3166 = "MMR" if citizenship_var == 104
replace iso3166 = "NPL" if citizenship_var == 524
replace iso3166 = "NER" if citizenship_var == 562
replace iso3166 = "NGA" if citizenship_var == 566
replace iso3166 = "PAK" if citizenship_var == 586
replace iso3166 = "PSE" if citizenship_var == 275
replace iso3166 = "POL" if citizenship_var == 616
replace iso3166 = "ROU" if citizenship_var == 642
replace iso3166 = "RUS" if citizenship_var == 643
replace iso3166 = "RWA" if citizenship_var == 646
replace iso3166 = "SEN" if citizenship_var == 686
replace iso3166 = "SRB" if citizenship_var == 688
replace iso3166 = "SLE" if citizenship_var == 694
replace iso3166 = "SLB" if citizenship_var == 90
replace iso3166 = "SOM" if citizenship_var == 706
replace iso3166 = "SSD" if citizenship_var == 728
replace iso3166 = "LKA" if citizenship_var == 144
replace iso3166 = "SDN" if citizenship_var == 729
replace iso3166 = "SYR" if citizenship_var == 760
replace iso3166 = "TJK" if citizenship_var == 762
replace iso3166 = "TUN" if citizenship_var == 788
replace iso3166 = "TUR" if citizenship_var == 792
replace iso3166 = "TKM" if citizenship_var == 795
replace iso3166 = "UGA" if citizenship_var == 800
replace iso3166 = "UKR" if citizenship_var == 804
replace iso3166 = "ARE" if citizenship_var == 682
replace iso3166 = "UZB" if citizenship_var == 860
replace iso3166 = "VEN" if citizenship_var == 862
replace iso3166 = "VNM" if citizenship_var == 704
replace iso3166 = "YEM" if citizenship_var == 887
replace iso3166 = "KOS" if citizenship_var == 900


* give numeric iso values
gen iso_num_o = 000 

replace iso_num_o =  4 if  iso3166 == "AFG"
replace iso_num_o =  248 if  iso3166 == "ALA"
replace iso_num_o =  8 if  iso3166 == "ALB"
replace iso_num_o =  12 if  iso3166 == "DZA"
replace iso_num_o =  16 if  iso3166 == "ASM"
replace iso_num_o =  20 if  iso3166 == "AND"
replace iso_num_o =  24 if  iso3166 == "AGO"
replace iso_num_o =  660 if  iso3166 == "AIA"
replace iso_num_o =  10 if  iso3166 == "ATA"
replace iso_num_o =  28 if  iso3166 == "ATG"
replace iso_num_o =  32 if  iso3166 == "ARG"
replace iso_num_o =  51 if  iso3166 == "ARM"
replace iso_num_o =  533 if  iso3166 == "ABW"
replace iso_num_o =  36 if  iso3166 == "AUS"
replace iso_num_o =  40 if  iso3166 == "AUT"
replace iso_num_o =  31 if  iso3166 == "AZE"
replace iso_num_o =  44 if  iso3166 == "BHS"
replace iso_num_o =  48 if  iso3166 == "BHR"
replace iso_num_o =  50 if  iso3166 == "BGD"
replace iso_num_o =  52 if  iso3166 == "BRB"
replace iso_num_o =  112 if  iso3166 == "BLR"
replace iso_num_o =  56 if  iso3166 == "BEL"
replace iso_num_o =  84 if  iso3166 == "BLZ"
replace iso_num_o =  204 if  iso3166 == "BEN"
replace iso_num_o =  60 if  iso3166 == "BMU"
replace iso_num_o =  64 if  iso3166 == "BTN"
replace iso_num_o =  68 if  iso3166 == "BOL"
replace iso_num_o =  535 if  iso3166 == "BES"
replace iso_num_o =  70 if  iso3166 == "BIH"
replace iso_num_o =  72 if  iso3166 == "BWA"
replace iso_num_o =  74 if  iso3166 == "BVT"
replace iso_num_o =  76 if  iso3166 == "BRA"
replace iso_num_o =  86 if  iso3166 == "IOT"
replace iso_num_o =  96 if  iso3166 == "BRN"
replace iso_num_o =  100 if  iso3166 == "BGR"
replace iso_num_o =  854 if  iso3166 == "BFA"
replace iso_num_o =  108 if  iso3166 == "BDI"
replace iso_num_o =  132 if  iso3166 == "CPV"
replace iso_num_o =  116 if  iso3166 == "KHM"
replace iso_num_o =  120 if  iso3166 == "CMR"
replace iso_num_o =  124 if  iso3166 == "CAN"
replace iso_num_o =  136 if  iso3166 == "CYM"
replace iso_num_o =  140 if  iso3166 == "CAF"
replace iso_num_o =  148 if  iso3166 == "TCD"
replace iso_num_o =  152 if  iso3166 == "CHL"
replace iso_num_o =  156 if  iso3166 == "CHN"
replace iso_num_o =  162 if  iso3166 == "CXR"
replace iso_num_o =  166 if  iso3166 == "CCK"
replace iso_num_o =  170 if  iso3166 == "COL"
replace iso_num_o =  174 if  iso3166 == "COM"
replace iso_num_o =  180 if  iso3166 == "COD"
replace iso_num_o =  178 if  iso3166 == "COG"
replace iso_num_o =  184 if  iso3166 == "COK"
replace iso_num_o =  188 if  iso3166 == "CRI"
replace iso_num_o =  384 if  iso3166 == "CIV"
replace iso_num_o =  191 if  iso3166 == "HRV"
replace iso_num_o =  192 if  iso3166 == "CUB"
replace iso_num_o =  531 if  iso3166 == "CUW"
replace iso_num_o =  196 if  iso3166 == "CYP"
replace iso_num_o =  203 if  iso3166 == "CZE"
replace iso_num_o =  208 if  iso3166 == "DNK"
replace iso_num_o =  262 if  iso3166 == "DJI"
replace iso_num_o =  212 if  iso3166 == "DMA"
replace iso_num_o =  214 if  iso3166 == "DOM"
replace iso_num_o =  218 if  iso3166 == "ECU"
replace iso_num_o =  818 if  iso3166 == "EGY"
replace iso_num_o =  222 if  iso3166 == "SLV"
replace iso_num_o =  226 if  iso3166 == "GNQ"
replace iso_num_o =  232 if  iso3166 == "ERI"
replace iso_num_o =  233 if  iso3166 == "EST"
replace iso_num_o =  231 if  iso3166 == "ETH"
replace iso_num_o =  238 if  iso3166 == "FLK"
replace iso_num_o =  234 if  iso3166 == "FRO"
replace iso_num_o =  242 if  iso3166 == "FJI"
replace iso_num_o =  246 if  iso3166 == "FIN"
replace iso_num_o =  250 if  iso3166 == "FRA"
replace iso_num_o =  254 if  iso3166 == "GUF"
replace iso_num_o =  258 if  iso3166 == "PYF"
replace iso_num_o =  260 if  iso3166 == "ATF"
replace iso_num_o =  266 if  iso3166 == "GAB"
replace iso_num_o =  270 if  iso3166 == "GMB"
replace iso_num_o =  268 if  iso3166 == "GEO"
replace iso_num_o =  276 if  iso3166 == "DEU"
replace iso_num_o =  288 if  iso3166 == "GHA"
replace iso_num_o =  292 if  iso3166 == "GIB"
replace iso_num_o =  300 if  iso3166 == "GRC"
replace iso_num_o =  304 if  iso3166 == "GRL"
replace iso_num_o =  308 if  iso3166 == "GRD"
replace iso_num_o =  312 if  iso3166 == "GLP"
replace iso_num_o =  316 if  iso3166 == "GUM"
replace iso_num_o =  320 if  iso3166 == "GTM"
replace iso_num_o =  831 if  iso3166 == "GGY"
replace iso_num_o =  324 if  iso3166 == "GIN"
replace iso_num_o =  624 if  iso3166 == "GNB"
replace iso_num_o =  328 if  iso3166 == "GUY"
replace iso_num_o =  332 if  iso3166 == "HTI"
replace iso_num_o =  334 if  iso3166 == "HMD"
replace iso_num_o =  336 if  iso3166 == "VAT"
replace iso_num_o =  340 if  iso3166 == "HND"
replace iso_num_o =  344 if  iso3166 == "HKG"
replace iso_num_o =  348 if  iso3166 == "HUN"
replace iso_num_o =  352 if  iso3166 == "ISL"
replace iso_num_o =  356 if  iso3166 == "IND"
replace iso_num_o =  360 if  iso3166 == "IDN"
replace iso_num_o =  364 if  iso3166 == "IRN"
replace iso_num_o =  368 if  iso3166 == "IRQ"
replace iso_num_o =  372 if  iso3166 == "IRL"
replace iso_num_o =  833 if  iso3166 == "IMN"
replace iso_num_o =  376 if  iso3166 == "ISR"
replace iso_num_o =  380 if  iso3166 == "ITA"
replace iso_num_o =  388 if  iso3166 == "JAM"
replace iso_num_o =  392 if  iso3166 == "JPN"
replace iso_num_o =  832 if  iso3166 == "JEY"
replace iso_num_o =  400 if  iso3166 == "JOR"
replace iso_num_o =  398 if  iso3166 == "KAZ"
replace iso_num_o =  404 if  iso3166 == "KEN"
replace iso_num_o =  296 if  iso3166 == "KIR"
replace iso_num_o =  408 if  iso3166 == "PRK"
replace iso_num_o =  410 if  iso3166 == "KOR"
replace iso_num_o =  414 if  iso3166 == "KWT"
replace iso_num_o =  417 if  iso3166 == "KGZ"
replace iso_num_o =  418 if  iso3166 == "LAO"
replace iso_num_o =  428 if  iso3166 == "LVA"
replace iso_num_o =  422 if  iso3166 == "LBN"
replace iso_num_o =  426 if  iso3166 == "LSO"
replace iso_num_o =  430 if  iso3166 == "LBR"
replace iso_num_o =  434 if  iso3166 == "LBY"
replace iso_num_o =  438 if  iso3166 == "LIE"
replace iso_num_o =  440 if  iso3166 == "LTU"
replace iso_num_o =  442 if  iso3166 == "LUX"
replace iso_num_o =  446 if  iso3166 == "MAC"
replace iso_num_o =  807 if  iso3166 == "MKD"
replace iso_num_o =  450 if  iso3166 == "MDG"
replace iso_num_o =  454 if  iso3166 == "MWI"
replace iso_num_o =  458 if  iso3166 == "MYS"
replace iso_num_o =  462 if  iso3166 == "MDV"
replace iso_num_o =  466 if  iso3166 == "MLI"
replace iso_num_o =  470 if  iso3166 == "MLT"
replace iso_num_o =  584 if  iso3166 == "MHL"
replace iso_num_o =  474 if  iso3166 == "MTQ"
replace iso_num_o =  478 if  iso3166 == "MRT"
replace iso_num_o =  480 if  iso3166 == "MUS"
replace iso_num_o =  175 if  iso3166 == "MYT"
replace iso_num_o =  484 if  iso3166 == "MEX"
replace iso_num_o =  583 if  iso3166 == "FSM"
replace iso_num_o =  498 if  iso3166 == "MDA"
replace iso_num_o =  492 if  iso3166 == "MCO"
replace iso_num_o =  496 if  iso3166 == "MNG"
replace iso_num_o =  499 if  iso3166 == "MNE"
replace iso_num_o =  500 if  iso3166 == "MSR"
replace iso_num_o =  504 if  iso3166 == "MAR"
replace iso_num_o =  508 if  iso3166 == "MOZ"
replace iso_num_o =  104 if  iso3166 == "MMR"
replace iso_num_o =  516 if  iso3166 == "NAM"
replace iso_num_o =  520 if  iso3166 == "NRU"
replace iso_num_o =  524 if  iso3166 == "NPL"
replace iso_num_o =  528 if  iso3166 == "NLD"
replace iso_num_o =  540 if  iso3166 == "NCL"
replace iso_num_o =  554 if  iso3166 == "NZL"
replace iso_num_o =  558 if  iso3166 == "NIC"
replace iso_num_o =  562 if  iso3166 == "NER"
replace iso_num_o =  566 if  iso3166 == "NGA"
replace iso_num_o =  570 if  iso3166 == "NIU"
replace iso_num_o =  574 if  iso3166 == "NFK"
replace iso_num_o =  580 if  iso3166 == "MNP"
replace iso_num_o =  578 if  iso3166 == "NOR"
replace iso_num_o =  512 if  iso3166 == "OMN"
replace iso_num_o =  586 if  iso3166 == "PAK"
replace iso_num_o =  585 if  iso3166 == "PLW"
replace iso_num_o =  275 if  iso3166 == "PSE"
replace iso_num_o =  591 if  iso3166 == "PAN"
replace iso_num_o =  598 if  iso3166 == "PNG"
replace iso_num_o =  600 if  iso3166 == "PRY"
replace iso_num_o =  604 if  iso3166 == "PER"
replace iso_num_o =  608 if  iso3166 == "PHL"
replace iso_num_o =  612 if  iso3166 == "PCN"
replace iso_num_o =  616 if  iso3166 == "POL"
replace iso_num_o =  620 if  iso3166 == "PRT"
replace iso_num_o =  630 if  iso3166 == "PRI"
replace iso_num_o =  634 if  iso3166 == "QAT"
replace iso_num_o =  638 if  iso3166 == "REU"
replace iso_num_o =  642 if  iso3166 == "ROU"
replace iso_num_o =  643 if  iso3166 == "RUS"
replace iso_num_o =  646 if  iso3166 == "RWA"
replace iso_num_o =  652 if  iso3166 == "BLM"
replace iso_num_o =  654 if  iso3166 == "SHN"
replace iso_num_o =  659 if  iso3166 == "KNA"
replace iso_num_o =  662 if  iso3166 == "LCA"
replace iso_num_o =  663 if  iso3166 == "MAF"
replace iso_num_o =  666 if  iso3166 == "SPM"
replace iso_num_o =  670 if  iso3166 == "VCT"
replace iso_num_o =  882 if  iso3166 == "WSM"
replace iso_num_o =  674 if  iso3166 == "SMR"
replace iso_num_o =  678 if  iso3166 == "STP"
replace iso_num_o =  682 if  iso3166 == "SAU"
replace iso_num_o =  686 if  iso3166 == "SEN"
replace iso_num_o =  688 if  iso3166 == "SRB"
replace iso_num_o =  690 if  iso3166 == "SYC"
replace iso_num_o =  694 if  iso3166 == "SLE"
replace iso_num_o =  702 if  iso3166 == "SGP"
replace iso_num_o =  534 if  iso3166 == "SXM"
replace iso_num_o =  703 if  iso3166 == "SVK"
replace iso_num_o =  705 if  iso3166 == "SVN"
replace iso_num_o =  90 if  iso3166 == "SLB"
replace iso_num_o =  706 if  iso3166 == "SOM"
replace iso_num_o =  710 if  iso3166 == "ZAF"
replace iso_num_o =  239 if  iso3166 == "SGS"
replace iso_num_o =  728 if  iso3166 == "SSD"
replace iso_num_o =  724 if  iso3166 == "ESP"
replace iso_num_o =  144 if  iso3166 == "LKA"
replace iso_num_o =  729 if  iso3166 == "SDN"
replace iso_num_o =  740 if  iso3166 == "SUR"
replace iso_num_o =  744 if  iso3166 == "SJM"
replace iso_num_o =  748 if  iso3166 == "SWZ"
replace iso_num_o =  752 if  iso3166 == "SWE"
replace iso_num_o =  756 if  iso3166 == "CHE"
replace iso_num_o =  760 if  iso3166 == "SYR"
replace iso_num_o =  158 if  iso3166 == "TWN"
replace iso_num_o =  762 if  iso3166 == "TJK"
replace iso_num_o =  834 if  iso3166 == "TZA"
replace iso_num_o =  764 if  iso3166 == "THA"
replace iso_num_o =  626 if  iso3166 == "TLS"
replace iso_num_o =  768 if  iso3166 == "TGO"
replace iso_num_o =  772 if  iso3166 == "TKL"
replace iso_num_o =  776 if  iso3166 == "TON"
replace iso_num_o =  780 if  iso3166 == "TTO"
replace iso_num_o =  788 if  iso3166 == "TUN"
replace iso_num_o =  792 if  iso3166 == "TUR"
replace iso_num_o =  795 if  iso3166 == "TKM"
replace iso_num_o =  796 if  iso3166 == "TCA"
replace iso_num_o =  798 if  iso3166 == "TUV"
replace iso_num_o =  800 if  iso3166 == "UGA"
replace iso_num_o =  804 if  iso3166 == "UKR"
replace iso_num_o =  784 if  iso3166 == "ARE"
replace iso_num_o =  826 if  iso3166 == "GBR"
replace iso_num_o =  581 if  iso3166 == "UMI"
replace iso_num_o =  840 if  iso3166 == "USA"
replace iso_num_o =  858 if  iso3166 == "URY"
replace iso_num_o =  860 if  iso3166 == "UZB"
replace iso_num_o =  548 if  iso3166 == "VUT"
replace iso_num_o =  862 if  iso3166 == "VEN"
replace iso_num_o =  704 if  iso3166 == "VNM"
replace iso_num_o =  92 if  iso3166 == "VGB"
replace iso_num_o =  850 if  iso3166 == "VIR"
replace iso_num_o =  876 if  iso3166 == "WLF"
replace iso_num_o =  732 if  iso3166 == "ESH"
replace iso_num_o =  887 if  iso3166 == "YEM"
replace iso_num_o =  894 if  iso3166 == "ZMB"
replace iso_num_o =  716 if  iso3166 == "ZWE"
replace iso_num_o =  999 if  iso3166 == "KOS"

tab country_name if iso3166 == "miss"

********************************************************************************
