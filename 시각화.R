#install.packages("sf")
#install.packages("mapproj")
#install.packages("sp")
#install.packages("ggmap")
#install.packages("raster")
#install.packages("rgeos")
#install.packages("maptools")
#install.packages("rgdal")
#install.packages("RcolorBrewer")
#install.packages("reshape2")
#install.packages("igraph")
#install.packages("rgdal")
library(tidyverse)
library(sf)
library(mapproj)
library(sp)
library(ggmap)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
library(RcolorBrewer)
library(reshape2)
library(readxl)
library(igraph)
library(rgdal)
#####구별 일인가구수 - 관악구가 가장 많음, 관악구를 중심으로 모델?? 강남구???
nuclear<-read_xlsx("C:/Users/KRX/Desktop/kpmg/nuclear.xlsx")
nuclear <- nuclear %>% filter(sex=="계") %>% dplyr::select(gu,sex,under) %>%filter(under>30000)%>%arrange()



head(nuclear)

ggplot(data=nuclear,aes(x=reorder(gu,-under),y=under))+
  geom_col()
#,fill=gu
#  theme(axis.title.x="구", axis.title.y="인구수")


###
data<-read_xlsx("C:/Users/KRX/Desktop/kpmg/동별일인가구.xlsx")
data <- data%>%filter(dong!="소계")%>% filter(gu=="강남구")
head(data)
write.table(data,file="clipboard",sep="\t",row.names=FALSE)
data

longlat<-read_xlsx("C:/Users/KRX/Desktop/kpmg/강남위도경도.xlsx")
head(longlat)

one<-read_xlsx("C:/Users/KRX/Desktop/kpmg/강남40세미만일인가구수.xlsx")
head(one)
fin<-merge(one,longlat,by="dong")
fin
write.table(fin,file="clipboard",sep="\t",row.names=FALSE)
#############주거유형별 서울시 지도 , 색 조정 필요
#고등학생을 동별로 merge??
dongdata<-shapefile("C:/Users/KRX/Desktop/kpmg/행정구역_읍면동/TL_SCCO_EMD.shp")  
dongdata<-spTransform(dongdata,CRSobj=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
dong_new_map<-fortify(dongdata, region="SIG_CD")

head(dongdata)
summary(dongdata)
colnames(data)[2]<-"EMD_KOR_NM"
head(data)
dong_merge <- merge(data,dongdata,by="EMD_KOR_NM")
head(dong_merge)


map_korea_resident <-st_read("C:/Users/KRX/Desktop/kpmg/서울 주거지역 지도좌표/UPIS_SHP_UQA100.shp")
head(map_korea_resident)
#map_korea_resident$ENT_NAME<-iconv(map_korea_resident$ENT_NAME,from="CP949",to="UTF-8",sub=NA,mark=TRUE,toRaw=FALSE)
map_korea_resident_shp <-as(map_korea_resident, "Spatial")
map_korea_resident_df<-fortify(map_korea_resident_shp)

str(map_korea_resident_df)

map_korea_resident_ggplot<-map_korea_resident_df %>%
  ggplot(aes(x=long,y=lat,group=group))

map_korea_resident_ggplot+
  geom_polygon(aes(fill=id),color="black",size=0.1, show.legend=FALSE)+
  coord_quickmap()+
  theme_minimal()

############

mapdata<-shapefile("C:/Users/KRX/Desktop/kpmg/행정구역_시군구_2017/TL_SCCO_SIG.shp")
seoul_id<-read.csv("C:/Users/KRX/Desktop/kpmg/seoul_id.csv",header=T)
head(seoul_id)
mapdata<-spTransform(mapdata,CRSobj=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
new_map<-fortify(mapdata, region="SIG_CD")



seoul_gu<-new_map[new_map$id<=11740,]
seoul_id$id = seoul_id$시군구코드
head(seoul_gu)
tail(seoul_gu)
head(seoul_id)
tail(seoul_id)
length(table(seoul_id$id))
###seoul_id 강남구 아이

seoul_id[seoul_id$시군구명_한글=="강남구"]

final <- merge(seoul_gu, seoul_id, by="id")
final 


ggplot()+
  geom_polygon(data=final,aes(x=long,y=lat,group=group),color="white")

gangnam<-final %>% filter(시군구명_한글=="강남구")
gangnam

head(gangnam)

gangnam_fin <-gangnam %>% dplyr::select(long,lat,order)
gangnam_fin1 <-gangnam_fin %>% filter(order<35043)
gangnam_fin2<-gangnam_fin %>% filter(order>=35043)
mean(gangnam_fin$order)
nrow(gangnam_fin1)
nrow(gangnam_fin2)

gwanak<-final %>% filter(시군구명_한글=="관악구")
gwanak

ggplot(data=final,aes(x=long, y=lat, group=group)) +
  theme_void()+
  geom_polygon(color="white")

ggplot(data=gangnam, aes(x=long, y=lat, group=group))+
  theme_void()+
  geom_polygon(color="white")

gangnam_high<-read_

gangnam_nuclear<-read_xlsx("C:/Users/KRX/Desktop/kpmg/gangnam_fin.xlsx")
head(gangnam_nuclear)

gangnam_high<-read_xlsx("C:/Users/KRX/Desktop/kpmg/강남고등학교fin.xlsx",col_types=c("text","numeric","numeric"))
gangnam_high
ggplot()+
  geom_polygon(data=gangnam,aes(x=long,y=lat,group=group))+
  geom_point(data=gangnam_high,aes(x=longitude,y=latitude,color="name"))+
  geom_point(data=gangnam_nuclear,aes(x=longitude,y=latitude,color="b",size=prediction))


ggplot()+
  geom_polygon(data=gangnam, aes(x=long,y=lat, group=group))+
  geom_point(data=coord, aes(x=long, y=lat, color="name"),size=0.1)

write.table(gangnam_fin1,file="clipboard",sep="\t",row.names=FALSE)
write.table(gangnam_fin2,file="clipboard",sep="\t",row.names=FALSE)

ggplot(data=gwanak, aes(x=long, y=lat, group=group))+
  geom_polygon(color="white")

'''
ggplot(data=final,aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=""),color="white") +
  theme_void()+
  scale_fill_gradient()+
  theme(legend.position=c(0.2,0.85), legend.direction="horizontal", legend.key.size=unit(1,"cm"), legend.title=element_blank())+
  geom_text(aes(label=paste(시군구명_한글, 순번, sep="\n")))
'''  

head(seoul_gu) 
head(highschool)
##########
highschool<-shapefile("C:/Users/KRX/Desktop/kpmg/동별고등학생수/nlsp_017001022.shp")
highschool<-spTransform(highschool,CRSobj=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
ggplot(data=highschool,aes(x=long, y=lat, group=group)) +
  geom_polygon(color="white")

#highschool
summary(resident)
summary(highschool)

final_high <-merge(final,highschool,by.x=long)

resident<-shapefile("C:/Users/KRX/Desktop/kpmg/서울 주거지역 지도좌표/UPIS_SHP_UQA100.shp")
resident<-spTransform(resident,CRSobj=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

#str(highschool)
#str(resident)
#ggplot()+
#  geom_polygon(data=highschool,aes(x=long,y=lat,group=group)) +
#  geom_polygon(data=resident,aes(x=long,y=lat,group=group,color="blue"))

######
#high<-readORG("C:/Users/KRX/Desktop/kpmg/동별고등학생수/nlsp_017001022.shp")
