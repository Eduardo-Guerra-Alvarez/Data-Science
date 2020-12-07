# instalamos el paquete install.packages("RMySQL")
library(RMySQL)
# Establecemos la conexion con la base de datos
conn <- dbConnect(MySQL(), user = 'root', password = 'root',
                  dbname = "suicidios", host = "localhost")

# Creamos una Query para obtener datos
result <- dbSendQuery(conn, 
                      "select sum(suicides_no) as 'suicidios', sex from suicidio group by sex")

# Pasamos los datos a un data.frame
datos <- fetch(result)
# Obtenemos las columnas
suicidios <- datos["suicidios"]
sexo <- datos["sex"]
# Cast de data.frame a vector
valor <- as.vector(t(suicidios))
valor
a <- as.vector(t(sexo))

# Graficamos la informacion
pie(valor, names.arg = a,xlab = "sexo",ylab = "Suicidios", main = "Suicidios Totales")


