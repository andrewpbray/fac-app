library(tidyverse)
library(stringr)
library(openxlsx)

# Read in data
d <- read.delim("Schedule-Data-Fall-2007-Fall-2017_20161011_114934.txt", sep = "|")
d2 <- read.xlsx("thesis-advisors.xlsx")
ftes <- read.csv("ftes.csv", header = FALSE)
names(ftes) <- c('dept', '2007-08', '2008-09', '2009-10', '2010-11', '2011-12', '2012-13', '2013-14', '2014-15', '2015-16', '2016-17')



d3 <- d2 %>%
  slice(-nrow(d2)) %>%
  gather(year, "n", 2:18)
# Add useful columns



d <- d %>%
  mutate(year = str_sub(Semester, -4))

d <- read.delim("Schedule-Data-Fall-2007-Fall-2017_20161011_114934.txt", sep = "|") %>%
  mutate(year = str_sub(Semester, -4),
         courseid = paste(Subj, Numb, sep = " ")) %>%
  filter(Numb < 200 & Subj %in% c('PSY', 'BIOL', 'CHEM', 'PHYS', 'MATH')) %>%
  arrange(courseid)


ggplot(d, aes(x = units-per-fte, y = theses-per-fte))
  