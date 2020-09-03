FROM alpine
EXPOSE 22
ENTRYPOINT ["/bin/ash","-c"]
CMD ["/entrypoint.sh"]

RUN passwd -d root && \
    adduser -D -s /bin/ash sshuser && \
    passwd -u sshuser && \
    chown -R sshuser:sshuser /home/sshuser

RUN mkdir /home/sshuser/.ssh && \
    chmod 700 /home/sshuser/.ssh

RUN mkdir -p /etc/ssh

RUN apk add --no-cache openssh

COPY entrypoint.sh /