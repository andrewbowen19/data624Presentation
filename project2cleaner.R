# Quick script to write train and test data fro Project 2 to CSV format

library(readxl)


# Sub your path if running locally
train <- read_excel("/Users/andrewbowen/CUNY/data624Presentation/data/StudentData.xlsx")
test <- read_excel("/Users/andrewbowen/CUNY/data624Presentation/data/StudentEvaluation.xlsx")

write.csv(train, "/Users/andrewbowen/CUNY/data624Presentation/data/train.csv")
write.csv(test, "/Users/andrewbowen/CUNY/data624Presentation/data/test.csv")
