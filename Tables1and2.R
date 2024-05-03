################################################################################
################################################################################
## Supplemental Material to 
##
## "Exploring Integration and Migration Dynamics: 
##  The Research Potentials of a Large-Scale Longitudinal Household Study of Refugees in Germany"
## 
## (i)  Net Case Numbers and Response Rates along Subsamples and Waves (Table 1) 
## (ii) Number of Interviews of Adults, along Waves and offered Languages (Table 2)
##
## 29.04.2024
##
## @authors: M. Wessels, S. Zinn
##
################################################################################
################################################################################

# ------------------------------------------------------------------------------
# Load necessary packages
# ------------------------------------------------------------------------------
library(data.table)
library(dplyr)
library(haven)
library(tidyr)

# ------------------------------------------------------------------------------
# Load necessary data sets from SOEP SUF v38.1
# ------------------------------------------------------------------------------
# household data (gros sample)
hbrutto <- read_dta(".../soep.v38.1/hbrutto.dta")
hbrutto_v38 <- read_dta(".../soep.v38/hbrutto.dta")
# individual data (gross sample)
pbrutto1 <- read_dta(".../soep.v38.1/pbrutto.dta")
pbrutto2 <- read_dta(".../soep.v38.1/pbrutto.dta") %>%
  filter(syear == 2021) %>%
  select(pid, geburt_h, paapor) 
pbrutto_v38 <- read_dta(".../soep.v38/pbrutto.dta")
# individual data (net sample)
bgp <- read_dta(".../soep.v38.1/bgp.dta") # 2016
bhp <- read_dta(".../soep.v38.1/bhp.dta") # 2017
bhp_v38 <- read_dta(".../soep.v38/bhp.dta") # 2017 ## check
bip <- read_dta(".../soep.v38.1/bip.dta") # 2018
bjp <- read_dta(".../soep.v38.1/bjp.dta") # 2019
bkp <- read_dta(".../soep.v38.1/bkp.dta") # 2020
instrumentation <- read_dta(".../soep.v38.1/instrumentation.dta") %>% # 2021
  filter(status == 1 & sample1 %in% c(30, 31, 34, 41) & datatype %in% c(2, 3))

# ------------------------------------------------------------------------------
# Net Case Numbers and Response Rates along Subsamples and Waves (Table 1)
# ------------------------------------------------------------------------------
# household data (size, N)
table1_h_N <- hbrutto %>%
  select(hid, syear, hergs_v2, haapor, sample1) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
         ((hergs_v2 >= 1 & hergs_v2 <= 14) | haapor %in% c(1110, 1120, 1210, 1220)) & syear >= 2016) %>%
  mutate(sample1 = case_when(
    sample1 == 30 ~ "Subsample 1 (M3)", 
    sample1 == 31 ~ "Subsample 2 (M4)", 
    sample1 == 34 ~ "Subsample 3 (M5)", 
    sample1 == 41 ~ "Subsample 4 (M6)", 
  )) %>%
  group_by(syear, sample1) %>%
  summarise(N = n())

table1_h_N_test <- hbrutto %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           !((hergs_v2 >= 1 & hergs_v2 <= 14) | (haapor %in% c(1110, 1120, 1210, 1220))) & 
           syear == 2016) %>%
  select(hid, syear, sample1)
  
# household data (response rate, RR)
table1_h_RR <- hbrutto %>%
  select(hid, syear, hergs_v2, haapor, sample1) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & syear >= 2016) %>% 
  mutate(complete = ifelse((hergs_v2 >= 1 & hergs_v2 <= 14) | haapor %in% c(1110, 1120, 1210, 1220), 1, 0),
         sample1 = case_when(
           sample1 == 30 ~ "Subsample 1 (M3)", 
           sample1 == 31 ~ "Subsample 2 (M4)", 
           sample1 == 34 ~ "Subsample 3 (M5)", 
           sample1 == 41 ~ "Subsample 4 (M6)", 
         )) %>%
  group_by(syear, sample1, complete) %>%
  summarise(N = n()) %>%
  ungroup() %>%
  group_by(syear, sample1) %>%
  mutate(percent = round(N/sum(N), digits = 3))

