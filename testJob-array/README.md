# Running a job array

Disclaimer: The HPCC website has a wonderful guide for creating and submitting [array jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
which can be accessed [here](https://www.depts.ttu.edu/hpcc/userguides/general_guides/array_jobs.php). The guide on this page is focused on HPC [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) written for R
and is intended as a less technically-rigorous, yet a more practially-oriented treatment of
the subject.

This guide also assumes that you have [access]() to Quanah and know the basics of [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) submission
as laid out on the [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) page. Once again, I do not offer advice on how to design
your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and only offer advice about how to submit and run the job using the Quanah [computer
cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

---

## 0. Larger, longer jobs 

It's no secret that some [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) take longer than others. Whether it's due to computational
complexity, or just a large number of [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) may be running for days. Unfortunately,
the Quanah queue has a 48 hour lock-out time for regular users. This means that unless your
[job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is finished within 48 hours it will be deleted and you will likely lose progress.

To circumvent this issue without major changes/revisions to your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), there are three main ways Quanah
can help you, which I will discuss in some detail below. 

## 1. Options for large jobs 

#### Request more resources 

Requesting more resources seems like the most approachable solution, but if you are requesting
more than the maximum number of processors available on a single machine (36), you will need to use
the "Message Passing Interface" protocol (MPI - guide forthcoming) so that your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) can request processors
from more than one computer. This will likely increase the complexity of your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), [job
script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) itself because all of these will now need to be tailored to the fact that they
are operating across multiple computers. 

#### Submit multiple jobs

The other approach is to split your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into several pieces and submit each piece as a separate [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).
This, of course, will require the creation of several [job scripts](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) as well as some faciliatation of
your workspace to make certain the two [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) do not interfere with one-another.

One way to control the scheduling of multiple [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is to, for example, specify that the second [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
should only begin after the first [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is finished. Here's an example with two [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) called `job1`
and `job2` that are submitted through shell scripts `run_job1.sh` and `run_job2.sh`, respecitvely.

```bash
qsub -N job1 run_job1.sh
qsub -N job2 -hold_jid job1 run_job2.sh
```

Here we have submitted both `job1` and `job2` and specified that `job2` should wait to be submitted to the
[job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) until after `job1` has finished. We have done this by using the argument `-hold_jid`.

You can also put [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) on "hold" by using the `qalter` function using the [job's](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) id provided by `qstat`:

```bash
## Put job on hold
qalter -h u <job_id>

## Release job on hold
qalter -h U <job_id>
```

(Special thanks to HPCC staff for assistance with this section!)

## 2. Submitting an array job

Perhaps the most flexible way to submit long-running [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is to create an [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) by using the
`-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) inside your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). This approach is similar to submitting multiple [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
except that you will only need one [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)! The "array" is created by virtue of a single [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
being split into several [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), each with it's on [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) ID specified by the `-t` [job parameter](). 

The benefit to this is that an [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will allow for a longer [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) run time as each [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will have 48
hours to complete, as opposed to 48 hours total for the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) itself. All you will need to do in ensure that
the [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) IDs are correctly used by your [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to split your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Let's take a look at an example
shell script that uses the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md):

```bash
#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N testJob-array
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe sm 10
#$ -t 1-81:8

module load intel R 

Rscript 01_testJob-array.R
```

In the shell script above, we can see that the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is specified as the `<start_id>`-`<end_id>`:`<step_size>`
and that each of these fields must contain an integer greater than zero and that the `<end_id>` must be greater than the `<start_id>`,
and the `<step_size>` controls the increments of the split.

This particular `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) has specified that our
[job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will be divided into 10 [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) of 8 [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) IDs each. In practice this might mean we want 10 [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to be assigned 8
processors each (as specified here), or that we want to make a 48\*10 hour window available for our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Whatever the case, R will need
to be linked to the specification of the [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) by using the provided [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) as described in the
next section.

## 3. [Environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) 

The "links" between the [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) parameters and the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are the [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
that are created inside the R session by the [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). These [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are initialized by the [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
when R is started and serve as "directions" for your [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). For an [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), the [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
include several [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) IDs created by the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) in the [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Among them are:

```bash
## The current task ID
$SGE_TASK_ID

## The first task ID or <start_id>
$SGE_TASK_FIRST

## The last task ID or <end_id>
$SGE_TASK_LAST

## The increment or <step_size>
$SGE_TASK_STEPSIZE
```

***Note***: Any of these variables may be retrieved by R and imported in to the current session using the `Sys.getenv()`
function in R. One issue is that these variables will be of the `"character"` class by default and will need
to be re-cast if you plan to use their numeric value. 

#### Example: 
```bash
## The current task ID (character)
taskId_chr <- Sys.getenv("SGE_TASK_ID")

## The current task ID (numeric)
taskId_num <- as.numeric(Sys.getenv("SGE_TASK_ID"))
```

## 4. Jobs to [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) using the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) 

The provided [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) offer a number of ways to stratify a [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into a set of [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). You are
certainly free to experiment with different stratigies to find the one that is most intuitive for you.
My personal preference is to simplify the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) as much as possible and to rely only on the `$SGE_TASK_ID`
and `$SGE_TASK_LAST` [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) while doing the majority of the actual stratification using R. Here I provide an example [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) that demonstrates this approach.

Given that the `-t` parameter always needs to have a `<start_id>` that is a positive integer (such as 1), it can be
difficult to split a [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) in to even chunks as there will always be that pesky `<start_id>` upsetting the balance.
This may require you to make a dummy [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) or to somehow ensure your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) can be split up in to several even [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
and one uneven one.

#### Example: 
Let's say our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) has 360 [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) that we want to split into 10 [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) that will be given 36 processors each; how
would this goal be reflected in the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)? We would need to start at the lowest possible integer, 1, and
work our way up to 360, using steps of size 36. We would prefer to start at 0 and work our way to 360, but unfortunately
0 is not compatable with the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), so we have to include an offset to our `<end_id>` to make up for the fact that
we started at 1 (and not 0), so our `<end_id>` should be 361. Overall, the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) would look like this:

```bash
#$ -t 1-361:36
```

---

Although the above example is relatively simple, a couple of things stand out:
* this setup wastes one processor 
* if the math was slightly more complicated, for example `-t 1:253:18`, it would not
be immediately clear how many [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are specified by the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) with this setup. 

One way to circumvent this problem is to make your `<step_size>` equal to 1, such that the `<end_id>` is equal to the
total number of [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you want to create. This can make your life quite simple as stratifying your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) in to
10 [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) using the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) can now be done by using:

```bash
#$ -t 1-10:1
```

The initial trouble with this approach is that the size of the [tasks](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) no longer corresponds to the number of [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
we have in our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (unless you only need 1 replication per [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)). If you recall, the example above requests 36 processors
for each [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) because we expect that each "chunk" of our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) requires 36 processors to complete the assigned number of [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

On the other hand, if the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is complementary to the simplified `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), there should be
no issue for properly allocating resources.  

## 5. Array stratification in R 

To make the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) "aware" of the `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) settings, we need to make certain that the [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are broken
up into (ideally) even chunks that can then be assigned to each [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). This can
be done by stratifying the [condition list](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and then subsetting the [condition](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) list by the provided [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) ID. 

We can start the process by retrieving the necessary [environmental variables](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and placing them inside objects. The most important ones for this example will be `N_SLOTS`, which is the number of requested processors, and `SGE_TASK_ID`, the ID of the current [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) using the previously-mentioned`Sys.getenv` function. This means that once the [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is running, each [task's](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) R session will have the same value for `nCores` but different values for `taskId`.

***Example:***
```R
## Number of (processors) cores
nCores <- as.numeric(Sys.getenv("N_SLOTS"))

## Current task ID number 
taskId <- as.numeric(Sys.getenv("SGE_TASK_ID"))
```
  
Next, we need to divide our [condition list](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into chunks which will be assigned to each [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). The approach I will detail makes the chunks as a function of the number of processors operationalized by the `nCores` variable. 

We can create a sequence by dividing the number of [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) we have in the [condition list](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) by `nCores`, like so: 

```R
conditionSeq  <- seq(
    from = 1,
    to   = length(conditionList),
    by   = nCores
)
```

***Note***: Larger jobs may increase the complexity of the "chunking" step. Here each chunk is based exactly on the number of requested processors, but you may find yourself having to make each chunk several times larger than the number of processors (i.e., `nCores`*3) to save time. This decision will depend largely on the time-table you have for finishing your job.

Subsequently, `conditionSeq` can be used in conjunction with the pre-defined `taskId` variable to find the correct chunk for the particular [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

***Example:***
```R
## Subset condition list for the current task
useIds <- conditionSeq[taskId]:(nCores*taskId)
useConditions <- conditionList[useIds]
```

Here the `taskId` variable is used to subset the `conditionSeq` vector to find the correct starting index for the current [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). The `taskId` is then multiplied by the `nCores` to get the ending index for the current [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), while the `:` states that we want all indices in between. The chunk of indices is then set to the variable `useIds` and is then used to subset the [condition list](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to select the proper [conditions](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) for the current [task](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

Next, the subsetted `useConditions` list is iterated across using the desired function, as seen below using the function `createSampleMatrix`. 

```R
## Create a list of matrices of standard normal observations
sampleMatList <- mclapply(
    X          = useConditions,
    FUN        = createSampleMatrix,
    mc.cores   = nCores
)
```
***Note:*** As far as the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is concerned, submitting an array job is just the same as submitting any other job (provided your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) contains the venerable `-t` [job parameter](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)), so feel free to use commands like [`qsub`](), [`qdel`]() just as you have been doing before! 


## 6. Wrapping up 

In this guide, I have laid out the basics and given some examples for running array jobs. Overall, array jobs are useful if you have a large [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and need a method that will expedite your run time and help you beat the 48-hour lock-out! 

Some of the ideas I have introduced in this guide may appear obtuse in writing, but I promise that trying these methods will illucidate any confusion you may be left with. I strongly encourage you to practice these skills and in time you will be able to innovate on what you have learned.

***Thank you for reading***, and good luck stratifying! 


