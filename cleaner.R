library(tidyverse)
library(tsibble)
library(lubridate)
library(glue)

# Read in raw data: 
# download link: https://s3.amazonaws.com/tripdata/JC-202312-citibike-tripdata.csv.zip

dat1 <- read_csv("data/JC-202312-citibike-tripdata.csv")
dat2 <- read_csv("data/JC-202311-citibike-tripdata.csv")
dat3 <- read_csv("data/JC-202310-citibike-tripdata.csv")
  
# Pick out relevant columns
dat <- rbind(dat1, dat2, dat3)
df <- dat %>% select(rideable_type, started_at, member_casual, start_station_name)

# Count numbe rof rides started per station, ride, and membership type per hour over the month
rides_per_hour <- df %>%
  group_by(time=floor_date(started_at, '1 hour'), start_station_name, rideable_type, member_casual) %>%
  summarize(number_of_rides=n())

write.csv(rides_per_hour, "data/rides_per_hour.csv")


