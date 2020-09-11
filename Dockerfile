FROM alpine
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

RUN apk add --no-cache openssh autossh

COPY entrypoint.sh /