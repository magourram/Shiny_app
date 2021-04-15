load_pckg <- function(){
  
  if(!require('pacman')) install.packages('pacman')
  pacman::p_load(shiny, shinythemes, shinyWidgets, spotifyr, ggplot2,
                 ggridges, plyr)
}

load_pckg()

source('main2.R')

#User interface commands
ui <- navbarPage(
  paste("Wu Tang Clan Analysis"),
        theme = shinytheme("yeti"),
  
  sidebarLayout(
    position = "left",
    
    sidebarPanel(
      
      helpText(h2("Marwan Agourram, 967349"), align = "center"),
      helpText("Data Science and Economics,", align = "center"),
      helpText("Università degli Studi di Milano, 2021", align = "center"),
      
      br(),
      br(),
      
      h3("Search for a Wu Tang Original Founder"),
      
      br(),
      
      #Select Input artist name
      selectInput(inputId = "artist",
                  label = "Choice:",
                  choices = unique(data$artist_name)),
      
      #Submit preferences
      submitButton(text = "Search!",
                   icon = NULL,
                   width = NULL),
      
      br(),
      br(),
      
      img(src = "rstudio_logo.png", heigth = 50, width = 200),
      
      br(),
      
      img(src = "spotify_logo.png", heigth = 50, width = 200),
      
      br(),
      
      img(src = "unimi_logo.png", heigth = 50, width = 200)),
    
    
    mainPanel(
      
      h3(strong(em("Project description", align = "center"))),
      
      br(),
      br(),
      
      p(h4("Get some insight about one of the most important music collectives in the last 30 years. After choosing one of the original memeber groups, look at some indicators provided by Spotify.")),
      
      br(),
      
      p(h6("Look for a name in the left panel, then Search!. Move between tabs to look at different informations.")),
      h6("Play with the different indicators in order to modify the graphic representation."),
      
      br(),
      
      #Plot outputs
      textOutput(outputId = "artisttext"),
      
      br(),
      
      tabsetPanel(
        
        tabPanel("Valence",
                 
                 br(),
                 br(),
                 
                 helpText("VALENCE: measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track."),
                 helpText("Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric) , while tracks with low valence sound more negative (e.g. sad, depressed, angry."),
                 
                 br(),
                 br(),
                 
                 fluidRow(
                   align = "center",
                   sliderInput('vrange',
                               label = "Valence Range",
                               min = 0,
                               max = 1,
                               value = c(0,1),
                               step = 0.001),
                   
                   br(),
                   br(),
                   
                   plotOutput(outputId = "valenceplot", height = "1000px"))),
        
        tabPanel("Danceability",
                 
                 br(),
                 br(),
                 
                 helpText("DANCEABILITY: describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overll regularity."),
                 helpText("Values range from 0.0 being least danceable and 1.0 being most danceable."),
                 
                 br(),
                 br(),
                 
                 fluidRow(
                   align = "center",
                   sliderInput('drange',
                               label = "Danceability Range",
                               min = 0,
                               max = 1,
                               value = c(0,1),
                               step = 0.001),
                   
                   br(),
                   br(),
                   
                   plotOutput(outputId = "danceplot", height = "1000px"))),
        
        tabPanel("Energy",
                 
                 br(),
                 br(),
                 
                 helpText("ENERGY: measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity i.e. the enery of the song."),
                 helpText("Typically, energetic tracks feels fast, loud, and noisy."),
                 helpText("Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."),
                 
                 br(),
                 br(),
                 
                 fluidRow(
                   align = "center",
                   sliderInput('erange',
                               label = "Energy Range",
                               min = 0,
                               max = 1,
                               value = c(0,1),
                               step = 0.001),
                   
                   br(),
                   br(),
                   
                   plotOutput(outputId = "energyplot", height = "1000px"))),
        
        tabPanel("Tempo",
                 
                 br(),
                 br(),
                 
                 helpText("TEMPO: overall estimated tempo of a track in beats per minute (BPM)."),
                 helpText("In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration"),
                 
                 br(),
                 br(),
                 
                 fluidRow(
                   align = "center",
                   sliderInput('trange',
                               label = "BPM Range",
                               min = min(data$tempo),
                               max = max(data$tempo),
                               value = c(min(data$tempo),
                                         max(data$tempo))),
                   
                   br(),
                   br(),
                   
                   plotOutput(outputId = "tempoplot", height= "1000px"))),
        
        tabPanel("Analysis",
                 
                 br(),
                 br(),
                 
                 helpText("ANALYSIS: the following plot is based on a combination between track's BPM and the indicator Energy."),
                 helpText("The bottom legend provides more information about the representation, such as the color attributed to each artist."),
                 
                 br(),
                 br(),
                 
                 splitLayout(align = "center",
                             
                             sliderInput('trange2',
                                         label = "BPM Range",
                                         min = min(data$tempo),
                                         max = max(data$tempo),
                                         value = c(min(data$tempo),
                                                   max(data$tempo))),
                             
                             sliderInput('erange2',
                                         label = "Energy Range",
                                         min = 0,
                                         max = 1,
                                         value = c(0,1),
                                         step = 0.001)),
                 
                 br(),
                 br(),
                 
                 plotOutput(outputId = "analysisplot", height = "1000px")),
        
        tabPanel("About",
                 
                 includeMarkdown("README.md"))
    )
  )
)
)

