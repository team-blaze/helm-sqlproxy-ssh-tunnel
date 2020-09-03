#!/bin/ash

while [ ! -f /home/sshuser/.ssh/authorized_keys_temp ]; do echo "Waiting for authorized_keys to be present" && sleep 1; done

# we need to manually copy it into place from a temporary volume mount so we can chown
cp /home/sshuser/.ssh/authorized_keys_temp /home/sshuser/.ssh/authorized_keys
chown sshuser:sshuser /home/sshuser/.ssh/authorized_keys

while [ ! -f /etc/ssh/ssh_host_ecdsa_key ]; do echo "Waiting for host key to be present" && sleep 1; done

# do not detach (-D), log to stderr (-e)
exec /usr/sbin/sshd -D -e
