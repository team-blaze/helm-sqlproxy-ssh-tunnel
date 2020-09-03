#!/bin/ash

while [ ! -f /etc/ssh/ssh_host_ecdsa_key ]; do echo "Waiting for host key to be present" && sleep 1; done

# do not detach (-D), log to stderr (-e)
exec /usr/sbin/sshd -D -e
