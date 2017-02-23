## The following is a pair of functions that cache and compute the
## inverse of a matrix.
makeCacheMatrix <- function(m = matrix() )
{
    # File: cachematrix.R
    # Author: Sidafa Conde
    # Email: sconde@umassd.edu
    # School: UMass Dartmouth
    # Date: 02/22/2017
    # Purpose: Caching the Inverse of a Matrix

    inv <- NULL
    set <- function (mtx = matrix())
    {
        mat <<- mtx;
        inv <<- NULL
    }

    get <- function () return(mtx)
    setInverse <- function(newInv)  inv <<- newInv
    getInverse <- function()  return(inv)
    return(list( set = set, get = get, setInverse = setInverse, getInverse = getInverse))
}

cacheSolve <- function(x, ...)
{
    # File: cacheSolve
    # Author: Sidafa Conde
    # Email: sconde@umassd.edu
    # School: UMass Dartmouth
    # Purpose: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above
    # If the inverse has already been calculated (and the matrix has not changed), then cacheSolve should retrieve the inverse from the cache.
    # Assumption: x is an invertible matrix

    #make sure that the input is a square matrix
    #stopifnot(nrow(x) == ncol(x))

    mat <- x$getInverse()
    if (!is.null(mat))
    {
        message("getting cached data"); return(mat)
    }

    data <-x$get();
    matInv <- solve(data)
    x$setInverse(matInv)
    return(matInv)
}
