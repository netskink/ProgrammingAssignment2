## This is the code I used to solve the assignment.

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  # He does these as a function so
  # they dont get called each time.
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) m <<- inverse
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
  
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

########################################
#
# This is provided by the instructor to demonstrate caching the mean of a vector

# In this example we introduce the <<- operator which can be used to assign a 
# value to an object in an environment that is different from the current environment. 
# Below are two functions that are used to create a special object that stores a 
# numeric vector and caches its mean.

# The first function, makeVector creates a special "vector", which is really a list 
# containing a function to

# set the value of the vector
# get the value of the vector
# set the value of the mean
# get the value of the mean

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}



# The following function calculates the mean of the special "vector" created with the
# above function. However, it first checks to see if the mean has already been calculated.
# If so, it gets the mean from the cache and skips the computation. Otherwise, it calculates
# the mean of the data and sets the value of the mean in the cache via the setmean function.

cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}


# My test program for cachemean

a = c(1,2,3,4,5,6,7,8,9,10)
b=makeVector(a)
# this will calc mean of the vector and cache the result
print(cachemean(b))
# this will use the cached result
print(cachemean(b))
# this is just a check to see if the result is accurate
print(mean(a))


# My test program for cacheSolve

a = matrix(c(3,2,1,4,5,6,7,8,100),ncol=3)
b=makeCacheMatrix(a)
# this will calc inverse and cache the result
print(cacheSolve(b))
# this will use the cached result
print(cacheSolve(b))
# this is just a check to see if the result is accurate
print(solve(a))

stop("no need to run the other code now\n")

# From the R docs
# http://cran.r-project.org/doc/manuals/R-intro.html#Scope
open.account <- function(total) {
  list(
    deposit = function(amount) {
      if(amount <= 0)
        stop("Deposits must be positive!\n")
      total <<- total + amount
      cat(amount, "deposited.  Your balance is", total, "\n\n")
    },
    withdraw = function(amount) {
      if(amount > total)
        stop("You don't have that much money!\n")
      total <<- total - amount
      cat(amount, "withdrawn.  Your balance is", total, "\n\n")
    },
    balance = function() {
      cat("Your balance is", total, "\n\n")
    }
  )
}

ross <- open.account(100)
robert <- open.account(200)

ross$withdraw(30)
ross$balance()
robert$balance()

ross$deposit(50)
ross$balance()
ross$withdraw(500)


