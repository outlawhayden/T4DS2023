# create new complex
cplx <- list(1,2,3,4,5,6,c(1,2),c(2,3),c(3,4),c(4,5),c(5,6))

# two new value functions
cplxf1 <- c(0,1,2,3,9,0)
cplxf2 <- c(1,12,2,0,1,0)


# make new filtration
funFiltration1 = funFiltration(cplxf1, cplx)
# make new diagram
diag1 <- filtrationDiag(funFiltration1, maxdimension = 2)
plot(diag1[["diagram"]])

# make new filtration
funFiltration2 = funFiltration(cplxf2, cplx)
# make new diagram
diag2 <- filtrationDiag(funFiltration2, maxdimension = 2)
plot(diag2[["diagram"]])


# what is distance in TDA between two different persistence diagrams?
# back up. what is the distance between two set of points A and B?
# find all bijections between A and B, and find the weight of the optimal pairing between the sets of points. the final weight
# is then the largest distance in the optimal pairing

# this same math can be used to find the optimal matching between points, and find it's weight
# if the # of pts is different, ro far away but not very persistent, a bijection doesn't make any sense
# readjust and loosen to get bottleneck distance
# same, but when points are unmatched, you assign the distance for it the distance to the diagonal (y = x) line. then, what's the worst behaving matched point, the worst behaving unmatched point, and then get the worst of those two (l_infty norm of best dist vector)

# bottleneck fxn defined in R
# call back up two diagrams

diag1$diagram
plot(diag1[["diagram"]])

diag2$diagram
plot(diag2[["diagram"]])

# rerun grid filtration
n = 20
vals <- array(runif(n*n, c(n,n))
image(vals)

myfilt <- gridFiltration(FUNvalues = vals, sublevel = TRUE, printProgress = TRUE)
diag1 <- gridDiag(FUNvalues = vals, sublevel = TRUE, printProgress = TRUE)
plot(diag1[["diagram"]])

