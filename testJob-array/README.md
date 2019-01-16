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
complexity, or just a large number of replications, your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) may be running for days. Unfortunately,
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
`-t` parameter inside your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). This approach is similar to submitting multiple [jobs]() to the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
except that you will only need one [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)! The "array" is created by virtue of a single [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
being split into several tasks, each with it's on task ID specified by the `-t` parameter. 

The benefit to this is that an [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will allow for a longer [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) run time as each task will have 48
hours to complete, as opposed to 48 hours total for the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) itself. All you will need to do in ensure that
the task IDs are correctly used by your [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to split your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into tasks. Let's take a look at an example
shell script that uses the `-t` parameter:

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

In the shell script above, we can see that the `-t` parameter is specified as the `<start_id>`-`<end_id>`:`<step_size>`
and that each of these fields must contain an integer greater than zero and that the `<end_id>` must be greater than the `<start_id>`,
and the `<step_size>` controls the increments of the split.

This particular `-t` parameter has specified that our
[job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will be divided into 10 tasks of 8 task IDs each. In practice this might mean we want 10 tasks to be assigned 8
processors each (as specified here), or that we want to make a 48\*10 hour window available for our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Whatever the case, R will need
to be linked to the specification of the [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) by using the provided environmental variables as described in the
next section.

## 3. Environmental variables 

The "links" between the shell script parameters and the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are the environmental variables
that are created inside the R session by the [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). These environmental variables are initialized by the [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
when R is started and serve as "directions" for your [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). For an [array job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), the environmental variables
include several task IDs created by the `-t` parameter in the shell script. Among them are:

```
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

## 4. Jobs to tasks using the `-t` parameter 

The provided environmental variables offer a number of ways to stratify a [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) into a set of tasks. You are
certainly free to experiment with different stratigies to find the one that is most intuitive for you.
My personal preference is to simplify the `-t` parameter as much as possible and to rely only on the `$SGE_TASK_ID`
and `$SGE_TASK_LAST` environmental variables while doing the majority of the actual stratification using R. Here I provide an example [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) that demonstrates this approach.

Given that the `-t` parameter always needs to have a `<start_id>` that is a positive integer (such as 1), it can be
difficult to split a [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) in to even chunks as there will always be that pesky `<start_id>` upsetting the balance.
This may require you to make a dummy task or to somehow ensure your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) can be split up in to several even tasks
and one uneven one.

#### Example: 
Let's say our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) has 360 replications that we want to split into 10 tasks that will be given 36 processors each; how
would this goal be reflected in the `-t` parameter? We would need to start at the lowest possible integer, 1, and
work our way up to 360, using steps of size 36. We would prefer to start at 0 and work our way to 360, but unfortunately
0 is not compatable with the `-t` parameter, so we have to include an offset to our `<end_id>` to make up for the fact that
we started at 1 (and not 0), so our `<end_id>` should be 361. Overall, the `-t` parameter would look like this:

```bash
#$ -t 1-361:36
```

---

Although the above example is relatively simple, a couple of things stand out:
* this setup wastes one processor 
* if the math was slightly more complicated, for example `-t 1:253:18`, it would not
be immediately clear how many tasks are specified by the `-t` parameter with this setup. 

One way to circumvent this problem is to make your `<step_size>` equal to 1, such that the `<end_id>` is equal to the
total number of tasks you want to create. This can make your life quite simple as stratifying your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) in to
10 tasks using the `-t` parameter can now be done by using:

```bash
#$ -t 1-10:1
```

The initial trouble with this approach is that the size of the tasks no longer corresponds to the number of replications
we have in our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (unless you only need 1 replication per task). If you recall, the example above requests 36 processors
for each task because we expect that each "chunk" of our [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) requires 36 processors to complete the assigned number of
replications. 

On the other hand, if the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is complementary to the simplified `-t` parameter, there should be
no issue for properly allocating resources.  

## 5. Array stratification in R 

To make the R [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) "aware" of the `-t` parameter settings, we need to make certain that the replications are broken
up into (ideally) even chunks that can then be assigned to each task. This can
be done by stratifying the replication list and then subsetting the replication list by the provided task ID. 
