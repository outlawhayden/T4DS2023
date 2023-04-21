#t4ds 2023 Data Wrangling Project

# anything in R is an object
vec <- c(1,2,3)
print(vec)

# make nested lists
my_list <- list(a = vec, b = 52)
my_list

# access attributes either one of these ways - they are equivalent
my_list$a
my_list[['a']]

# define functions
my_fun <- function(x){
	ret <- x + 1
	return(ret)
}
my_fun(3)

# functions are also objects! can be assigned to other variables
my_list$f <- my_fun
my_list$f

# both are now the same
my_list$f(2.3)
my_fun(2.3)

# built in help guides
?list
help(list)

# to get source, just type in the function
list

#str is structure
str(my_list)


# reading data in, done using csv from online source
glacier_csv <- 'https://pkgstore.datahub.io/core/glacier-mass-balance/glaciers_csv/data/c04ec0dab848ef8f9b179a2cca11b616/glaciers_csv.csv'
glacier_data <- read.csv(file = glacier_csv, header = TRUE)

glacier_data

# what class is the data?
class(glacier_data)
# data.frame

# how big is the dataframe?
dim(glacier_data)
# 70x3

# get the first five rows
head(glacier_data, 5)

# how to index rows, columns
# r1,c1
glacier_data[1,1]

# r27,c3
glacier_data[27,3]

# can pull multiple entries simultaneously with c() (combine) function
# grab rows 2,3,5, columns 2,3
glacier_data[c(2,3,5), c(2,3)]

# use colons to get contiguous indices
# rows 4-10, all 3 columns
glacier_data[4:10, 1:3]


# you can get statistics, min, max, sd, mean
# can also compile summary
summary(glacier_data)


# plot data
plot(x=glacier_data[,1], y=glacier_data[,2], xlab="Year", ylab = "Cumulative Mass Balance", main ="Glacier Health vs. Time")


# move on to GIS data
# load new data
download.file("https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCounties_shp.zip", destfile = "/Users/haydenoutlaw/Documents/Projects/T4DS2023/session2/MontanaCounties.zip")
system("unzip /Users/haydenoutlaw/Documents/Projects/T4DS2023/session2/MontanaCounties.zip")

# we need special libraries for shape data, rgdal and spatial polygons
install.packages("rgdal")
library(rgdal)
library(sp)

# now, open shapefile using rgdal function readOGR
counties<- readOGR(dsn="/Users/haydenoutlaw/Documents/Projects/T4DS2023/session2/MontanaCounties_shp/County.shp")
class(counties)
# new class! sp or spatial data 
dim(counties)
head(counties,3)
# gross! what about plot?
plot(counties)

# what are the attributes?
names(counties)
# OR
counties$NAME

# we can look up the associated data given a county's index
counties[1,]

# find data based on attributes with which
which(counties$NAME == "CHOUTEAU")
# which also has max and min attributes, so we can find polygons and minimizing perimiters
counties$NAME[which.min(counties$PERIMETER)]

# select a specific county

gallatin <- counties[which(counties$NAME == "GALLATIN"),]
plot(gallatin)


# a polygon is a set of points - we can get it very carefully
coords <- gallatin@polygons[[1]]@Polygons[[1]]@coords
plot(coords)

# we can also make a polygon using spsample, randomly sample points in interior
gallatinSample <- spsample(gallatin, n = 1000, "random")
plot(gallatinSample, pch=20, cex = 0.5)

# you can test if some point is within a oplygon using point.in.polygon fxn
point.in.polygon(460000, 150000, coords[,1], coords[,2])
# 1 -> TRUE
point.in.polygon(1,2,coords[,1], coords[,2])
# 0 -> FALSE

# get three counties surrounding flathead lake
lakeNeighbors <- counties[c(which(counties$NAME == "FLATHEAD"), which(counties$NAME == "MISSOULA"), which(counties$NAME == "SANDERS")),]

plot(lakeNeighbors)