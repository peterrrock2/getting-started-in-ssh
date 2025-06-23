# Connecting to a Remote Server via SSH on Mac and Linux

The HPC that we are looking to connect to is behind a VPN, so before we can even connect to it,
we need to make sure that we have the Cisco AnyConnect VPN client installed. Here is the
appropriate link with installation instructions:
[https://it.cornell.edu/cuvpn](https://it.cornell.edu/cuvpn)

If we are using WiFi on campus, this step is not necessary.


---

## 1. Check for an existing key

Open Terminal and run:

```bash
ls ~/.ssh/id_*.pub
````

* If you see files like `id_ed25519.pub` or `id_rsa.pub`, you already have a public key.
* Otherwise, you’ll generate one in the next step.

---

## 2. Generate a new SSH key (if needed)

```bash
ssh-keygen -t ed25519 -C "your.email@domain.com"
```

* **Type:** `ed25519` (modern, compact, secure).
* **Comment** (`-C`): helps identify the key.
* **Accept** the default file location (`~/.ssh/id_ed25519`) and enter a passphrase (recommended).

This creates:

* `~/.ssh/id_ed25519` → your private key
* `~/.ssh/id_ed25519.pub` → your public key

---

## 3. Add your key to the SSH agent

Start (or confirm) the agent is running and load your key:

```bash
# ensure the agent is running
eval "$(ssh-agent -s)"

# add your key
ssh-add ~/.ssh/id_ed25519
```

> On macOS Ventura and later you can use `--apple-use-keychain` to store your passphrase in Keychain.

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

---

## 4. Create a friendly SSH config

Edit (or create) `~/.ssh/config` in your Mac’s home:

```ssh-config
Host hpc
    HostName g2-login.coecis.cornell.edu
    User NETID
    RequestTTY yes
    ForwardX11 yes
    ForwardX11Trusted yes
```

---

## 5. Connect!

```bash
ssh hpc
```

* First time only: you’ll be prompted to trust the server’s fingerprint. Just say "yes".
* After that, you’ll get either your passphrase prompt (once, if Keychain is not used) or be
  dropped straight into the remote shell.

