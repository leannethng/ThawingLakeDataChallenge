library(tidyverse)
library(lubridate)
library(ggplot2)

# Read in the Data
mendota <- read.csv("History of Ice on Lake Mendota.csv", stringsAsFactors = F)

#quick check
head(mendota)
str(mendota)
summary(mendota)

#change days to an int
mendota$DAYS <- as.integer(mendota$DAYS)

#check again
str(mendota)

#make dates actual dates with the years attached
mendota$closed_date <- as.Date(paste(mendota$CLOSED, mendota$START.YEAR), format = '%d %b %Y')

mendota$opening_date <- as.Date(paste(mendota$OPENED, mendota$END.YEAR), format = '%d %b %Y')

#counting how many days
mendota$date_diff <- as.Date(as.character(mendota$opening_date), format="%Y-%m-%d")- as.Date(as.character(mendota$closed_date), format="%Y-%m-%d")

##Cleaning up the years, some were wrong
for (i in 1:nrow(mendota)) {
    if(month(mendota$closed_date)[i] <= 4) {
        print(i)
       year(mendota$closed_date)[i] <- year(mendota$closed_date)[i] + 1
    } 
    else if ((month(mendota$opening_date)[i] > 9) & (month(mendota$closed_date)[i] >9)) {
        print("nope")
        year(mendota$opening_date)[i] <- year(mendota$opening_date)[i] - 1
    }
}

#Corrected no of days after edits to years
mendota$date_diff_corrected <- as.Date(as.character(mendota$opening_date), format="%Y-%m-%d")- as.Date(as.character(mendota$closed_date), format="%Y-%m-%d")

#Graphs
ggplot(mendota, aes(year(opening_date), date_diff_corrected)) + 
    geom_point() +
    geom_smooth(model = loess)

ggplot(mendota, aes(year(opening_date), date_diff_corrected)) + 
    geom_bin2d() +
    geom_smooth(model = loess)

#Days per year -- Separated years out into new table and have days per year here
agg = aggregate(mendota$date_diff_corrected, by = list(year(mendota$opening_date)), sum) 

#added column names
colnames(agg) <- c("year", "days")

#graph for days per year here
ggplot(agg, aes(year, days)) + 
    geom_point() +
    geom_smooth(model = loess)

ggplot(agg, aes(year, days)) + 
    geom_bin2d() +
    geom_smooth(model = loess)



## Old tables ------

ggplot(mendota, aes(START.YEAR, DAYS)) + 
    geom_point() +
    geom_smooth(model = loess)


ggplot(mendota, aes(month(closed_date))) + 
    geom_bar()


# TESTING --------
###

# survey <- data.frame(date=c("2012/07/26","2012/07/25"),tx_start=c("2012/01/01","2012/01/01"))

# survey$date_diff <- as.Date(as.character(survey$date), format="%Y/%m/%d")-
#    as.Date(as.character(survey$tx_start), format="%Y/%m/%d")
# survey

###

# if closed date is January to April then add 1 onto the year

x <- as.Date('0014-06-30')
x
year(x)
year(x) <- year(x)+1
x

# adding one year to january and march dtaes
month(mendota$closed_date) < 4 

#making variables? DONT NEED
closed <- mendota$closed_date
closed_month <- month(mendota$closed_date)
closed_year <- year(mendota$closed_date)
closed_month


#dplyr - not quite what i am after
case_when(
    year(mendota$closed_date) ~ year(mendota$closed_date) + 1,
    TRUE ~ as.character(before_march)
)

print(before_march == 1)  

#this work sbut is not helpful
before_march <- ifelse(closed_month < 4, 1,0)

