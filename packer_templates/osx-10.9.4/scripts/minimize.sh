# Defragment drive
periodic daily weekly monthly

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove bash history
unset HISTFILE
rm -f /Users/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout root
count=`df --kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;
