library(shiny)
library(shinydashboard)
library(shinyAce)

choices = c('count', 'totalscore')

shinyUI(
  dashboardPage(skin = "blue",
                dashboardHeader(title="Hacker News Stories"),
                dashboardSidebar(sidebarMenu(menuItem("View Spider Code", tabName="scraper", icon=icon("table")),
                                             menuItem("Top Authors", tabName="authors", icon=icon("bar-chart")),
                                             menuItem("Top Domains", tabName="domains", icon=icon("bar-chart")),
                                             menuItem("Submission Time Analysis", tabName="hours", icon=icon("bar-chart")))),
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
                        box("Top users on Hacker News"),
                        selectizeInput(inputId="authorChoice",
                                       label="Sort method:",
                                       choices=choices)),
                      fluidRow(plotOutput("authorPlot"))
                  ),
                  tabItem(tabName = "domains",
                          fluidRow(
                            box("Top domains on Hacker News"),
                            selectizeInput(inputId="domainChoice",
                                           label="Sort method:",
                                           choices=choices)),
                          fluidRow(plotOutput("domainPlot"))
                  ),
                  tabItem(tabName = "hours",
                          fluidRow(
                            box("Best time to submit a story"),
                            selectizeInput(inputId="hourChoice",
                                           label="Sort method:",
                                           choices=choices)),
                          fluidRow(plotOutput("hourPlot"))
                  )
                ))
  )
)
