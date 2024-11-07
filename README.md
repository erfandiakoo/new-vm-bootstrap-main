The script creates a logical volume (storage) on the second disk (/dev/sdb) and formats it with ext4 filesystem.
It then mounts the volume to a directory called /bigdata.
The script updates /etc/fstab to ensure the volume is automatically mounted at boot time.
Swap is disabled (comment out the line if applicable).
The script expands the root disk size (adjust commands and partitioning as needed).
The script updates system packages using apt.


```sh
ssh-keygen -t rsa -b 4096 -C "LABEL"
```