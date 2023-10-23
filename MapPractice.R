library(dplyr)
library(here)
library(sf)
library(RColorBrewer)
library(leaflet)
library(ggplot2)
library(maps)
library(sp)
library(mapview)
library(tmap)

# ## Making images from shapefiles
# nc <- st_read(system.file("shape/nc.shp", package="sf")) 
# # plot(nc["AREA"], main = "AREA", breaks = "quantile", nbreaks = 9, pal = brewer.pal(9, "YlOrRd"))
# nc_sp <- as(nc,"Spatial")
# 
# # spplot(nc_sp, "SID74", main = "SID74", col.regions = brewer.pal(9, "YlOrRd"))
# 
# tm_shape(nc) + tm_polygons("BIR79", style="quantile", title="NC BIR79")
# 
# tmap_mode("view")
# tmap_last()

suburbs <- read.csv(here::here('MelbourneSuburbs.csv'), header = FALSE)
sb <- c()
for (i in 1:ncol(suburbs)){
  sb[i] <- trimws(gsub("\\."," ",suburbs[i]))
}

vic <- st_read(here::here('GDA94/vic_localities.shp'))
col <- data_frame(order=1:nrow(vic))
vic <- cbind(vic, col)

vic <- vic %>% filter(vic$LOC_NAME %in% sb)


#plot(vic["order"], main = "order", breaks = "quantile", nbreaks = 9, pal = brewer.pal(9, "YlOrRd"))
tm_shape(vic) + tm_polygons("LOC_NAME", style="quantile", title="Victoria") + tm_text("LOC_NAME")

tmap_mode("view")
tmap_last()



# ##Interactive maps
# leaflet() %>% 
#   addTiles() %>%
#   addMarkers(lng=20,lat=0,popup = "Hi")

# #choropleth
# world_map <- map_data("world") 
# ggplot(world_map, aes(long, lat, group = group)) +  
#   geom_polygon(fill = "red", color = "gray50") +  
#   coord_map("mercator") +  
#   ggtitle("World Map") +  
#   theme_void() 

# ## points on a map
# lng = c(85.21, 80.23, 77.28) 
# lat = c(25.59, 12.99, 28.56) 
# names = c("Patna", "Chennai", "New Delhi")
# 
# points_df = data.frame(lng,lat,names)
# 
# points_sdf = st_as_sf(points_df, coords = c("lng", "lat"), crs = 4326) 
# 
# mapview(points_sdf, label = points_sdf$names)
# # 4326 means lat long

