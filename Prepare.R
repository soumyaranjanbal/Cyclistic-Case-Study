#Inspecting the new table by using different functions 
colnames(all_trips)
nrow(all_trips)
dim(all_trips)
head(all_trips)
tail(all_trips)
str(all_trips)
summary(all_trips)

#New columns were created from the "started_at" column holding the Date, Month, Year and Day of Week in four separate columns. 
all_trips$date <- as.Date(all_trips$started_at)
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$year <- format(as.Date(all_trips$date), "%y")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")


#On inspecting the dataset closely, it was found some obervations had year value other than 2023. Since All observations in this 
#dataset are from the second quarter of 2023, any observations with a different year were considered data errors and was corrected. 

all_trips$started_at <- ymd_hms(paste("2023", month(all_trips$started_at), 
                                      day(all_trips$started_at), 
                                      format(all_trips$started_at, "%H:%M:%S")))
all_trips$ended_at <- ymd_hms(paste("2023", month(all_trips$ended_at), 
                                    day(all_trips$ended_at), 
                                    format(all_trips$ended_at, "%H:%M:%S")))
                                   
#Calculating the "ride_length" in seconds between "started_at" and "ended_at" time
all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)
str(all_trips)

#Converting the "ride_legth" data format from character string to numeric 
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))

#Inspecting the new table using different functions 
mean(all_trips$ride_length)
median(all_trips$ride_length)
max(all_trips$ride_length)
min(all_trips$ride_length)
summary(all_trips$ride_length)

selected_data <- subset(all_trips, ride_length < 0)
View(selected_data)


#Some "ride_length" values were found to be negative because of instances where the "ended_at" time is earlier than 
#the "started_at" time. These negative values can impact the accuracy of our data analysis, therefore all the corresponding rows 
#were removed to ensure data integrity.

all_trips <- subset(all_trips, ride_length > 0)
all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at)

#Inspecting the new table 
mean(all_trips$ride_length)
median(all_trips$ride_length)
max(all_trips$ride_length)
min(all_trips$ride_length)
summary(all_trips$ride_length)
View(all_trips)

#The new table was exported as a .csv for visualization on Tableau 
write.csv(all_trips, file = "bike_trips_data.csv")
