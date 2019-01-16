### Title:    An example R array job script using parallel processing  
### Author:   Pavel Panko
### Created:  2018-JAN-16
### Modified: 2018-JAN-16

## Use the "parallel" package for parallel processing function "mclapply"
library(parallel)

## Use the "purrr" package to create the replication list
library(purrr)

###
### 1. Set up condition List
###

## Number of replications to create
replications <- 1:100
## Number of occasions 
nOccasions <- c(100, 200)
## Number of samples per occasion
nSamples   <- c(500, 1000)

## Create condition list using purrr::cross
conditionList <- cross(
    list(
        replications = replications,
        nOccasions   = nOccasions,
        nSamples     = nSamples
    )
)

###
### 2. Stratify conditions for current task
###

## Get environmental variables
nCores <- as.numeric(Sys.getenv("N_SLOTS"))
taskId <- as.numeric(Sys.getenv("SGE_TASK_ID"))

## Divide number of conditions by number of cores 
conditionSeq  <- seq(
    from = 1,
    to   = length(conditionList),
    by   = nCores
)

## Subset condition list for the current task
useIds <- conditionSeq[taskId]:(nCores*taskId)
useConditions <- conditionList[useIds]

###
### 3. Initialize function to use 
###

## Function used to draw standard normal observations 
createSampleMatrix <- function(condition) {
    ## Unpack current condition into the environment 
    list2env(condition, environment())
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

###
### 4. Run function and save data 
###

## Create a list of matrices of standard normal observations
sampleMatList <- mclapply(
    X          = useConditions,
    FUN        = createSampleMatrix,
    mc.cores   = nCores
)
### NOTE: the "mclapply" function is only for Linux-OS 

## Save the list of matrices to an RDS file in the data directory 
saveRDS(sampleMatList, "data/sampleMatList-", taskID, ".RDS")



