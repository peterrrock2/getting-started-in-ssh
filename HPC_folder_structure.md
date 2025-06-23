# HPC Folder Structure

This file contains information about the basic structure of the
folders that you will be using on the HPC.

First of all, your personal directory is located at `/home/<NETID>`.
These folders exist, but are very small (maximum capacity of 30G) as
they are only intended to contain your profile settings files (DOT files).

The real location that you will want to keep the majority of your files
will be in the lab's shared folder located at `/share/duchin/lab_shared`.
Here is a high-level view of what the basic file structure for the HPC
looks like:

```console
share
└── duchin
    ├── backup
    ├── gurobi
    ├── lab_shared
    │   └── user_scrap
    ├── other_files
    └── personal_dirs
        └── peter
```

You may make your own personal directory in the "personal_dirs" folder. However, should anything
go wrong, this folder will not be backed up. The main folder to use for most summer work will be
the "lab_shared" folder. All work inside of here will be backed-up every few days, including the
"user_scrap" folder. The general recommendation is that you have a folder for your particular
project, and then if you have some things that you would like to test, then do that in the
"user_scrap" folder.
