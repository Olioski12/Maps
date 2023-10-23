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

tmap_options(check.and.fix = TRUE)
electorates <- st_read(here::here('Aus2021/2021_ELB_Region.shp'))
votesall <- read.csv(here::here('2022Data.csv')) %>% filter(PartyNm != "Informal")
votes <- votesall %>% filter(PartyAb == "GRN")
votes <- votes %>% select(DivisionNm,TotalVotes)

electorates <- electorates %>% mutate(Percent=0)
for (i in 1:nrow(electorates)){
  divall <- votesall %>% filter(DivisionNm == electorates$Elect_div[i])
  vote <- votes %>% filter(DivisionNm == electorates$Elect_div[i])
  electorates$Percent[i] <- vote$TotalVotes[1]/(sum(divall$TotalVotes))*100
}



tm_shape(electorates) + tm_polygons("Percent", style="cont", title="Greens Primary", id = "Elect_div", palette = rev(hcl.colors(8,"Greens"))) #+ tm_text("Elect_div")
tmap_mode("view")
tmap_last()
tmap_save(filename = here::here("Greens2022.html"))
