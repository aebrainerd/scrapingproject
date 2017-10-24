library(dplyr)

hn_stories <- read.csv("/home/aeb/Documents/scraping/shiny/hn_stories.csv", stringsAsFactors=FALSE)

hndata <- hn_stories %>% filter(!is.na(time) & author != "") %>% select(id, time, time_ts, title, url, text, author, score)

beginning_of_2014 <- 1388534400
beginning_of_2015 <- 1420070400

hndata <- hndata %>% filter(time > beginning_of_2014)

saveRDS(hndata, "./cleaned_data.Rda")


