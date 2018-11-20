## Installing R packages locally

This is a short tutorial for installing R packages in your local Quanah session when they are not already available in the main package directory. 

For instance, let's say you would like to use the mice package on Quanah. You log in, start R with the intention of testing
mice and you see this error message: 

```R
> library(mice)
## Error in library(mice) : there is no package called 'mice'
```

You might try to install the package using the `install.packages` function, but you see the following:

```R
> install.packages("mice")
## Warning in install.packages("mice") :
##  'lib = "/opt/ohpc/pub/libs/intel/R/3.5.0/lib64/R/library"' is not writable

```

The best option is to install the packages in your "locally" for your Quanah user session. It's
helpful to first create a directory that will serve as your local R library.

```bash
## Check that our current working directory is correct
> pwd
/home/<eraider>

## Create a "libs" directory here  
> mkdir libs
```

You can now install packages inside this directory that are not generally available
on Quanah. You have a couple options for how to do this.

#### Installing packages inside R

This is usually the most convenient approach as it is similar to standard R
package installation. When logged into Quanah, start R by loading the modules
and starting an R session:

```bash
## Load modules
> module load intel R

## Start R
> R
```

Once R is running, the `install.packages` function can be used to install locally when
provided with the location of the installation directory:

```R
install.packages("mice", lib = "home/<eraider>/libs")
```

#### Installing packages outside R

This approach is more general but requires a bit more preparation.

First, you will need the source URL for the package you want to download.
These can be usually be found on the cran [web-page](https://cran.r-project.org/web/packages/)
or another hosting service, just as long as you get the package [tar-ball].

Here's an example using wget:

```bash
## Change directories to "libs"
> cd libs

## Download mice package tar-ball using wget
> wget https://cran.r-project.org/src/contrib/mice_3.3.0.tar.gz
```

Once the package [tab-ball] is successfully downloaded, it can be installed
using R in batch mode by invoking `R CMD INSTALL`:

```bash
## Install 
> R CMD INSTALL mice_3.3.0.tar.gz -l .
* installing *source* package 'mice'
...
```

Note: the argument `-l .` specifies that the package should be installed in the
current directory.

---

Of course, R will need to be told to look in your local library when attempting
to find packages to load. Although this can get very tedious, there are a couple
ways to simplify this process.

The "quick-and-dirty" method is to provide the location of the local R library
to the `library` function:

```R
> library(mice, lib.loc = "/home/<eraider>/libs")
```

This does not decrease the tedium because the `lib.loc` argument will need to be
declared each time the library function is used. A better way would be to set
the local R library directory as an environmental variable in R. This can either be
declared inside the default R environment (i.e., the .Renviron file) or inside the shell
script.

To set the local library to be loaded in R by default, you would need to initialize
the .Renviron file inside the directory of your job script. Once you have navigated to
that directory, simply run this:

```bash
> echo 'R_LIBS=/home/<eraider>/libs' >> .Renviron
```

This will ensure that the local R library is used by any R session running inside
the directory that contains the .Renviron file. You can always check that R detects the 
local library by starting R and running `.libPaths()`. You should see something like this:

```R
> .libPaths()
[1] "/home/<eraider>/libs"                               
[2] "/opt/ohpc/pub/libs/intel/R/3.5.0/lib64/R/library"
```

While the ".Renviron" approach is simple, it is still somewhat tedious because each job folder 
will need to have a separate .Renvion file. Instead, the most flexible method for loading local 
packages is to include the environmental variable inside the job shell script, as shown below: 

```bash
#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N testJob
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe sm 10

module load intel R 

export R_LIBS=/home/ppanko/libs

Rscript 02_testJob-parallel.R
```

This shell script is the same as the one used for testJob-basic except that it includes the `export` statement that ensures 
the local library is acknowledged by R. This method keeps all of the job "settings" together in one legible file and is convenient and modular both of which can help reduce the number of bugs in your job. 
