#!/bin/bash

# Make a folder to store the output and log files
mkdir -p slurm_outputs
mkdir -p slurm_logs


# Arrays in Bash are space delimited
array1=("Goodbye" "Hello")
array2=("Mars" "World")

for i in {0..1}
do
    sbatch example_child_script_with_arguments.sh "${array1[$i]}" "${array2[$i]}"
done