# SLURM Examples

This folder contains some example scripts that can help you with running some beginning SLURM jobs
on the cluster. Fundamentally, there is not a whole lot to these scripts, but they should
be heavily commented to help you understand what is going on. 


## Quick Info

Each of the file sin this folder ending in `.sh` known as a "bash script". These are scripts
that you are able to run from the command line on the cluster. On the first line of the script
file, you will see the following line:

```bash
#!/bin/bash
```

This is a special line that tells your terminal that it needs to run this file using the bash
shell. Without this line, your terminal will try to run the file using the default shell, which
can lead some undefined behavior. For now, just know that you need to have this line in
any script that you would like to run on the cluster.

In addition to the `#!/bin/bash` line, there are a number of other lines that you can add
to your script file. These lines are called "SLURM directives" and they are used to tell
SLURM what resources you would like to allocate for your job. Here is a small table
of the commands that you are most likely to use:

| Directive                       | Description                         |
| ------------------------------- | ----------------------------------- |
| `#SBATCH --job-name=NAME`       | Name of the job (useful for sacct)  |
| `#SBATCH --output=filename.out` | Standard output file                |
| `#SBATCH --error=filename.err`  | Standard error file                 |
| `#SBATCH --partition=PARTITION` | Specify the partition or queue      |
| `#SBATCH --time=D-HH:MM:SS`     | Maximum runtime (wall time)         |
| `#SBATCH --nodes=N`             | Number of nodes (just use 1 for now)|
| `#SBATCH --ntasks=NTASKS`       | Total number of tasks (processes)   |
| `#SBATCH --ntasks-per-node=N`   | Number of tasks per node            |
| `#SBATCH --cpus-per-task=N`     | Number of CPUs per task             |
| `#SBATCH --mem=SIZE`            | Memory per node (e.g., `4G`, `16G`) |
| `#SBATCH --mail-user=USER`      | Email address for job status        |
| `#SBATCH --requeue`             | Requeue the job if it is preempted  |


### Some small quirks of Bash to be aware of

Bash is a bit of a weird programming language compared to other things that you are likely to have
seen, so here are a list of small quirks of the language that you should be aware of:

**There can be no spaces when assigning variables**

```bash
my_variable="Hello" # This is fine
my_variable = "Hello" # This is NOT fine
```

**The `$` symbol is used to access the value of a variable**

```bash
my_variable=Hello
echo $my_variable
```

This will print the value of the variable `my_variable` to the screen.


**Variable names with underscores need to be wrapped in {} when accessing them in strings**

```bash
my_variable=Hello
echo "The value of my_variable is ${my_variable}"
```

**Arrays are denoted with round brackets**

```bash
array1=("Hello" "World")
```

**Accessing values in an array requires both {} brackets and [] brackets**

```bash
array1=("Hello" "World")
echo "The value of array1[0] is ${array1[0]}"
echo ${array1[1]}
```

**Looping over indices is inclusive**

```bash
for i in {0..2}
do
    echo $i
done
```
This will print the following to the screen:

```console
0
1
2    
```

**Looping over arrays is really weird**

```bash
array1=("Hello" "World")
for i in "${array1[@]}" # Note the @ symbol
do
    echo $i
done
```

This will print the following to the screen:

```console
Hello
World
```


### Preparing a Script file for execution

To run a script on the cluster (or on your local machine for that matter), you need to 
tell the computer that the file is executable. The long and the short of it is that if you were
to make a file called "my_script.sh" in your current directory, you would need to run the
following command to make it executable:

```bash
chmod +x my_script.sh
```

Otherwise, when you try to run it, you will see something like

```console
permission denied: ./my_script.sh
```

You technically don't need to do this if you are invoking the script using the `sbatch` command
like this:

```bash
sbatch my_script.sh
```

but it is good practice to do so anyway.


### Output and Error files

In all likelihood, this has not come up for most people unfamiliar with the terminal, but whenever
you print to the terminal, there are actually two different ways that a piece of text can
be classified: as a "standard output" or as an "error". Bits of text with either of these 
classifications tend to appear in the same place you are running something like a python script, 
but when running a bash script, you can actually separate pieces of text with each classification
into different files. These output categories are known as **streams** and print statements can 
be redirected to different streams using the `>` operator. 

In bash, the command to print to the standard output stream is `echo`, but if we wanted to redirect
this output to a file, we would use the `>` operator like this:

