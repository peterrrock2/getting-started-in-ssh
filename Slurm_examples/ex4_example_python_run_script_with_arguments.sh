#!/bin/bash
#SBATCH --mem=1G  # Request 1 GB of memory
#SBATCH --time=00:05:00  # Request 5 minutes of runtime
#SBATCH --job-name=child_process_with_arguments # Set the job name to "child_process_with_arguments"
#SBATCH --output=slurm_outputs/ex4_python_arguments_slurm_output_%j.out # The %j will be replaced with the SLURM job ID
#SBATCH --error=slurm_logs/ex4_python_arguments_slurm_error_%j.log # The %j will be replaced with the SLURM job ID


command=$0 # Get the name of the command being executed currently
arg1=$1 # Get the first argument passed to the script
arg2=$2 # Get the second argument passed to the script


# Print the job name and ID to the output stream
echo "Job Name: $SLURM_JOB_NAME" 
echo "Job ID: $SLURM_JOB_ID"

# Print the job name and ID to the output stream 
echo "Job Name: $SLURM_JOB_NAME" >$2
echo "Job ID: $SLURM_JOB_ID" >$2

echo "Current command: $command"

python ex4_cli_example.py --arg1="$arg1" --arg2="$arg2"