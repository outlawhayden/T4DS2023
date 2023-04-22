library(rgdal)
library(sp)
library(TDA)

# import data
download.file("https://www.sciencebase.gov/catalog/file/get/58af7532e4b01ccd54f9f5d3?facet=GNPglaciers_1966", destfile = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/GNPglaciers_1966.zip")
system("unzip /Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/GNPglaciers_1966.zip")

glaciers1966 <- readOGR(dsn = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/GNPglaciers_1966/GNPglaciers_1966.shp")
# get first element
glaciers1966[1,]
plot(glaciers1966[1,])

# plot all elements
plot(glaciers1966)

# just get the first glacier
glaciers1966[1,]

# sample points within the glacier polygon, save to variable
randGlac <- spsample(glaciers1966[1,], n = 1000, "random")

# random perhaps isn't the best. could we sample along a aregular grid?
unifGlac <- spsample(glaciers1966[1,], n = 4000, "regular")
plot(unifGlac, pch = 20, cex = 0.25)

# we can do a grid filtration on this
# we need to represent the boundary, since distfct() needs to parameters, use the polygon from the data

install.packages("pracma")
library(pracma)


rPointOnPerimeter <- function(n, poly) {
	xy <- poly@coords
	dxy <- diff(xy)
	# hypot depends on the pracma library, make sure it's installed
	h <- hypot(dxy[,1], dxy[,2])
	e <- sample(nrow(dxy), n,replace=TRUE, prob=h)
	u <- runif(n)
	p <- xy[e,] + u * dxy[e,]
    p}
    
poly <- glaciers1966[1,]@polygons[[1]]@Polygons[[1]]
perimeter <- rPointOnPerimeter(2000, poly)
plot(perimeter)

# convert data to dataframes
dfGlac <-as.data.frame(unifGlac)
distances <- distFct(perimeter, dfGlac)

# normalize distances in function
colors <- distances/max(distances)
plot(dfGlac[,1], dfGlac[,2], pch = 20, col = rgb(0,0,colors), cex = 1.5)

# now we can finally do the grid filtration

Diag1966 <- gridDiag(X = dfGlac, FUNvalues = distances, maxidmension = 1, sublevel = TRUE, printprogress = TRUE)
plot(Diag1966[["diagram"]])





# do analysis over time
#/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/
# 1998 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af765ce4b01ccd54f9f5e7?facet=GNPglaciers_1998",destfile = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers1998.zip")

# 2005 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af76bce4b01ccd54f9f5ea?facet=GNPglaciers_2005",destfile = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2005.zip")

# 2015 data
download.file("https://www.sciencebase.gov/catalog/file/get/58af7988e4b01ccd54f9f608?facet=GNPglaciers_2015",destfile = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2015.zip")

# import data
glaciers1998 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers1998/GNPglaciers_1998.shp")
glaciers2005 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2005/GNPglaciers_2005.shp")
glaciers2015 <- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session5/Glaciers2015/GNPglaciers_2015.shp")


unifGlac1998 <- spsample(glaciers1998[1,], n = 4000, "regular")
unifGlac2005 <- spsample(glaciers2005[1,], n = 4000, "regular")
unifGlac2015 <- spsample(glaciers2015[1,], n = 4000, "regular")

plot(unifGlac1998)
plot(unifGlac2005)
plot(unifGlac2015)

poly1998 <- glaciers1998[1,]@polygons[[1]]@Polygons[[1]]
perimeter1998 <- rPointOnPerimeter(2000, poly1998)

poly2005 <- glaciers2005[1,]@polygons[[1]]@Polygons[[1]]
perimeter2005 <- rPointOnPerimeter(2000, poly2005)

poly2015 <- glaciers2015[1,]@polygons[[1]]@Polygons[[1]]
perimeter2015  <- rPointOnPerimeter(2000, poly2015)

plot(poly1998)
plot(poly2005)
plot(poly2015)

dfGlac1998 <- as.data.frame(unifGlac1998)
dfGlac2005 <- as.data.frame(unifGlac2005)
dfGlac2015 <- as.data.frame(unifGlac2015)

distances1998 <- distFct(perimeter1998, dfGlac1998)
distances2005 <- distFct(perimeter2005, dfGlac2005)
distances2015 <- distFct(perimeter2015, dfGlac2015)

colors1998 <- distances1998/max(distances1998)
colors2005 <- distances2005/max(distances2005)
colors2015 <- distances2015/max(distances2015)

plot(dfGlac1998[,1], dfGlac1998[,2], pch=20, col = rgb(0,0,colors1998), cex = 1.5)

diag1998 <- gridDiag(X = dfGlac1998, FUNvalues = distances1998, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
diag2005 <- gridDiag(X = dfGlac2005, FUNvalues = distances2005, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)
diag2015 <- gridDiag(X = dfGlac2015, FUNvalues = distances2015, maxdimension = 1, sublevel = TRUE, printProgress = TRUE)



d1 = bottleneck(Diag1 = Diag1966$diagram, Diag2 = diag1998$diagram, dimension = 0)
d2 = bottleneck(Diag1 = diag1998$diagram, Diag2 = diag2005$diagram, dimension = 0)
d3 = bottleneck(Diag1 = diag2005$diagram, Diag2 = diag2015$diagram, dimension = 0)


# plot comparative bottleneck distances
pdf(file = "BottleneckDistanceDiffs.pdf")


plot(x=c(1,2,3), y=c(d1/(1998-1966), d2/(2005-1998), d3/(2015-2005)), ylab="Bottleneck Distance", xlab="Measurement Interval", main="Change in Bottleneck Distance over Time")
# with this plot, we can even add segments for visualization
segments(x0 = 1, y0 = d1/(1998-1966), x1 = 2, y1 = d2/(2005-1998), col = "black") 
segments(x0 = 2, y0 = d2/(2005-1998), x1 = 3,  y1 = d3/(2015-2005), col = "black")
dev.off()

