library(shiny)
library(shinydashboard)

function(input, output) {

  myAuthorData <- reactive({
    top_authors %>% select(author, val=input$authorChoice)
  })
  
  myDomainData <- reactive({
    top_domains %>% select(thedomain, val=input$domainChoice)    
  })
  
  myHourData <- reactive({
    hour_scores %>% select(hour, val=input$hourChoice)
  })

	output$authorPlot <- renderPlot({
			ggplot(head(myAuthorData(), 25), aes(x=reorder(author,val), y=val)) + 
    		geom_bar(stat="identity", fill="blue") + 
    		theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
   			xlab("Author's Username") + ylab(ifelse(input$authorChoice=="count", "Number of Stories", "Total Score")) 
		})

	output$domainPlot <- renderPlot({
	  ggplot(head(myDomainData(), 25), aes(x=reorder(thedomain,val), y=val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Domain Name") + ylab(ifelse(input$domainChoice=="count", "Number of Stories", "Total Score")) 
	})

	output$hourPlot <- renderPlot({
	  ggplot(head(myHourData(), 25), aes(hour,val)) + 
	    geom_bar(stat="identity", fill="blue") + 
	    theme(axis.text.x = element_text(hjust = 1)) + coord_flip() + 
	    xlab("Hour of Submission") + ylab(ifelse(input$domainChoice=="count", "Number of Stories", "Total Score")) 
	})	
	
}