library(tidyverse)
library(readxl)
library(readr)
library(stringr)
library(forcats)
library(plotly)

yt <- read_csv("year_table.csv")
dl <- read_csv("dept_lookup.csv")
yt_small <- yt %>% distinct(SchoolYear, ThesisYear)

# From John Colgrove
d <- read_delim("Schedule-Data-Fall-2007-Fall-2017_20161011_114934.txt", delim = "|") %>%
  mutate(year = str_sub(Semester, -4),
         courseid = paste(Subj, Numb, sep = " ")) %>%
  filter(Numb < 200 & Subj %in% c('PSY', 'BIOL', 'CHEM', 'PHYS', 'MATH')) %>%
  arrange(courseid) %>% 
  inner_join(yt, by = "Semester") %>% 
  inner_join(dl, by = "Subj") %>% 
  mutate(Semester = factor(Semester, levels = c("Fall 2007", "Spring 2008", 
    "Fall 2008","Spring 2009", "Fall 2009", "Spring 2010", "Fall 2010",
    "Spring 2011", "Fall 2011", "Spring 2012", "Fall 2012", "Spring 2013", 
    "Fall 2013", "Spring 2014", "Fall 2014", "Spring 2015", "Fall 2015",
    "Spring 2016", "Fall 2016")))
write_rds(x = d, path = "d.RDS")

dist_d <- d %>% distinct(Department, courseid)

thes_dept <- read_excel("thesis-advisors.xlsx", sheet = 1) %>% 
  slice(1:82) %>% 
  gather(key = "year", value = "advisees", -Department) %>% 
  mutate(year = as.numeric(year)) %>% 
  filter(year >= 2007)
thes_fac <- read_excel("thesis-advisors.xlsx", sheet = 2) 
colnames(thes_fac)[1] <-  "faculty" 
thes_fac <- thes_fac %>% 
  gather(key = "year", value = "advisees", -department, -faculty) %>% 
  mutate(year = as.numeric(year)) %>% 
  filter(year >= 2007)
write_rds(x = thes_fac, path = "thes_fac.RDS")

# Copied the tables in the TotalUnitsTotalFTE tab of
# Scatterplot-Creds-Theses-20161108.xlsm to their own sheets
# in a new file called FTE.xlsx
## total_FTE = HUM_FTE + DEPT_FTE
total_FTE <- read_excel("FTE.xlsx", sheet = 1) %>% 
  gather(key = "SchoolYear", value = "FTE", -Department) %>% 
  mutate(DepartmentLong = paste(Department, "Department"))
total_Units <- read_excel("FTE.xlsx", sheet = 2) %>% 
  gather(key = "SchoolYear", value = "Units", -Department) %>% 
  mutate(DepartmentLong = paste(Department, "Department"))
HUM_FTE <- read_excel("FTE.xlsx", sheet = 3) %>% 
  gather(key = "SchoolYear", value = "FTE", -Department) %>% 
  mutate(DepartmentLong = paste(Department, "Department"))
DEPT_FTE <- read_excel("FTE.xlsx", sheet = 4) %>% 
  gather(key = "SchoolYear", value = "FTE", -Department) %>% 
  mutate(DepartmentLong = paste(Department, "Department"))