## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# Create a matrix that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  
  m <- NULL
  ## set function
  set <- function(y) {
    x <<- y
    m <<-NULL
  }
  
  ## get the matrix
  get <- function() x
  
  ## set inverse of a matrix passed to the function
  setinverse <- function(inv) {
    m <<- inv
  }
  
  ## get inverse of a matrix
  getinverse <- function() m
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Write a short comment describing this function
# Cache the matrix inverse for reusing cached data
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  # If the value is not null, we have cached data, use it
  if(!is.null(m)) {
    message("getting cached data")
    return (m)
  }
  # We don't have cached data, so calculate and store in cache
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}
