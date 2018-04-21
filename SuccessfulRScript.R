#Leaflet: attempt at typing out the code

#Leaflet Presentation
# 24 April 2018
# RML

# Leaflet is a way to create interactive maps. leaflet() creates a map widget, capable of storing variables in order to be modified later on.

#Preliminaries
install.packages("leaflet") # comment out in order to knit
library(leaflet)
library(maps)
library(TeachingDemos)
char2seed("Professor Looney")
dF <- read.csv("leafletData30.csv")
dF2 <- read.csv("leafletData500.csv")
cities <- read.csv("cities.csv")

# Creating a simple map of 
# addTiles() adds mapping data from "Open Street Map"
# %>% The piping notation takes an output, and adds it to the next command as the first argument, and reassigns it to a variable.
my_map <- leaflet() %>%
  addTiles()
my_map

my_map=leaflet()
my_map=addTiles(my_map)
my_map

#Adding different styles of maps and incorporating them into your data:
#http://leaflet-extras.github.io/leaflet-providers/preview/index.html

#Satellite
my_map %>% addProviderTiles(providers$Esri.WorldImagery)

#Adding it to our map
my_map <- leaflet() %>% 
  addTiles() %>%
  addProviderTiles(providers$Esri.WorldImagery)
my_map

#Add markers to my_map
map <- my_map %>%
  addMarkers(lat=44.4764,lng=-73.1955)
map

#Give her a label
map <- my_map %>%
  addMarkers(lat=44.4764,lng=-73.1955,
             popup="BIO381 Classroom")
    
map
 
#Adding many markers
#adding 1 marker isnt very practical, and in a real experiment you will have many markers in a single frame.
#create a random data set
df <- data.frame(lat=runif(20,min=44.4770,max=44.4793),
                 lng=runif(20,min=-73.18788,max=-73.18203))
head(df)

df %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers()

#with a data frame
markers <- data.frame(lat=dF$lat,
                       lng=dF$lng)
head(markers)

markers %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers()
# with circles?
markers %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers()

#Adding legends with multiple variables
df <- data.frame(col=sample(c("red","blue","green"),
                           20,replace=TRUE),
                 stringAsFactors=FALSE)
markers %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(color=df$col) %>%
  addLegend(labels =c("A.rubrum","T. canadensis","P. strobus"),colors=c("red","blue","green"))

#Clusters!!!
cluster <- data.frame(lat=dF2$lat,
                      lng=dF2$lng)
cluster %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())

#Adding custom icons
uvmIcon <- makeIcon(iconUrl = "UVM.jpg", # call the image
                    iconWidth = 31*215/230,
                    iconHeight= 31,
                    iconAnchorX= 31*215/230/2,
                    iconAnchorY= 16
) # what i found to be the best length,height,width for marker
UVMLatLong <- data.frame(
  lat= c(44.4779),
  lng= c(-73.1965)) #lat & lng for your data point 
UVMLatLong %>%
  leaflet()%>%
  addTiles()%>%
  addMarkers(icon= uvmIcon)

#Adding Shapes
# ability to add rectangles, polygons, and circles.
#polygons
mapStates= map("state",fill=TRUE,plot=FALSE)
leaflet(data=mapStates) %>%
  addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

#Circles
print(cities)
leaflet(cities) %>% addTiles() %>%
  addCircles(lng=~long,lat=~lat,weight=1,
             radius=~sqrt(pop)*30,popup=~city)
