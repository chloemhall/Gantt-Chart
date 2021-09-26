library(tidyverse)
library(scales)
## simple code to produce a nice Gantt chart

#input data needs to be a .csv file, with 5 columns. 
#Headers: "Item" , "Activity", "Project.Element", "Start", "End" 
#Item is just a sequential numerical list i.e. Activity 1 is 1, Activity 2 is 2 etc. 
# Start & End dates should be in format YYYY.MM.DD

#load data
ganttchart <- read.csv("Ganttchart_example.csv", header= TRUE)

#gets a list of the Activities
acts<- c(ganttchart$Activity)

#mutates start and end dates
g.gantt <- gather(ganttchart, "state", "date", 4:5) %>% 
  mutate(date = as.Date(date, "%Y.%m.%d"), 
  Activity=factor(Activity, acts[length(acts):1]), 
  Project.Element=factor(Project.Element))

#produce Gantt chart
g <- ggplot(g.gantt, aes(date, Activity, color = Project.Element, group=Item)) +
geom_line(size = 10) +
  theme_bw()+
labs(x="Month", y=NULL, title="Chart title") +
  theme(plot.title = element_text(size=15, hjust=0.5))+#change font size of title and centres the title
 # theme(legend.position="none")+       #uncomment this line to remove legend 
scale_x_date(breaks = seq.Date(as.Date("2020-07-01"), #start date of the Gantt chart
                               as.Date("2021-03-31"), #end date of the Gantt chart
                               "month"), 
             labels = date_format("%b"))

g




