#Comparing column names
colnames(april_2023)
colnames(may_2023)
colnames(june_2023)

#The data format for "started_at" and "ended_at" columns in the april_2023 file were in string character format. 
#Hence the formats were converted to datetime format.

april_2023 <- mutate(april_2023, started_at = ymd_hms(started_at))
april_2023 <- mutate(april_2023, ended_at = ymd_hms(ended_at))

#combining the three files into one file 
all_trips <- bind_rows(april_2023, may_2023, june_2023)

#Removing the columns which are not required for our analysis 
all_trips <- all_trips %>% 
  select(-c(start_lat, start_lng, end_lat, end_lng))
