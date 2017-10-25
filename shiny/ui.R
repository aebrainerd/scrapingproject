library(shiny)
library(shinydashboard)
library(shinyAce)

#Column names and user-friendly labels
choices = c('count', 'totalscore', 'averagescore')
displaychoices = c('Story Count', 'Total Score', 'Average Score')

shinyUI(
  dashboardPage(skin = "blue",
                dashboardHeader(title="Hacker News Stories"),
                dashboardSidebar(sidebarUserPanel("", image = "http://is1.mzstatic.com/image/thumb/Purple2/v4/14/b6/67/14b66795-98da-8618-5a6c-e84846162b25/source/1200x630bb.jpg"),
                                 sidebarMenu(menuItem("View Spider Code", tabName="scraper", icon=icon("file-code-o")),
                                             menuItem("Top Authors", tabName="authors", icon=icon("bar-chart")),
                                             menuItem("Top Domains", tabName="domains", icon=icon("bar-chart")),
                                             menuItem("Submission Time Analysis", tabName="hours", icon=icon("bar-chart")),
                                             menuItem("Programming Languages", tabName="languages", icon=icon("bar-chart")))),
                dashboardBody(tabItems(
                  tabItem(tabName = "scraper",
                    fluidRow(
                      p("The data is scraped from ", 
                          a("Hacker News", href="http://news.ycombinator.com/"), 
                          " using the following Python app making use of the scrapy library:"),
                      p(aceEditor("ace", value=spidercode, mode="python")),
                      p("The spider relies on the following items.py file:"),
                      aceEditor("ace2", value=itemcode, mode="python"))),
                  tabItem(tabName = "authors",
                      fluidRow(
                        p("Top users on Hacker News"),
                        selectizeInput(inputId="authorChoice",
                                       label="Sort method:",
                                       choices=displaychoices)),
                      fluidRow(plotOutput("authorPlot"))
                  ),
                  tabItem(tabName = "domains",
                          fluidRow(
                            p("Top domains on Hacker News"),
                            selectizeInput(inputId="domainChoice",
                                           label="Sort method:",
                                           choices=displaychoices)),
                          fluidRow(plotOutput("domainPlot"))
                  ),
                  tabItem(tabName = "hours",
                          fluidRow(
                            p("Best hour to submit a story in UTC time zone."), 
                            p("New York City is 4 hours behind this and San Francisco is 7 hours behind."),
                            selectizeInput(inputId="hourChoice",
                                           label="Sort method:",
                                           choices=displaychoices)),
                          fluidRow(plotOutput("hourPlot"))
                  ),
                  tabItem(tabName = "languages",
                          fluidRow(
                            p("Programming languages mentioned in Hacker News story titles."),
                            selectizeInput(inputId="languageChoice",
                                           label="Sort method:",
                                           choices=displaychoices)),
                          fluidRow(plotOutput("languagePlot"))
                  )
                ))
  )
)
