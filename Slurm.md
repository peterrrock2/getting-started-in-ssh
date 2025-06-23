# Slurm

There is a lot of things that you can do with SLURM. However, for the most part,
you all will mainly be interested in three commands.

## `sbatch`

The `sbatch` command is the command that you are likely to use the most when working with
the cluster. This is the command that you will use to discharge jobs to particular nodes
in the cluster, and most of the time, you will be doing this using something like 

```console
sbatch my_script.sh
```

The `sbatch` command also comes with a number of flags that you can specify either inside of the
bash script file (like the "my_script.sh" file given above) or you can specify them
from the command line. Here are some of the ones that I use most often

```console

  -J, --job-name=jobname      name of job

  -c, --cpus-per-task=ncpus   number of cpus required per task (allows for multiprocessing)

  -p, --partition=partition   partition requested (rarely used)

  -t, --time=minutes          time limit # Can also be formatted days-HH:MM:SS
      --mem=MB                minimum amount of real memory


      --mail-user=user        who to send email notification for job state

  -e, --error=err             file for batch script's standard error
  -o, --output=out            file for batch script's standard output

      --wrap[=command string] wrap command string in a sh script and submit
```

So an example call to `sbatch` might look like this:

```console
sbatch --job-name=my_job --cups-per-task=4 -time=01:00:00 --mem=2G my_script.sh
```

If you wanted to specify the above options in the script file instead of on the command line,
you would put the following lines at the top of your script file:

```bash
#!/bin/bash

# Note there are NO SPACES between the `#` and the `SBATCH` below
# THIS IS VERY IMPORTANT!!! If you add a space, SLURM will think that the line is
# a comment and not a SLURM directive and will thus not apply the options appropriately.

#SBATCH --job-name=my_job
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mem=2G

# This will add the output and error files. These can be really useful for debugging
#SBATCH --output=my_job.out
#SBATCH --error=my_job.err



# The rest of the script goes here
```

## `sacct`

The `sacct` command is used to get information about a job that has been run. Mainly, this
command is used to get information about the job's exit status, which is useful for debugging
and for benchmarking the resources that you need for later jobs. The basic syntax for this
command is:

```console
(mggg) 22:39:46 ❯ sacct -j 8068729

JobID           JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
8068729      1M_NYS_pr+     duchin     duchin          4  COMPLETED      0:0
8068729.bat+      batch                duchin          4  COMPLETED      0:0
8068729.ext+     extern                duchin          4  COMPLETED      0:0
```

(Ignore the `(mggg) 22:39:46 ❯` part, that is just my terminal prompt). A more useful
version of this command is probably something like this:


```console
(mggg) 22:57:35 ❯ sacct --format=JobID,JobName,Partition,AllocCPUS,AllocTRES,State,MAXRSS,ExitCode,Elapsed -j 8068729

JobID           JobName  Partition  AllocCPUS  AllocTRES      State     MaxRSS ExitCode    Elapsed
------------ ---------- ---------- ---------- ---------- ---------- ---------- -------- ----------
8068729      1M_NYS_pr+     duchin          4 billing=4+  COMPLETED                 0:0   08:31:55
8068729.bat+      batch                     4 cpu=4,mem+  COMPLETED   1727032K      0:0   08:31:55
8068729.ext+     extern                     4 billing=4+  COMPLETED       580K      0:0   08:31:55
```

The `--format` flag allows you to specify which fields you want to see in the output. In the
above example, I have specified the following fields:

- `JobID`: The ID of the job
- `JobName`: The name of the job
- `Partition`: The partition that the job was run on
- `AllocCPUS`: The number of CPUs allocated to the job
- `AllocTRES`: The resources allocated to the job (e.g., memory)
- `State`: The state of the job (e.g., COMPLETED, FAILED, etc.)
- `MAXRSS`: The maximum resident set size of the job (i.e., the maximum amount of memory used by the job)
- `ExitCode`: The exit code of the job (0 means success)
- `Elapsed`: The elapsed time of the job (i.e., how long the job ran for)


## `squeue`

The `squeue` command is used to get information about the jobs that are currently in the queue.
You can call the command with no arguments to see all of the jobs in the queue, but that will
probably not be very useful to you. Instead, you can use the `-u` flag to see only the jobs that
a particular user has in the queue:

```console
squeue -u <NETID>
```

This will give you a bunch of information, but the formatting is not the best. Here is another
option that will give you longer job names and formats the output a bit better:

```console
squeue -o "%8i %10P %30j %8T %10M %5D %R" -u <NETID>
```


