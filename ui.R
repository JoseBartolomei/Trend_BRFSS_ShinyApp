#User interface BRFSS trend Shiny

shinyUI(fluidPage(
	titlePanel("Puerto Rico Outcomes Trend"),
	sidebarLayout(
		
		sidebarPanel(
			checkboxInput("ConfInt", label = "95% Confidence Intervals", value = FALSE),
			
			selectInput("outcome", "Chose an Outcome",
									choices= c("All", "Asthma", "Diabetes", "Coronary Heart Disease",
														 "Infarction", "Stroke", "Tobacco Use")),
			
			selectInput("values", "Chose values to display",
									choices= c("None", "Prevalence", "Cases")),
			
			
			br(),
			h4(span("Developed by", style = "color:grey")),
			img(src = "Outcome_Project_Logo.png", height = 72, width = 200),
			br(),
			br(),
			h6(span("Powered by RStudio™ Shiny", style = "color:grey")),
			
			width = 3),
		
		
		mainPanel(plotOutput("plot"),
							width = 8)
	)
))


