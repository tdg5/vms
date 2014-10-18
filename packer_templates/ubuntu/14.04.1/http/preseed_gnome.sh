#!/bin/sh

# Hack to install openssh-server on first boot via self destructing init script

touch /target/tmp/preseed_gnome.marker
cat <<\EOF > /target/etc/init.d/first_boot &&
#!/bin/sh
### BEGIN INIT INFO
# Provides:          first_boot
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5 S
# Default-Stop:
# Short-Description: Perform tasks on first boot after installation
# Description:
### END INIT INFO

. /lib/lsb/init-functions

case "$1" in
  start)
    apt-get install openssh-server -y &&
    rm /etc/init.d/first_boot &&
    update-rc.d first_boot remove
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
    ;;
esac
EOF
chmod +x /target/etc/init.d/first_boot &&
chroot /target update-rc.d first_boot defaults
