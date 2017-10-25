library(dplyr)

domain <- function(x) unlist(sapply(strsplit(gsub("http://|https://|www\\.", "", x), "/"), function (y) ifelse(length(y) > 0, y[[1]], list(""))))

hn_stories <- read.csv("./hn_stories.csv", stringsAsFactors=FALSE)

hndata <- hn_stories %>% filter(!is.na(time) & author != "") %>% select(id, time, time_ts, title, url, text, author, score)

hndata <- hndata %>% mutate(theyear=as.numeric(substr(time_ts, 1, 4)))
hndata <- hndata %>% mutate(hour=as.numeric(substr(time_ts, 12, 13)))
hndata$thedomain = sapply(hndata$url, domain)

beginning_of_2014 <- 1388534400
beginning_of_2015 <- 1420070400

hndata <- hndata %>% filter(time > beginning_of_2014)

top_authors <- hndata %>% group_by(author) %>% summarize(count=n(), totalscore=sum(score), averagescore=sum(score)/n()) %>% arrange(desc(count))
top_domains <- hndata %>% filter(thedomain != "") %>% group_by(thedomain) %>% summarize(count=n(), totalscore=sum(score), averagescore=sum(score)/n()) %>% arrange(desc(count))
hour_scores <- hndata %>% group_by(hour) %>% summarize(count=n(), totalscore=sum(score), averagescore=sum(score)/n())

programming_languages <- c('Python',
                           'R',
                           'Perl',
                           'C++',
                           'Java',
                           'Javascript',
                           'Haskell')

language_regexes <- c('[^a-zA-Z]Python[^a-zA-Z]',
                      '[^a-zA-Z]R[^a-zA-Z]',
                      '[^a-zA-Z]Perl[^a-zA-Z]',
                      '[^a-zA-Z]C\\+\\+[^a-zA-Z]',
                      '[^a-zA-Z]Java[^a-zA-Z]',
                      '[^a-zA-Z]Java(s|S)cript[^a-zA-Z]',
                      '[^a-zA-Z]Haskell[^a-zA-Z]')

language_stats <- data.frame(language=character(0), count=integer(0), totalscore=integer(0), averagescore=numeric(0))
for (i in 1:length(programming_languages)) {
  language_stats <- rbind(language_stats, cbind(
    language=programming_languages[[i]],
    (hndata %>% filter(grepl(language_regexes[[i]], title)) %>%
       summarize(count=n(), totalscore=sum(score), averagescore=sum(score)/n()))
  ))
}

saveRDS(hndata, "./cleaned_data.Rda")
saveRDS(top_authors, "./top_authors.Rda")
saveRDS(top_domains, "./top_domains.Rda")
saveRDS(hour_scores, "./hour_scores.Rda")
saveRDS(language_stats, "./language_stats.Rda")

