# Start a notebook server in G2


Before beginning this, make sure that you have the "remote-explorer" extension installed in VSCode.

1. Connect to the g2-login node using SSH
    `ssh -L 8022:duchin-compute-01.cs.cornell.edu:22 NETID@g2-login.coecis.cornell.edu`
2. Start an interactive job (example below)
    `srun --pty --partition=duchin-interactive --mem=8G --time=08:00:00 bash`
3. Leave this terminal open and don't touch it
4. Open VSCode and open the "remote explorer" tab
5. Click on the +icon when VSCode asks for a ssh-login username, enter `NETID@localhost -p 8022`.
   VSCode will then take care of all of the connecting for you.


