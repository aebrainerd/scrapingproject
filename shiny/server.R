library(shiny)
library(shinydashboard)
library(scales)

function(input, output) {

  myAuthorData <- reactive({
    if (input$authorChoice == 'Story Count') {
      top_authors %>% select(author, val=count)
    } else {
      if (input$authorChoice == 'Total Score') {
        top_authors %>% select(author, val=totalscore)
      } else {
        top_authors %>% select(author, val=averagescore)
      }
    }
  })
  
  myDomainData <- reactive({
    if (input$domainChoice == 'Story Count') {
      top_domains %>% select(thedomain, val=count)
    } else {
      if (input$domainChoice == 'Total Score') {
        top_domains %>% select(thedomain, val=totalscore)
      } else {
        top_domains %>% select(thedomain, val=averagescore)
      }
    }
  })
  
  myHourData <- reactive({
    if (input$hourChoice == 'Story Count') {
      hour_scores %>% select(hour, val=count)
    } else {
      if (input$hourChoice == 'Total Score') {
        hour_scores %>% select(hour, val=totalscore)
      } else {
        hour_scores %>% select(hour, val=averagescore)
      }
    }
  })

  myLanguageData <- reactive({
    if (input$languageChoice == 'Story Count') {
      language_stats %>% select(language, val=count)
    } else {
      if (input$languageChoice == 'Total Score') {
        language_stats %>% select(language, val=totalscore)
      } else {
        language_stats %>% select(language, val=averagescore)
      }
    }
  })
  
	output$authorPlot <- renderPlot({
			ggplot(head(myAuthorData(), 25), aes(x=reorder(author,val), y=val)) + 
    		geom_bar(stat="identity", fill="blue") + 
    		theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
   			xlab("Author's Username") + ylab(ifelse(input$authorChoice=="Story Count",
   			                                        "Story Count",
   			                                        ifelse(input$authorChoice=="Total Score",
   			                                               "Total Score",
   			                                               "Average Score"))) +  
	      scale_y_continuous(labels = comma)
		})

	output$domainPlot <- renderPlot({
	  ggplot(head(myDomainData(), 25), aes(x=reorder(thedomain,val), y=val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Domain Name") + ylab(ifelse(input$domainChoice=="Story Count",
	                                      "Story Count",
	                                      ifelse(input$domainChoice=="Total Score",
	                                             "Total Score", "Average Score"))) +
	    scale_y_continuous(labels = comma)
	})

	output$hourPlot <- renderPlot({
	  ggplot(head(myHourData(), 25), aes(hour,val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Hour of Submission") + ylab(ifelse(input$hourChoice=="Story Count",
	                                             "Story Count",
	                                             ifelse(input$hourChoice=="Total Score", "Total Score", "Average Score"))) +
	    scale_y_continuous(labels = comma)
	})	
	
	output$languagePlot <- renderPlot({
	  ggplot(head(myLanguageData(), 25), aes(x=reorder(language,val),y=val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Programming Language") + ylab(ifelse(input$languageChoice=="Story Count",
	                                             "Story Count",
	                                             ifelse(input$hourChoice=="Total Score", "Total Score", "Average Score"))) +
	    scale_y_continuous(labels = comma)
	})	
	
}