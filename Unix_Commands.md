# Unix Commands

This file contains some basic information about some basic Unix commands. You will need these
to interact effectively with the cluster.

---

## Navigation

For a fuller breakdown of the folder structure on the HPC, see the file
named "HPC_folder_structure.md".

### Directories

- `~`  - This is a shorthand for your home folder located at `/home/<NETID>`
- `.`  - The directory `.` is the current directory that you are in.
- `..` - The directory `..` is the directory directly above the one that you are in. So if you are
       at the location `/home/my_username`, then `.` is the directory named "my_username" and 
       `..` is the directory named "home".

### The `cd` command

`cd` is short for "change directory" and it is used to change from your current directory
to a new one. Here are some basic usages

```bash
cd ..                     # move one level up
cd ~                      # go to your home folder
cd /full/path/from/root   # jump directly to an absolute path
cd subdir                 # move into a subdirectory of the current directory
````

---

## Moving files

There are three core commands for moving and deleting files and directories:

### Copy (`cp`)

```bash
cp source_file.txt     destination_file.txt # Copy a source file to  the destination
cp file1.txt file2.txt /path/to/dir/        # Copy a list of files into a directory
cp -r mydir/ backup/                        # Copy a directory and its contents recursively
```

Many Unix commands come with some extra flags that you can use to specify particular behaviour.
The `-r` in the above `cp` command is an example of such a flag. Here are a couple of other
ones and their meanings for the `cp` command:

* `-r` or `-R` — recursive (for directories)
* `-i` — interactive; prompts before overwrite
* `-v` — verbose; shows files as they’re copied

### Move / Rename (`mv`)

```bash
mv oldname.txt newname.txt           # This will rename the file
mv file.txt /some/other/directory/   # This will move file.txt to the given directory
```


### Remove (`rm`)

```bash
rm file.txt           # Remove a file
rm -i file.txt        # Remove but confirm before deleting
rm -r old_directory/  # Remove a directory and recursively remove inner files
rm -f file.txt        # Remove with force (no prompts)
```

---

## Listing files

### `ls`

```bash
ls                     # list files in current directory
ls -l                  # long format: permissions, owner, size, date
ls -a                  # include hidden files (those beginning with .)
ls -lh                 # human-readable sizes
ls -R                  # recursive directory listing
```

---

## Viewing file contents

These are really useful for looking at SLURM log files if you don't want to
hook in your editor.

* **`cat`** — dump whole file to screen
* **`head`** — show first lines: `head -n 20 file.txt`
* **`tail`** — show last lines: `tail -n 20 file.txt`
* **`tail -f`** — follow additions to a growing log file

---

## File permissions & ownership

You will not have to interact with this too much, but if you would like to test some of your
SLURM script files, you will need to add "execute (-x)" permissions to the file.

### Viewing permissions

```bash
ls -l
# e.g. -rwxr-x--- 1 user group  4096 Jun 21 12:34 script.sh
```

* First char: file (`-`), directory (`d`), link (`l`)
* Next nine: owner (rwx), group (rwx), others (rwx)

### Changing permissions

```bash
chmod +x script.sh      # Enable execution of the script
```

---

## Other handy commands

* **`pwd`** — print working directory
* **`whoami`** — show your username
* **`mkdir newdir`** — create a directory
* **`rmdir dir`** — remove an empty directory

---

Keep this cheat sheet nearby as you get comfortable with the cluster environment. Happy computing!


