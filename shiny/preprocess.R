library(dplyr)

domain <- function(x) unlist(sapply(strsplit(gsub("http://|https://|www\\.", "", x), "/"), function (y) ifelse(length(y) > 0, y[[1]], list(""))))

hn_stories <- read.csv("/home/aeb/Documents/scraping/hnews/shiny/hn_stories.csv", stringsAsFactors=FALSE)

hndata <- hn_stories %>% filter(!is.na(time) & author != "") %>% select(id, time, time_ts, title, url, text, author, score)

hndata <- hndata %>% mutate(theyear=as.numeric(substr(time_ts, 1, 4)))
hndata <- hndata %>% mutate(hour=as.numeric(substr(time_ts, 12, 13)))
hndata$thedomain = sapply(hndata$url, domain)

beginning_of_2014 <- 1388534400
beginning_of_2015 <- 1420070400

hndata <- hndata %>% filter(time > beginning_of_2014)

top_authors <- hndata %>% group_by(author) %>% summarize(count=n(), totalscore=sum(score)) %>% arrange(desc(count))
top_domains <- hndata %>% filter(thedomain != "") %>% group_by(thedomain) %>% summarize(count=n(), totalscore=sum(score)) %>% arrange(desc(count))
hour_scores <- hndata %>% group_by(hour) %>% summarize(count=n(), totalscore=sum(score))

saveRDS(hndata, "/home/aeb/Documents/scraping/hnews/shiny/cleaned_data.Rda")
saveRDS(top_authors, "/home/aeb/Documents/scraping/hnews/shiny/top_authors.Rda")
saveRDS(top_domains, "/home/aeb/Documents/scraping/hnews/shiny/top_domains.Rda")
saveRDS(hour_scores, "/home/aeb/Documents/scraping/hnews/shiny/hour_scores.Rda")


