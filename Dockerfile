FROM erichough/nfs-server
RUN apk add unzip supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN wget https://downloads.rclone.org/v1.56.0/rclone-v1.56.0-linux-amd64.zip && \
    unzip rclone*.zip && cd rclone* && cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && chmod 755 /usr/bin/rclone
VOLUME ["/config/rclone"]
ENV NFS_EXPORT_0="/                  *(ro,no_subtree_check)"
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
