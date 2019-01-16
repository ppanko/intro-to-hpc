### Title:    An example R job script using parallel processing  
### Author:   Pavel Panko
### Created:  2018-OCT-24
### Modified: 2018-OCT-26

## Use the "parallel" package for parallel processing function "mclapply"
library(parallel)

## Number of occasions and number of samples per occasion 
nOccasions <- 200
nSamples   <- 500

## Function used to draw standard normal observations 
createSampleMatrix <- function(times, ...) {
    ## Create an empty matrix 
    sampleMatrix <- matrix(NA, ncol = nOccasions, nrow = nSamples)
    ## Fill each matrix column with standard normal draws  
    for(i in 1:nOccasions) {
        ## Assign a draw of "nSamples" to the matrix column i
        sampleMatrix[,i] <- rnorm(nSamples)
    }
    ## Return full matrix 
    return(sampleMatrix)
}

## Number of matrices to create
nMats <- 1000

## Create a list of "nMats" matrices of standard normal observations
sampleMatList <- mclapply(
    X          = 1:nMats,
    FUN        = createSampleMatrix,
    nOccasions = nOccasions,
    nSamples   = nSamples,
    mc.cores   = 10
)
### NOTE: the "mclapply" function is only for Linux-OS 

## Save the list of matrices to an RDS file in the data directory 
saveRDS(sampleMatList, "data/sampleMatList.RDS")



