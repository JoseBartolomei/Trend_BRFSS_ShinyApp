
# Load data created in the above steps ----------------------------------------------
# To minimize work load the data to be used was saved as an .rData
load(file = "./trend_data.RData")

# Plot ------------------------------------------------------------------------------

library(ggplot2)
shinyServer(function(input, output){
	output$plot <- renderPlot({
		
		if(input$outcome == "All"){
			trend.data <- trend.data
		}
		if(input$outcome != "All"){
			trend.data <- trend.data[trend.data$Disease == c(input$outcome),]
		}
		
		# Plot
		p <- 
			ggplot(trend.data, aes(x = Year, y = Prevalence * 100 , colour = Disease,
														 group = interaction(weight, Disease),
														 label = round(Prevalence * 100, 2))) +
			geom_line(stat = "identity", size = 1.5) +
			labs(x = "Survey Year", y = "Prevalence * 100") +
			geom_text(size = 5, hjust = 0, vjust = -1, colour = "black") +
			labs(title = "Outcomes Prevalence Trend Among Adults in Puerto Rico, BRFSS 2008 - 2013") +
			theme(plot.title = element_text(size = 25, face="bold")) +
			theme(axis.text.x = element_text(colour = 'black', angle = 0, 
																			 size = 25, hjust = 0.5, vjust = 0)) +
			theme(axis.text.y = element_text(colour = 'black', angle = 0, 
																			 size = 25, hjust = 0.5, vjust = 0)) +
			scale_y_continuous(limits = c(0, 20)) +
			geom_vline(xintercept = 4, colour="red", linetype = "longdash") +
			theme(legend.text=element_text(size = 10)) +
			geom_text(aes(x= 3.95, label = "Change in weighting Scheme", y = 6), 
								colour="red", angle = 90, size = 5) +
			geom_point(size = 4) +
			theme(axis.title=element_text(size=25,face="bold"))
		
		
		## ConfInf == TRUE
		errB <- geom_errorbar(aes(ymax = ul * 100, ymin = ll * 100), width = 0.2)
		newlab <- labs(x = "Survey Year", y = "Number of Cases") 
		
		if(input$values == "None" & input$ConfInt == TRUE){
			p + aes(label = "") + errB
		} else if(input$values == "Prevalence" & input$ConfInt == TRUE){
			p + aes(label = round(Prevalence * 100, 2)) + errB
		} else if(input$values == "Cases" & input$ConfInt == TRUE){
			p + aes(label = format(Cases, big.mark = ",")) + errB + newlab
			##### ConfInf == FALSE
		} else if(input$values == "None" & input$ConfInt == FALSE){
			p + aes(label = "") 
		} else if(input$values == "Prevalence" & input$ConfInt == FALSE){
			p + aes(label = round(Prevalence * 100, 2))
		} else if(input$values == "Cases" & input$ConfInt == FALSE){
			p + aes(label = format(Cases, big.mark = ",")) + newlab
		}
		
		
	})
	
})
