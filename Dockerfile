FROM erichough/nfs-server
RUN apk add unzip supervisor fuse
COPY supervisord.conf /etc/supervisord.conf
RUN wget https://downloads.rclone.org/v1.56.0/rclone-v1.56.0-linux-amd64.zip && \
    unzip rclone*.zip && cd rclone* && cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && chmod 755 /usr/bin/rclone && rm -R /rclone*
RUN mkdir -p /mnt/remote && apk del unzip
VOLUME ["/rclone/config", "/rclone/cache"]
ENV NFS_EXPORT_0="/mnt/remote/                 *(rw,sync,no_subtree_check,crossmnt,fsid=0)"
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
