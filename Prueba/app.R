library(shiny)

# instalamos el paquete install.packages("RMySQL")
library(RMySQL)
# Establecemos la conexion con la base de datos
conn <- dbConnect(MySQL(), user = 'root', password = 'root',
                  dbname = "suicidios", host = "localhost")

# Creamos una Query para obtener datos


ui <- fluidPage(
    sliderInput(inputId = "num",
              label = "Seleccione",
              value = 2000, min = 1985, max = 2016),
    plotOutput("barplot")
)


server <- function(input, output) {
    query = paste("select sum(suicides_no) as 'suicidios', country from suicidio group by country")
    result <- dbSendQuery(conn, query)
    
    # Pasamos los datos a un data.frame
    datos <- fetch(result)
    # Obtenemos las columnas
    suicidios <- datos["suicidios"]
    year <- datos["country"]
    # Cast de data.frame a vector
    valor <- as.vector(t(suicidios))
    a <- as.vector(t(year))
    output$barplot <- renderPlot({
        barplot(valor, names.arg = a, main = input$num)
    })
}

shinyApp(ui = ui, server = server)
