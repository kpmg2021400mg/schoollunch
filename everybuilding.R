library(sp)
library(rgdal)

convertCoordSystem <- function(long, lat, from.crs, to.crs){
  xy <- data.frame(long=long, lat=lat)
  coordinates(xy) <- ~long+lat
  
  from.crs <- CRS(from.crs)
  from.coordinates <- SpatialPoints(xy, proj4string=from.crs)
  
  to.crs <- CRS(to.crs)
  changed <- as.data.frame(SpatialPoints(spTransform(from.coordinates, to.crs)))
  names(changed) <- c("long", "lat")
  
  return(changed)
}


from.crs = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs"

to.crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

building<-read_xlsx("C:/Users/KRX/Desktop/kpmg/everybuildingingangnam.xlsx")
colnames(building)
building_fin<-cbind(building$x,building$y)
colnames(building_fin)<-c("x","y")
building_fin<-as.data.frame(building_fin)

coord<-cbind(building_fin,convertCoordSystem(building_fin$x, building_fin$y, from.crs, to.crs))

coord<-coord[,3:4]
coord1<-coord[1:800,]
coord2<-coord[801:1600,]
coord3<-coord[1601:nrow(coord),]

write.table(coord1,file="clipboard",sep="\t",row.names=FALSE)
write.table(coord2,file="clipboard",sep="\t",row.names=FALSE)
write.table(coord3,file="clipboard",sep="\t",row.names=FALSE)




