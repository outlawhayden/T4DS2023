install.packages("TDA")
library(TDA)

# In the R TDA Package, simplical complexes are represented as lists generally

# create a new simplical complex using the list, c, and combine function
# usually each node is labeled as an integer
simpleK <- list(1,2,c(1,2))

K <- list(1,2,3,4,c(1,2),c(1,3),c(1,4),c(2,3),c(2,4), c(3,4), c(1,2,3))

# VR complex of S and R is the abstract simplicial complex, consisting of all subsets of diameter at most R
# VR(S,r) := {σ in S | diam(σ) <= r}, where the diam(σ) is the max dist between any two points in σ

# How do we get from cloud of data points to topology? Using these VR complexes of data
# give each data point a radius r - the best value that represents is not known. But if we iterate, we get a set of nested VR complexes that collectively we call the Vietoris-Rips filtration (or Rips filtration)

# try some simple data points
x <- c(0,1,2,3)
y <- c(0,3,-1,2)
plot(x=x, y=y)
X <- cbind(x,y)

# TDA package includes ripsFiltrations function to do this
mymaxscale <- 2# max radius of data balls
mymaxdimension <- 4 
mydist <- "euclidean"
mylibrary <- "Dionysus"

# do the rips filtration
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension, maxscale = mymaxscale, dist = mydist, library = mylibrary, printProgress = TRUE)

# max scale is less than sqrt(2) which is the closest distance between points, so nothing happens
# what if we increase the max scale to sqrt(5)
mymaxscale <- sqrt(5)
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension, maxscale = mymaxscale, dist = mydist, library = mylibrary, printProgress = TRUE)

# now returns 4 vertices, but also the edges between 1,3 and 2,4
# expand maxscale to sqrt(13) and sqrt(17), the second and third longest distances between points
mymaxscale <- sqrt(13)
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension, maxscale = mymaxscale, dist = mydist, library = mylibrary, printProgress = TRUE)

mymaxscale <- sqrt(17)
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension, maxscale = mymaxscale, dist = mydist, library = mylibrary, printProgress = TRUE)
# ends with 15 elements in full nested list




# images and lower star filtrations

# sometimes we already know what the connections is or the topological space is, not just a point cloud
# consider a random picture

n = 20
vals <- array(runif(n*n), c(n,n))
image(vals)

# how do we construct a complex that represents an image?
# for each pixel - add a vertex, and an edge if they are adjacent. from here, add squares to get a cubical complex
# if you want a simplicial complex, just add diagonals


# what should the value assigned to each edge and cell? we just have pixel value for nodes
# raise each vertex equal to the height of its value, then interpolate edge and two-cells
# lower star filtration -> consider a subcomplex of the surface entirely at or below the current height parameter

newfxn <- function(x,y){jitter(-2*x^2+y^2+x+3*y-6*x+x*y,30)}
x <- seq(-5,5)
y <- seq(-5,5)
persp(x,y,outer(x,y,newfxn), zlab = "height", theta = 55, phi = 25, col = "palegreen1", shade = 0.5)


# get the lower-star filtration from the values in the image like this

myfilt <- gridFiltration(FUNvalues = vals, sublevel = TRUE, printProgress = TRUE)


# as you iterate the parameter for these filtrations, you should keep track of when a homology feature is "born" as well as when it "dies. barcodes encode this as interval (b,d), but persistence diagrams encode it as a 2d point (b,d)

# create diagrams for rips filtrations using ripsDiag
persistDiag <- ripsDiag(X, maxdimension = 4, maxscale = sqrt(17), dist = "euclidean", printProgress = TRUE)
plot(persistDiag[["diagram"]])


# create plots for a lower-start filtration
# included in TDA, find persistence diagram
pd = gridDiag(FUNvalues = vals)
plot(pd[["diagram"]])

# do barcode version
plot(pd[["diagram"]], barcode = TRUE)

# inverse-V example
a <- 1
b <- 2
c <- 3 
ac <- c(1,3)
bc <- c(2,3)
vcplx <- list(a,b,c,ac,bc)

# store coordinates
x <- c(0,2,1)
y <- c(0,1,1)
coords = cbind(x,y)

vvals <- c(0,0,1)

# run filter
vfilt <- funFiltration(vvals, vcplx)
vdiag <- filtrationDiag(vfilt, maxdimension = 2)
vdiag$diagram