# individual data (size, N)
table1_p_N <- pbrutto1 %>%
  select(pid, pergz, syear, sample1, geburt_h, paapor) %>%
  mutate(age = syear - geburt_h) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
          age >= 18 & (pergz == 10 | paapor %in% c(1110, 1120, 1210, 1220)) & syear >= 2016) %>%
  mutate(sample1 = case_when(
    sample1 == 30 ~ "Subsample 1 (M3)", 
    sample1 == 31 ~ "Subsample 2 (M4)", 
    sample1 == 34 ~ "Subsample 3 (M5)", 
    sample1 == 41 ~ "Subsample 4 (M6)", 
  )) %>%
  group_by(syear, sample1) %>%
  summarise(N = n())

# individual data (response rate, RR)
table1_p_RR <- pbrutto1 %>%
  select(pid, pergz, syear, sample1, geburt_h, paapor) %>%
  mutate(age = syear - geburt_h) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2016) %>%
  mutate(complete = ifelse((pergz == 10) | paapor %in% c(1110, 1120, 1210, 1220), 1, 0),
    sample1 = case_when(
    sample1 == 30 ~ "Subsample 1 (M3)", 
    sample1 == 31 ~ "Subsample 2 (M4)", 
    sample1 == 34 ~ "Subsample 3 (M5)", 
    sample1 == 41 ~ "Subsample 4 (M6)", 
  )) %>%
  group_by(syear, sample1, complete) %>%
  summarise(N = n()) %>%
  ungroup() %>%
  group_by(syear, sample1) %>%
  mutate(percent = round(N/sum(N), digits = 3))

# ------------------------------------------------------------------------------
# Number of Interviews of Adults, along Waves and offered Languages (Table 2)
# ------------------------------------------------------------------------------
# function for matching language code with language name
fun_lang <- function(lang){
  lang = case_when(
    lang == 1 ~ "German/English", 
    lang == 2 ~ "German/Arabic", 
    lang == 3 ~ "German/Farsi", 
    lang == 4 ~ "German/Pashtu", 
    lang == 5 ~ "German/Urdu", 
    lang == 6 ~ "German/Kurmanji", 
    lang == 8 ~ "German/French", 
    TRUE ~ "Without any translation")
}

# year 2016
table2_16 <- bgp %>%
  mutate(age = syear - bgpbirthy, 
         lang_2016 = fun_lang(pspvers)) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2016) %>%
  group_by(lang_2016) %>%
  summarise(N = n())

# year 2017
table2_17 <- bhp %>%
  mutate(age = syear - bhpbirthy, 
         lang_2017 = fun_lang(bhpspvers)) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2017) %>%
  group_by(lang_2017) %>%
  summarise(N = n())

# year 2018
table2_18 <- bip %>%
  mutate(age = syear - bipbirthy, 
         lang_2018 = fun_lang(bipspvers)) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2018) %>%
  group_by(lang_2018) %>%
  summarise(N = n())

# year 2019
table2_19 <- bjp %>%
  mutate(age = syear - bjpbirthy, 
         lang_2019 = fun_lang(bjpspvers_q154)) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2019) %>%
  group_by(lang_2019) %>%
  summarise(N = n())

# year 2020
table2_20 <- bkp %>%
  mutate(age = syear - bkpbirthy, 
         lang_2020 = fun_lang(bkpspvers)) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2020) %>%
  group_by(lang_2020) %>%
  summarise(N = n())

# year 2021
table2_21 <- left_join(instrumentation, pbrutto2, by = c("pid")) %>%
  mutate(age = syear - geburt_h, 
         lang_2021 = case_when(
           start_language == 1 ~ "Without any translation", 
           start_language == 2 ~ "German/English",
           start_language == 7 ~ "German/Arabic",
           start_language == 8 ~ "German/Farsi",
           TRUE ~ NA
         )) %>%
  filter((sample1 == 30 | sample1 == 31 | sample1 == 34 | sample1 == 41) & 
           age >= 18 & syear >= 2021 & paapor %in% c(1100, 1120, 1210, 1220)) %>%
  group_by(lang_2021) %>%
  summarise(N = n())
