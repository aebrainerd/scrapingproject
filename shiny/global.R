library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(readr)

domain <- function(x) unlist(sapply(strsplit(gsub("http://|https://|www\\.", "", x), "/"), function (y) ifelse(length(y) > 0, y[[1]], list(""))))

hndata <- readRDS(file = "/home/aeb/Documents/scraping/hnews/shiny/cleaned_data.Rda")
hndata <- hndata %>% mutate(theyear=as.numeric(substr(time_ts, 1, 4)))
hndata <- hndata %>% mutate(hour=as.numeric(substr(time_ts, 12, 13)))
hndata$thedomain = sapply(hndata$url, domain)

spidercode <- read_file("spider.py")
itemcode <- read_file("items.py")

top_authors = hndata %>% group_by(author) %>% summarize(count=n(), totalscore=sum(score)) %>% arrange(desc(count))

g = ggplot(head(top_authors, 25), aes(x=reorder(author,-count), y=count)) + 
    geom_bar(stat="identity", fill="blue") + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    xlab("Author's Username") + ylab("Number of Stories") 

g2 = ggplot(head(top_authors, 25), aes(x=reorder(author,-totalscore), y=totalscore)) + 
     geom_bar(stat="identity", fill="blue") + 
     theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
     xlab("Author's Username") + ylab("Total Score")

top_domains = hndata %>% filter(thedomain != "") %>% group_by(thedomain) %>% summarize(count=n(), totalscore=sum(score)) %>% arrange(desc(count))

g3 = ggplot(head(top_domains, 25), aes(x=reorder(thedomain, -count), y=count)) +
     geom_bar(stat="identity", fill="blue") +
     theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
     xlab("Domain") + ylab("Number of Stories")

g4 = ggplot(head(top_domains, 25), aes(x=reorder(thedomain, -totalscore), y=totalscore)) +
     geom_bar(stat="identity", fill="blue") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
     xlab("Domain") + ylab("Total Score")

hour_scores = hndata %>% group_by(hour) %>% summarize(count=n(), totalscore=sum(score))

