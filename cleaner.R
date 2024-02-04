library(tidyverse)
library(tsibble)

dat <- read_csv("/Users/andrewbowen/Downloads/JC-202312-citibike-tripdata.csv")


df <- dat %>% select(rideable_type, started_at, member_casual, start_station_name)

rides_per_hour <- library(tidyverse)
library(tsibble)
library(lubridate)

# Read in raw data
dat <- read_csv("/Users/andrewbowen/Downloads/JC-202312-citibike-tripdata.csv")


df <- dat %>% select(rideable_type, started_at, member_casual, start_station_name)

# Count numbe rof rides started per station, ride, and membership type per hour over the month
rides_per_hour <- df %>%
  group_by(time=floor_date(started_at, '1 hour'), start_station_name, rideable_type, member_casual) %>%
  summarize(number_of_rides=n())


write.csv(rides_per_hour, "data/rides_per_hour.csv")


