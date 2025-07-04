#!/bin/bash
#SBATCH --mem=1G  # Request 1 GB of memory
#SBATCH --time=00:05:00  # Request 5 minutes of runtime
#SBATCH --job-name=example_job  # Set the job name to "example_job"
#SBATCH --output=ex1_simple_slurm_output.out  # Redirect output to a file
#SBATCH --error=ex1_simple_slurm_error.log  # Redirect error messages to a file


# Load any necessary modules or environment variables here
echo "Hello from the Slurm job script!" # This will appear in the output file
echo "This is an error appearing in the slurm job script!" >&2 # This will appear in the error file
# The >&2 redirects the output from the "echo" command to the standard error stream

