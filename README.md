# Table of Contents
[[_TOC_]]

# Automatic Install
**NOTE**: Check [Operating System Statuses](#operating-systems-auto-installation) first!

This script will back up any files it intends to replace to a directory named `dot-files-backup-TIMESTAMP`.

Requirements for this script to run:
- Perms
    - sudo access
    - root
- Packages:
    - gcc
        - Used for rust cargo installations
    - git
        - Used to clone the dot files repository
    - curl
        - Used to install various packages such as oh my zsh
```bash
curl "https://gitlab.orion-technologies.io/philler/dot-files/-/raw/Development/install.bash" | bash
```
# Manual
```bash
git clone "https://gitlab.orion-technologies.io/philler/dot-files.git" ph-dot-files && cd ph-dot-files
```
From here copy the files you'd like to have to your home directory ||${HOME}||. Recommend taking the ~/.config/
content first. Ensure you make backups 🙂.

# Operating Systems Auto Installation

Below is the status of various operating systems when the installation script is run on them. 
If the OS is not below then it has not been tested to work with the installation script.

## Verified
The following operating systems are verified to work with the installation script:
- CentOS 8
- CentOS 8 Stream

## Broken
Currently the installation script is confirmed to **break** the following installations:
- macOS

<sub>When it is stated *break*, it really means ***break***. Had to restore macOS from a backup... faster than
resolving all the soft link and pathing errors it caused.</sub>
