#Comparing members and casual riders 
aggregate(all_trips$ride_length ~all_trips$member_casual, FUN = mean)
aggregate(all_trips$ride_length ~all_trips$member_casual, FUN = median)
aggregate(all_trips$ride_length ~all_trips$member_casual, FUN = max)
aggregate(all_trips$ride_length ~all_trips$member_casual, FUN = min)

#Evaluating the average ride time by each day for members vs casual riders 
aggregate(all_trips$ride_length~all_trips$member_casual +all_trips$day_of_week, FUN = mean)

#Ordering the days of the week 
all_trips$day_of_week <- ordered(all_trips$day_of_week, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

#Evaluating the average ride time by each day for members vs casual riders 
aggregate(all_trips$ride_length~all_trips$member_casual +all_trips$day_of_week, FUN = mean)

#Visualizing ridership data by type and weekday 
all_trips %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)	%>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

#Visualizing ridership data by type and average duration of ride 
all_trips %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

#Exporting the average ride length table 
counts <- aggregate(all_trips$ride_length ~ all_trips$member_casual + all_trips$day_of_week, FUN = mean)
View(counts)
write.csv(counts, file = "avg_ride_length.csv")
