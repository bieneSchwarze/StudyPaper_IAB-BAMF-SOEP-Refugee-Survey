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
hbrutto <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/hbrutto.dta")
hbrutto_v38 <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38/consolidated14/hbrutto.dta")
# individual data (gross sample)
pbrutto1 <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/pbrutto.dta")
pbrutto2 <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/pbrutto.dta") %>%
  filter(syear == 2021) %>%
  select(pid, geburt_h, paapor) 
pbrutto_v38 <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38/consolidated14/pbrutto.dta")
# individual data (net sample)
bgp <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/bgp.dta") # 2016
bhp <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/bhp.dta") # 2017
bhp_v38 <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38/consolidated14/bhp.dta") # 2017 ## check
bip <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/bip.dta") # 2018
bjp <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/bjp.dta") # 2019
bkp <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/bkp.dta") # 2020
instrumentation <- read_dta("//hume/rdc-prod/complete/soep-core/soep.v38.1/consolidated14/instrumentation.dta") %>% # 2021
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
# TO BE ADDED
