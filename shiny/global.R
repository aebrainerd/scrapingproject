library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

hndata <- readRDS(file = "./cleaned_data.Rda")

hndata <- hndata %>% mutate(theyear=as.numeric(substr(time_ts, 1, 4)))

top_authors = hndata %>% group_by(author, theyear) %>% summarize(count=n(), totalscore=sum(score)) %>% arrange(desc(count))

g = ggplot(head(top_authors, 20), aes(x=reorder(author,-count), y=count, color=theyear)) + 
    geom_bar(stat="identity") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("Author's Username") + ylab("Number of Stories") 

g2 = ggplot(head(top_authors, 50), aes(x=reorder(author,-totalscore), y=totalscore, color=year)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("Author's Username") + ylab("Total Score")
