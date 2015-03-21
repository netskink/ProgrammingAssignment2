# this is from the discussion board.
# I'm working through the example


# As a newbie to R programming myself, I found it very hard to understand each and every 
# line of the example functions and at this stage I think it is absolutely necessary to 
# understand each and every line as the functions are fairly simple compared to what we 
# would encounter in coming courses of the specialization.

# So I have prepared this post of what I have understood after reading the documentations 
# and some googling. Hope you find it useful.

# Let us examine one function at a time, first the makeVector function.

# I have added a few lines to the original example to understand the environments concept.
makeVector <- function(x = numeric()) {
  m <- NULL
  print(environment())
  evn <- environment()
  print(parent.env(evn))
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  getevn<- function() environment()
  
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean,
       getevn = getevn)
}

# now lets assign this function to a variable vec
x <- 1:10000
vec<-makeVector(x)
# <environment: 0x2924c28>
# <environment: R_GlobalEnv>

# We can see the two environments being printed from our print statements. We will look 
# into them in some time. 

# As we know the last statement of a function is returned, here "vec" will contain a 
# list of the functions defined in makeVector as the "list(set = ....)"  is our last 
# statement.

# Now let us see how the mean is cached. The cached mean is nothing but the variable "m",
# and we can access it through the functions getmean() and setmean(). Let us see some 
# examples.
vec$getmean()
# NULL
mx <- mean(x)
vec$setmean(mx)
vec$getmean()
# [1] 5000.5

# The above code is fairly straightforward. But how do we see the value of "m" 
# i.e. where the mean is stored by the setmean() function. We want to access it directly
# without the getmean() function. Here is where the environments come in. 
vec$getevn()
# <environment: 0x353b260>
ls(vec$getevn())
# character(0)

# The environment returned above is the environment inside the function getenv(),
# beacuse the statement returning the environment is defined inside this function, 
# but m is defined in the environment immediately outside i.e. the parent environment. 
# So lets try this:
parent.env(vec$getevn())
# <environment: 0x3322ab8>

ls(parent.env(vec$getevn()))
# [1] "evn"     "get"     "getevn"  "getmean" "m"       "set"     "setmean"
# [8] "x"

# As we can see "m" is defined in this environment and has the cached value. 
# We can see this by typing:
parent.env(vec$getevn())$m
# [1] 5000.5

# See! The cachemean() function does nothing but the same things that we did manually. 
# Go ahead and have a look at the cachemean() function and it should be very clear 
# to you now. 

# Hope this helps all the newbies like me who want to understand each and every line 
# of code from the examples.