#Server commands
server <- function(input, output) {
  
  album_var <- reactive({
    album <- subset(data, (artist_name == input$artist && 
                             tempo == input$tempo && 
                             energy == input$energy))
    ggplot(data, mapping = aes(x = tempo,
                                    y = energy,
                                    color = artist_name,
                                    size = (valence))) +
      geom_point() +
      labs(title="Scatterplot", x="Tempo", y="Energy") +
      xlim(c(input$trange2[1], input$trange2[2])) + 
      ylim(c(input$erange2[1], input$erange2[2])) +
      theme(legend.position = "bottom",
            plot.title = element_text(size = 25,
                                      face = "bold",
                                      color = "red",
                                      hjust = 0.5),
            axis.text.x = element_text(size = 10,
                                       color = "black"),
            axis.text.y = element_text(size = 10,
                                       color = "black"),
            axis.title.x = element_text (size = 15),
            axis.title.y = element_text (size = 15))
    
    
    
  })

  output$artisttext <- renderText({
    paste("You choose ", input$artist)
  })
  
  output$valenceplot <- renderPlot({
    
    data %>%
      filter(artist_name == input$artist) %>%
      
      ggplot(data = , aes(x = valence,
                          y = album_name,
                          fill = ..x..)) +
      geom_density_ridges_gradient() +
      theme_minimal() +
      xlim(c(input$vrange[1], input$vrange[2])) +
      labs(title="Valence Plot", x="Valence", y="Album Name") +
      theme(legend.position = "bottom",
            plot.title = element_text(size = 25,
                                      face = "bold",
                                      color = "red",
                                      hjust = 0.5),
            axis.text.x = element_text(size = 10,
                                       color = "black"),
            axis.text.y = element_text(size = 10,
                                       color = "black"),
            axis.title.x = element_text (size = 15),
            axis.title.y = element_text (size = 15))
  })
  
  output$danceplot <- renderPlot({
    
    data %>%
      filter(artist_name == input$artist) %>%
      
      ggplot(data = , aes(x = danceability,
                          y = album_name,
                          fill = ..x..)) +
      geom_density_ridges_gradient() + 
      theme_minimal() + 
      xlim(c(input$drange[1], input$drange[2])) + 
      labs(title="Danceability Plot", x="Danceability", y="Album Name") +
      theme(legend.position = "bottom",
            plot.title = element_text(size = 25,
                                      face = "bold",
                                      color = "red",
                                      hjust = 0.5),
            axis.text.x = element_text(size = 10,
                                       color = "black"),
            axis.text.y = element_text(size = 10,
                                       color = "black"),
            axis.title.x = element_text (size = 15),
            axis.title.y = element_text (size = 15))
  })
  
  output$energyplot <- renderPlot({
    
    data %>%
      filter(artist_name == input$artist) %>%
      ggplot(data = , aes(x = energy,
                          y = album_name,
                          fill = ..x..)) +
      geom_density_ridges_gradient() + 
      theme_minimal() + 
      xlim(c(input$erange[1], input$erange[2])) + 
      labs(title="Energy Plot", x="Energy", y="Album Name") +
      theme(legend.position = "bottom",
            plot.title = element_text(size = 25,
                                      face = "bold",
                                      color = "red",
                                      hjust = 0.5),
            axis.text.x = element_text(size = 10,
                                       color = "black"),
            axis.text.y = element_text(size = 10,
                                       color = "black"),
            axis.title.x = element_text (size = 15),
            axis.title.y = element_text (size = 15))
  })
  
  output$tempoplot <- renderPlot({
    
    data %>%
      filter(artist_name == input$artist) %>%
      
      ggplot(data = , aes(x = tempo,
                          y = album_name,
                          fill = ..x..)) +
      geom_density_ridges_gradient() + 
      theme_minimal() + 
      xlim(c(input$trange[1], input$trange[2])) + 
      labs(title="BPM Plot", x="Tempo", y="Album Name") +
      theme(legend.position = "bottom",
            plot.title = element_text(size = 25,
                                      face = "bold",
                                      color = "red",
                                      hjust = 0.5),
            axis.text.x = element_text(size = 10,
                                       color = "black"),
            axis.text.y = element_text(size = 10,
                                       color = "black"),
            axis.title.x = element_text (size = 15),
            axis.title.y = element_text (size = 15))
  })
  
  output$analysisplot <- renderPlot({
    
    album_var()
      
  })
  
}

#RunApp command
shinyApp(ui = ui, server = server)