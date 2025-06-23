# Connecting to a Remote Server via SSH on Windows (2025)

The HPC that we are looking to connect to is behind a VPN, so before we can even connect to it,
we need to make sure that we have the Cisco AnyConnect VPN client installed. Here is the
appropriate link with installation instructions:
[https://it.cornell.edu/cuvpn](https://it.cornell.edu/cuvpn)

If we are using WiFi on campus, this step is not necessary.


For reference, there are some additional instructions for using SSH on Windows here:

(https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2025)[https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2025]


---

## 1. Make sure that the OpenSSH Client is installed

To do this, just make sure that the following command returns something when you run it in a
PowerShell window:

```powershell
Get-Service ssh-agent
```

If this returns an error, you need to install the OpenSSH Client by searching for "Optional
Features" in the Windows search bar, clicking on "Add a feature", searching for
"OpenSSH Client", and clicking "Install". Then check the installation again by opening a new
PowerShell window and running the command above again.

---

## 2. Check for an existing SSH key

This will probably return nothing, but it is good to check first. Open PowerShell and run:

```powershell
dir $HOME\.ssh\id_*.pub
````

* If you see `id_ed25519.pub` or `id_rsa.pub`, you already have a public key.
* Otherwise, proceed to generate one.

---

## 3. Generate a new SSH key (if needed)

```powershell
ssh-keygen -t ed25519 -C "your.email@domain.com"
```

* **Type**: `ed25519` is recommended.
* **Comment** (`-C`): helps identify the key.
* **Save location**: accept the default (`C:\Users\<you>\.ssh\id_ed25519`) and enter a passphrase.

This creates:

* `C:\Users\<you>\.ssh\id_ed25519` → your private key
* `C:\Users\<you>\.ssh\id_ed25519.pub` → your public key

---

## 4. Enable & use the SSH agent

Start and auto-load the Windows OpenSSH agent so your key is cached:

```powershell
# 1) Ensure the agent is running
Get-Service ssh-agent

# 2) Start it now (if it isn’t already running)
Start-Service ssh-agent

# 3) Add your key to the agent
ssh-add $HOME\.ssh\id_ed25519
```

You’ll be prompted for your passphrase once; after that it stays in memory.


If you would like to avoid restarting the ssh-agent service every time you reboot your computer,
you can set its startup type to Automatic by running the following command in an elevated
PowerShell instance (Run as Administrator):

```powershell
Set-Service ssh-agent -StartupType Automatic
```

---

## 5. Create a friendly SSH config

Edit (or create) `C:\Users\<you>\.ssh\config` with Notepad (or VS Code):

```ssh-config
Host hpc
    HostName g2-login.coecis.cornell.edu
    User NETID
    RequestTTY yes
    ForwardX11 yes
    ForwardX11Trusted yes
```

---

## 6. Connect!

Open a new PowerShell window and run:

```powershell
ssh hpc
```

* **First time**: you’ll see `Are you sure you want to continue connecting (yes/no)?` → type **yes**.
* Then you’ll either get your passphrase prompt (once) or be dropped straight into the remote shell (if agent is unlocked).

