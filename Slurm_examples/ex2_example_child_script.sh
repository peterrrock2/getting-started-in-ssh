#!/bin/bash
#SBATCH --mem=1G  # Request 1 GB of memory
#SBATCH --time=00:05:00  # Request 5 minutes of runtime
#SBATCH --job-name=child_process # Set the job name to "child_process"
#SBATCH --output=ex2_single_subscript_slurm_output.out  # Redirect output to a file
#SBATCH --error=ex2_single_subscript_slurm_error.log  # Redirect error messages to a file

echo "Hello from the child script!"
