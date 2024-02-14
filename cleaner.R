library(tidyverse)
library(tsibble)
library(lubridate)
library(glue)
library(tsibble)
library(arrow)

# Data download link: https://s3.amazonaws.com/tripdata/index.html

# Reading in and aggregating raw Citibike ride data from Jersey City in ALL of 2023

file_names <- dir("data", full.names = TRUE) #where you have your files

dat <- do.call(rbind,lapply(file_names,read_csv))

# Pick out relevant columns
df <- dat %>% select(rideable_type, started_at, member_casual, start_station_name)

# Count number of rides started per station, ride, and membership type per hour over the month
rides_per_hour <- df %>%
  group_by(start_time=floor_date(started_at, '1 hour'), start_station_name, rideable_type, member_casual) %>%
  summarize(number_of_rides=n())

# Converting to `tsibble` object with hourly index
ts <- rides_per_hour %>% as_tsibble(index=start_time, key=c(start_station_name, rideable_type, member_casual))
# Write to local parquet
write_parquet(ts, "data/rides_per_hour.parquet")


# ----
# Reading in and aggregating raw Citibike ride data from Jersey City in Q4 2023

# Read in raw data
dat1 <- read_csv("data/JC-202312-citibike-tripdata.csv")
dat2 <- read_csv("data/JC-202311-citibike-tripdata.csv")
dat3 <- read_csv("data/JC-202310-citibike-tripdata.csv")
  
# Pick out relevant columns
dat <- rbind(dat1, dat2, dat3)
df <- dat %>% select(rideable_type, started_at, member_casual, start_station_name)

# Count number of rides started per station, ride, and membership type per hour over the month
rides_per_hour <- df %>%
  group_by(start_time=floor_date(started_at, '1 hour'), start_station_name, rideable_type, member_casual) %>%
  summarize(number_of_rides=n())

# Converting to `tsibble` object with hourly index
ts <- rides_per_hour %>% as_tsibble(index=start_time, key=c(start_station_name, rideable_type, member_casual))

# Write to local CSV
readr::write_csv(ts, "data/rides_per_hour.csv")



