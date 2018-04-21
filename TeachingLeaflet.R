# March 29 2018
# Leaflet Fun
# 24 April 2018
# RML

# Preliminaries
install.packages("leaflet") # comment out in order to knit
library(leaflet)
library(TeachingDemos)
library(ggplot2)
library(maps)
char2seed("Professor Looney")

# leaflet() creates a map widget that can store variables in order to modify the map later on
#----------------------------------------------------------------
                        #Making a Map

# addTiles() adds mapping data from Open Street Map
map <- leaflet() %>%
  addTiles() 
#OR without piping notation.
map=leaflet()
map= addTiles(my_map)

map

             # Making a colored map of the United States
mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)


#Link to Third Party Maps able to be used for plots.
#http://leaflet-extras.github.io/leaflet-providers/preview/index.html

#Satellite
m %>% addProviderTiles(providers$Esri.WorldImagery)

#Topography Map
m %>% addProviderTiles(providers$OpenTopoMap)

#National Geographic World Map
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)

# Make a map
my_map <- leaflet() %>%
  addTiles() %>%
  addProviderTiles(providers$Esri.WorldImagery) # adds certain map

#Guess who!
my_map <- my_map %>%
  addMarkers(lat=44.4764, lng=-73.1955)
my_map

#Give her a label
my_map <- my_map %>%
  addMarkers(lat=44.4764, lng=-73.1955,
             popup="Bio381 Classroom") # adds a pip up
my_map

markers%>%
  leaflet()%>%
  addTiles()%>%
  addCircleMarkers(lat=44.4764, lng=-73.1955,
                   popup="Bio381 Classroom")

#--------------------------------------------------------------
                       #Many data points
   
#Random data frame
df <- data.frame(lat= runif(20, min=44.4770, max=44.4793),
                 lng= runif(20, min=-73.18788, max=-73.18203))
head(df) 
df %>%
  leaflet() %>% #passes argument to make map
  addTiles() %>% # Adds mapping data from Open Street Map
  addMarkers() #Adds markers

#Using a .csv file
dF <- read.csv(file="leafletData30.csv") # 30 random lat & lng values

markers <- data.frame(lat= dF$lat,
                 lng= dF$lng)
head(markers) 

markers %>%
  leaflet() %>% 
  addTiles() %>% 
  addMarkers() 

                          #Circle Markers

markers%>%
  leaflet()%>%
  addTiles()%>%
  addCircleMarkers()

                        # Adding legends
df <- data.frame(lat = runif(20, min = 39.25, max = 39.35),
                 lng = runif(20, min = -76.65, max = -76.55),
                 col = sample(c("red", "blue", "green"), 20, replace = TRUE),
                 stringsAsFactors = FALSE)

dF %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(color = df$col) %>%
  addLegend(labels = c("A. rubrum", "T. canadensis", "P. strobus"), colors = c("blue", "red", "green")) 

            
#-----------------------------------------------------------------
                         #Making a cluster

dF2 <- read.csv(file="leafletData500.csv")

cluster <- data.frame(lat= dF2$lat,
                 lng= dF2$lng)
cluster%>%
  leaflet()%>%
  addTiles()%>%
  addMarkers(clusterOptions=markerClusterOptions())

#---------------------------------------------------------------
                      #Mapping your own marker

uvmIcon <- makeIcon(iconUrl = "UVM.jpg",
                    iconWidth = 31*215/230,
                    iconHeight= 31,
                    iconAnchorX= 31*215/230/2,
                    iconAnchorY= 16
)
UVMLatLong <- data.frame(
  lat= c(44.4779),
  lng= c(-73.1965))
UVMLatLong %>%
  leaflet()%>%
  addTiles()%>%
  addMarkers(icon= uvmIcon)

                    #Mapping Awesome Markers
leaflet()%>%
  addTiles()%>%
  addMarkers(icon= uvmIcon)


#----------------------------------------------------------------
                        #RECTANGLES
  leaflet() %>%
  addTiles() %>%
  addRectangles(lat1 = 44.479042, lng1 = -73.188312, 
                lat2 = 44.478368, lng2 = -73.186553)



                         #CIRCLES
dF %>%
  leaflet()%>%
    addTiles()%>%
    addCircles(lng = dF$lng,lat = dF$lat, 
               radius = 30,
               popup = "?")

cities <- read.csv("cities.csv")
print(cities)

leaflet(cities) %>% addTiles() %>%
  addCircles(lng = ~long, lat = ~lat, weight = 1,
             radius = ~sqrt(pop) * 30, popup = ~city)

             