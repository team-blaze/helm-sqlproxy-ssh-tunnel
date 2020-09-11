#!/bin/ash

while [ ! -f /root/reverse_tunnel_ed25519 ]; do echo "Waiting for private key to be present" && sleep 1; done

echo "[INFO] Using $(autossh -V)"
echo "[INFO] Tunneling $SSH_LOGIN with port binding $PORT_BINDING"

exec autossh -M 0 -N -t -R $PORT_BINDING $SSH_LOGIN -g -i /root/reverse_tunnel_ed25519 -o ServerAliveInterval=10 -o ServerAliveCountMax=1 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=accept-new