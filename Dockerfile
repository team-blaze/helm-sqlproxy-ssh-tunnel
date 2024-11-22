FROM alpine:3.19.4
EXPOSE 22
ENTRYPOINT ["/bin/ash","-c"]
CMD ["/entrypoint.sh"]

RUN passwd -d root && \
    adduser -D -s /bin/ash sshuser && \
    passwd -u sshuser

RUN mkdir /home/sshuser/.ssh && \
    chmod 0700 /home/sshuser/.ssh && \
    chown -R sshuser:sshuser /home/sshuser

RUN mkdir -p /etc/ssh

RUN apk add --no-cache openssh autossh "zlib>1.2.12-r2"

RUN echo -e "\033[32mYou're connected to the sqlproxy-ssh-tunnel! If you have set up port forwarding, you can connect to your database now.\033[0m" > /etc/motd

COPY entrypoint.sh entrypoint-reverse-tunnel.sh /
