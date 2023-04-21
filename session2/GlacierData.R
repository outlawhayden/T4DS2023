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
