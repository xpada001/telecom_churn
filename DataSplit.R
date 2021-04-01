# Import Data
input <- read.csv("Original_data.csv", header=TRUE)

# Rename the columns
names(input) <- c("id","caller_sum_6","record_sum_6","time_sum_6","caller_sum_4","record_sum_4","time_sum_4",
                  "caller_sum_5","record_sum_5","time_sum_5","brand","open_date","city_flag","flag","day",
                  "caller_sum_45","caller_sum_456","record_sum_45","record_sum_456","time_sum_45",
                  "time_sum_456")

# Split based on flag=NA or not
train <- input[!is.na(input$flag),]

train_y <- train[c("flag")]

train$flag <- NULL

# Move flag to the last column
train <- cbind(train, train_y)

# Output to csv files
write.csv(train,"train.csv", row.names = FALSE)


#remove outliers, threshold for month 4 and 6 = 43200 and month 5 = 44640

month_limit1 = 43200
month_limit2 = 44640

#this is for removing na values and then put it back as NA will mess up the outlier removal
train_no_na = train[rowSums(is.na(train))<=0,]
na_set = train[rowSums(is.na(train))>0,]

train_no_outlier = train_no_na[(train_no_na$time_sum_6 <= month_limit1 & 
                                  train_no_na$time_sum_4 <= month_limit1 &
                                  train_no_na$time_sum_5 <= month_limit2),]

train_no_outlier = rbind(train_no_outlier,na_set)

#to shuffle the rows as previously all the rows containing NA is at the end.
train_no_outlier = train_no_outlier[sample(nrow(train_no_outlier)),]

write.csv(train_no_outlier,"train_no_outlier.csv", row.names = FALSE)

#remove missing value
train_no_missing_outlier = na.omit(train_no_outlier)

write.csv(train_no_missing_outlier,"train_no_missing_outlier.csv", row.names = FALSE)

#now generate data with missing value replaced by 0

train_no_outlier[is.na(train_no_outlier)] = 0

write.csv(train_no_outlier,"train_missing0_no_outlier.csv", row.names = FALSE)
