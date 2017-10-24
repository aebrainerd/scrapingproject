library(shiny)
library(shinydashboard)
library(shinyAce)

shinyUI(
  dashboardPage(skin = "blue",
                dashboardHeader(title="Hacker News Stories"),
                dashboardSidebar(sidebarMenu(menuItem("View Spider Code", tabName="scraper", icon=icon("table")),
                                             menuItem("Top Authors", tabName="authors", icon=icon("bar-chart")),
                                             menuItem("Top Domains", tabName="domains", icon=icon("bar-chart")),
                                             menuItem("Submission Time Analysis", tabName="time", icon=icon("bar-chart")))),
                dashboardBody(tabItems(
                  tabItem(tabName = "scraper",
                    fluidRow(
                      box("The data is scraped from ", a("Hacker News", href="http://news.ycombinator.com/"), " using the following Python app making use of the scrapy library:",
                      br(),
                      br(),
                      aceEditor("ace", value=spidercode, mode="python"),
                      br(),
                      "The spider relies on the following items.py file:",
                      br(),
                      br(),
                      aceEditor("ace2", value=itemcode, mode="python")))),
                  tabItem(tabName = "authors",
                      fluidRow(
                        box("Hi")
                      ))
                  ))
  )
)
