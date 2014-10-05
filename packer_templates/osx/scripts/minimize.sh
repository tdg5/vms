# Remove bash history
unset HISTFILE
rm -f /Users/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do [ -f $f ] && echo -ne '' > $f; done;

# Run periodic maintenance tasks
periodic daily weekly monthly

# Zero free space to aid VM compression
for dir in / /tmp/; do
  file="${dir}whitespace"
  count=$(df -kP "$dir" | tail -n1 | awk -F ' ' '{ print $4 }')
  let count--
  dd if=/dev/zero of=$file bs=1024 count=$count
  rm -f $file
done
