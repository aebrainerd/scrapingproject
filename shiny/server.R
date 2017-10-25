library(shiny)
library(shinydashboard)
library(scales)

function(input, output) {

  myAuthorData <- reactive({
    if (input$authorChoice == 'Story Count') {
      top_authors %>% select(author, val=count)
    } else {
      top_authors %>% select(author, val=totalscore)
    }
  })
  
  myDomainData <- reactive({
    if (input$domainChoice == 'Story Count') {
      top_domains %>% select(thedomain, val=count)
    } else {
      top_domains %>% select(thedomain, val=totalscore)
    }
  })
  
  myHourData <- reactive({
    if (input$hourChoice == 'Story Count') {
      hour_scores %>% select(hour, val=count)
    } else {
      hour_scores %>% select(hour, val=totalscore)
    }
  })

	output$authorPlot <- renderPlot({
			ggplot(head(myAuthorData(), 25), aes(x=reorder(author,val), y=val)) + 
    		geom_bar(stat="identity", fill="blue") + 
    		theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
   			xlab("Author's Username") + ylab(ifelse(input$authorChoice=="Story Count", "Story Count", "Total Score")) +
	      scale_y_continuous(labels = comma)
		})

	output$domainPlot <- renderPlot({
	  ggplot(head(myDomainData(), 25), aes(x=reorder(thedomain,val), y=val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Domain Name") + ylab(ifelse(input$domainChoice=="Story Count", "Story Count", "Total Score")) +
	    scale_y_continuous(labels = comma)
	})

	output$hourPlot <- renderPlot({
	  ggplot(head(myHourData(), 25), aes(hour,val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Hour of Submission") + ylab(ifelse(input$domainChoice=="Story Count", "Story Count", "Total Score")) +
	    scale_y_continuous(labels = comma)
	})	
	
}