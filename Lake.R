library(tidyverse)
library(lubridate)
library(ggplot2)




# Read in the Data
mendota <- read.csv("History of Ice on Lake Mendota.csv", stringsAsFactors = F)

head(mendota)
str(mendota)
summary(mendota)


mendota$DAYS <- as.integer(mendota$DAYS)

str(mendota)

mendota$closed_date <- as.Date(paste(mendota$CLOSED, mendota$START.YEAR), format = '%d %b %Y')

mendota$opening_date <- as.Date(paste(mendota$OPENED, mendota$END.YEAR), format = '%d %b %Y')

mendota$date_diff <- as.Date(as.character(mendota$opening_date), format="%Y-%m-%d")- as.Date(as.character(mendota$closed_date), format="%Y-%m-%d")





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

#this work sbut is not helpful
before_march <- ifelse(closed_month < 4, 1,0)

#this uses the line above but still returns the same error of not wanting to work with the logical vector

##WORKING
for (i in 1:nrow(mendota)) {
    if(month(mendota$closed_date)[i] <= 4) {
        print(i)
       year(mendota$closed_date)[i] <- year(mendota$closed_date)[i] + 1
    } else {
        print("nope")
        #year(mendota$closed_date) <- year(mendota$closed_date) 
    }
}

#dplyr - not quite what i am after
case_when(
    year(mendota$closed_date) ~ year(mendota$closed_date) + 1,
    TRUE ~ as.character(before_march)
)

print(before_march == 1)  




mendota$date_diff_corrected <- as.Date(as.character(mendota$opening_date), format="%Y-%m-%d")- as.Date(as.character(mendota$closed_date), format="%Y-%m-%d")




str(mendota)

barplot(height = mendota$DAYS,
        names.arg = mendota$START.YEAR,
        xlab = "Year",
        ylab = "Amount of open days",
        main = "Days the lake was open",
        col = "mistyrose",
        ylim = c(0, 160)
)

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


