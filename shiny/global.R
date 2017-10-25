library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(readr)

#Read Rda files
hndata <- readRDS(file = "./cleaned_data.Rda")
top_authors <- readRDS(file = "./top_authors.Rda")
top_domains <- readRDS(file = "./top_domains.Rda")
hour_scores <- readRDS(file = "./hour_scores.Rda")
language_stats <- readRDS(file = "./language_stats.Rda")

#Python source for code viewing panel
spidercode <- read_file("spider.py")
itemcode <- read_file("items.py")

#Increase font size in plots
theme_set(theme_gray(base_size=18))