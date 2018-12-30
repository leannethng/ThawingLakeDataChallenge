library(tidyverse)
library(lubridate)



# Read in the Data
mendota <- read.csv("History of Ice on Lake Mendota.csv", stringsAsFactors = F)

head(mendota)
str(mendota)
summary(mendota)


mendota$DAYS <- as.integer(mendota$DAYS)

str(mendota)

mendota$closed_date <- as.Date(paste(mendota$CLOSED, mendota$START.YEAR), format = '%d %b %Y')

mendota$opening_date <- as.Date(paste(mendota$OPENED, mendota$START.YEAR), format = '%d %b %Y')

barplot(height = mendota$DAYS,
        names.arg = mendota$START.YEAR,
        xlab = "Year",
        ylab = "Amount of open days",
        main = "Days the lake was open",
        col = "mistyrose",
        ylim = c(0, 160)
)



