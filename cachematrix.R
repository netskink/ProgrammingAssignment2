## The first function, makeCacheMatrix creates object with functions
## and data.  It is used by the second function to solve for an inverse
## and cache the result.  Subsquent calls will retrieve the cached result

# There is a test routine at the end which is commented out to demo the code.
# There is another file in this repot mywork.r which shows how this program works
# and the buildup on simpler problems to elaborate the method.

## Creates a object with functions and data to cache the inverse of a matrix.
## This code uses the R concept of scoping.
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


##  This function calculates the inverse of a matrix using the solve() function.
## The first time the function is used, it finds the inverse and then caches the 
## result.  Subsequent calls for the same matrix will simply return 
## the cached result.
##
## The solve function will solve a system of linear equations but if only
## one parameter is provided it will solve to find the inverse of the matrix.
## ie A*B=I  where B is solved so that B is the inverse of A and the result
## is the identity matrix
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

# My test program for cacheSolve

#a = matrix(c(3,2,1,4,5,6,7,8,100),ncol=3)
#b=makeCacheMatrix(a)
# this will calc inverse and cache the result
#print(cacheSolve(b))
# this will use the cached result
#print(cacheSolve(b))
# this is just a check to see if the result is accurate
#print(solve(a))