```bash
echo "Hello from the Slurm job script!" > ex1_simple_slurm_output.out
```

This will create a BLANK file called `ex1_simple_slurm_output.out` and write the text 
"Hello from the Slurm job script!" to the file. If we did not want to overwrite the contents
of the file, we could use the `>>` operator instead:

```bash
echo "Hello from the Slurm job script!" >> ex1_simple_slurm_output.out
echo "Hello again from the Slurm job script!" >> ex1_simple_slurm_output.out
```

If, however, we wanted to redirect the output to the standard error stream, we would do the 
following:

```bash
echo "I will be printed to the standard error stream!" >&2
```

Here the `&2` is a special character that stands for the standard error stream. However, if we run
this in our terminal, it will be a bit hard to see the difference between the two streams since
they are both printed to the same place, so to make this distinction clearer and to put all
of these ideas together, we have the "ex1_simple_slurm.sh" script that you can run on the cluster.


## `ex1_simple_slurm.sh`

This is a very simple script that will run on the cluster and should create two files:

* `ex1_simple_slurm_output.out`
* `ex1_simple_slurm_error.log`

The first file will contain the output from the job, and the second will contain any error messages.
You will see in the file that there are two lines of commands:

```bash
echo "Hello from the Slurm job script!" # This will appear in the output file
echo "This is an error appearing in the slurm job script!" >&2 # This will appear in the error file
``` 

So, after running the script via

```bash
sbatch ex1_simple_slurm.sh
```

you should see "Hello from the Slurm job script!" in the file `ex1_simple_slurm_output.out` and
"This is an error appearing in the slurm job script!" in the file `ex1_simple_slurm_error.log`.


## `ex2_running_subscripts.sh`

Like the previous script, this script is pretty simple. In all likelihood, when you are running
things on the cluster, you will want to run a bunch of jobs all at once. Generally, the best
way to do this is to create a script that will then generate a bunch of jobs for you. This script
just creates a single job that will print to the "single_sub_slurm_output.out" file.

You should execute this file using

```bash
./ex2_running_subscripts.sh
```

## `ex3_running_subscripts_with_arguments.sh`

In the previous script, we just created a single job that ran on the cluster, but in the real
world, we will probably want to run a bunch of jobs with different arguments. This can
actually be done by passing the arguments as parameters to the child script. The child 
script can then access these parameters using the special vairable names `$1`, `$2`, etc.

Here is an example bash script that takes in two arguments and then prints them to the screen:

```bash
#!/bin/bash

arg1=$1
arg2=$2

echo "Argument 1: $arg1"
echo "Argument 2: $arg2"
```

This script can be run on the command line like this:

```bash
./ex3_example_argument_script.sh "Hello" "World"
```

This will print the following to the screen:

```console
Argument 1: Hello
Argument 2: World
```

Okay, so we can now make a list of arguments to pass to our child script, and we do that in
the `ex3_running_subscripts_with_arguments.sh` file. Feel free to dig into these files and see 
what happens when you execute the following command:

```console
./ex3_running_subscripts_with_arguments.sh
```

## `ex4_running_subscripts_with_python_clis.sh`

Okay, so the previous script allowed us to call a bash subscript from within a bash script,
but we like to use python, so how to we modify the above approach to use our perferred
programming language? Well, we just need to build a simple Command Line Interface (CLI) for
our python script. We will do this by using the `click` python package since its interface
is pretty self-explanatory.

Here is all the code that we need to make a simple python CLI:

```python
import click

@click.command()
@click.argument('--arg1')
@click.argument('--arg2')
def main(arg1, arg2):
    print(f"Python Argument 1: {arg1}")
    print(f"Python Argument 2: {arg2}")
    print("ERROR: This is a simulated error.", file=sys.stderr)
    
if __name__ == '__main__':
    main()
```

The `@click.command()` decorator is used to tell the python interpreter that this is a CLI
and that it should be run when the file is executed. We can then use this CLI from the terminal
like this:

```console
python ex4_cli_example.py --arg1='Hello' --arg2='World'
```


This will print the following to the screen:

```console
Python Argument 1: Hello
Python Argument 2: World
```

The `--arg1` and `--arg2` flags are used to pass the arguments to the python script just like
how keyword arguments are passed to a python function.


When it comes to batching things with SLURM, not a whole lot changes from what we did in
the previous example as you can see if you dig through the files. To watch everything in action,
you can run the following command:

```console
./ex4_running_subscripts_with_python_clis.sh
```