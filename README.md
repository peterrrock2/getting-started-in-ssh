# Getting Started in SSH

This is a document that I put together to help some of our 2025 summer
interns get up and running on the high-performance-cluster that
we will be using throughout the summer.

In this repo, I have includes several cheat-sheets that should make the transition
to the HPC smoother for everyone.

## Unix_Commands.md

The HPC runs on Linux (specifically the distro Ubuntu), and, since many people have little
to no experience working within a terminal, it is probably a decent idea to have
a sheet to remind you of all of the relevant commands.

## Transferring_files.md

This file contains all of the relevant commands for transferring files to and from the HPC.
You can do this either using the terminal, or by using a GUI-based file-transfer program
like FileZilla.

## Slurm.md

The HPC that we will be working with uses a scheduling system known as SLURM (Simple
Linux Utility for Resource Management). The TL;DR is that SLURM takes care of allocating
all of the CPUs on the cluster so that we can make use of them efficiently without stomping
on toes. However, using SLURM well takes a long time, so I have included a basic guide for
some of the most common things that I need to do when working with the HPC.

## Slurm_examples

This is a folder containing some small examples of the sorts of things that I commonly need to
do when making a batch call to run a bunch of jobs on the cluster.

## SSH_on_Windows.md

This contains some basic instructions for getting up onto the cluster for those that are using
a Windows machine. Fortunately for us, Microsoft seems to have made this a lot easier
than it used to be, so we are going to use the newest set of best-practices as laid out
in the documentation 

## SSH_on_Mac_and_Linux.md

This contains the basic instructions for getting up and running with SSH on Unix-based systems
(Mac and Linux)

## Linking_VSCode_to_G2.md

This file contains instructions for how to set up Visual Studio Code to work with the HPC.
Specifically, it contains instructions on the steps that you need to take to enable
the appropriate port forwarding to hook into an interactive session on the HPC so that you
can edit files directly on the HPC from your local machine as opposed to using VIM or 
editing locally and having to upload.
