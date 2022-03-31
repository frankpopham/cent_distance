# distance between 2011 datazone centroids for Scotland

library(tidyverse)
library(sf)


#download and unzip shape files from Scottish Government

download.file("https://maps.gov.scot/ATOM/shapefiles/SG_DataZoneCent_2011.zip", "dz.zip")
unzip("dz.zip")

#read in shape files

scotland_dz_centroid <- st_read("SG_DataZone_Cent_2011.shp")

#work out distance

scotland_dz_dist <- st_distance(scotland_dz_centroid,scotland_dz_centroid)

#put it in a long tibble as easier for matching

scotland_dz_dist <- as_tibble(scotland_dz_dist) %>%
  mutate(dz=scotland_dz_centroid$DataZone) %>%
  pivot_longer(-dz, names_to="dz2", values_to = "metres", names_prefix = "V") %>%
  group_by(dz) %>%
  mutate(dz2 =scotland_dz_centroid$DataZone) %>%
  ungroup()



