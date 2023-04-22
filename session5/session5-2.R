library(rgdal)
library(sp)
library(TDA)

glaciers1966 <- readOGR(dsn = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/GNPglaciers_1966/GNPglaciers_1966.shp")
glaciers1998 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers1998/GNPglaciers_1998.shp")
glaciers2005 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2005/GNPglaciers_2005.shp")
glaciers2015 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2015/GNPglaciers_2015.shp")

bottleneck_glacier( <- function(i){
	unifGlac1966 <- spsample(glaciers1998[i,], n = 4000, "regular")
	unifGlac1998 <- spsample(glaciers1998[i,], n = 4000, "regular")
	unifGlac2005 <- spsample(glaciers2005[i,], n = 4000, "regular")
	unifGlac2015 <- spsample(glaciers2015[i,], n = 4000, "regular")
	
	dfGlac1966 <- as.data.frame(unifGlac1998)
	dfGlac1998 <- as.data.frame(unifGlac1998)
	dfGlac2005 <- as.data.frame(unifGlac2005)
	dfGlac2015 <- as.data.frame(unifGlac2015)
	
	poly1966 <- glaciers1998[k,]@polygons[[1]]@Polygons[[1]]
	perimeter1966 <- rPointOnPerimeter(2000, poly1998)
	
	poly1998 <- glaciers1998[k,]@polygons[[1]]@Polygons[[1]]
	perimeter1998 <- rPointOnPerimeter(2000, poly1998)

	poly2005 <- glaciers2005[k,]@polygons[[1]]@Polygons[[1]]
	perimeter2005 <- rPointOnPerimeter(2000, poly2005)

	poly2015 <- glaciers2015[k,]@polygons[[1]]@Polygons[[1]]
	perimeter2015  <- rPointOnPerimeter(2000, poly2015)
	
	
	distances1966 <- distFct(perimeter1966, dfGlac1966)
	distances1998 <- distFct(perimeter1998, dfGlac1998)
	distances2005 <- distFct(perimeter2005, dfGlac2005)
	distances2015 <- distFct(perimeter2015, dfGlac2015)
	
	diag1966 <- gridDiag(X = dfGlac1966, FUNvalues = distances1966, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
	diag1998 <- gridDiag(X = dfGlac1998, FUNvalues = distances1998, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
	diag2005 <- gridDiag(X = dfGlac2005, FUNvalues = distances2005, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
	diag2015 <- gridDiag(X = dfGlac2015, FUNvalues = distances2015, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)


	
}