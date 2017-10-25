library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(readr)

hndata <- readRDS(file = "/home/aeb/Documents/scraping/hnews/shiny/cleaned_data.Rda")
top_authors <- readRDS(file = "/home/aeb/Documents/scraping/hnews/shiny/top_authors.Rda")
top_domains <- readRDS(file = "/home/aeb/Documents/scraping/hnews/shiny/top_domains.Rda")
hour_scores <- readRDS(file = "/home/aeb/Documents/scraping/hnews/shiny/hour_scores.Rda")

spidercode <- read_file("spider.py")
itemcode <- read_file("items.py")
