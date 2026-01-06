library(readxl)
library(dplyr)

data <- read_excel("-17.csv.xlsx")
names(data) <- trimws(names(data))

str(data)
