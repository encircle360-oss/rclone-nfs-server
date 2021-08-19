# Rclone-NFS-Server
This docker image provides you with a small [nfs-server](https://github.com/ehough/docker-nfs-server) that exposes your [rclone](https://rclone.org) remote. You can then access all your rclones remote files via NFS.

## Quickstart
Be aware that nfs-server needs some special privileges to be able to start and also rclone needs privileges to be able to mount within a container.
So you must run the container in privileged mode or provide the correct system capabilites. So be aware to run this container in a secure environment since it has more privileges than normal.

The host needs to have nfs and nfsd kernel modules loaded. You can do this by installing `nfs-common` package and optionally modprobing nfs and nfsd if not done automatically.

On debian based linux distributions this would work like this:

```
sudo apt-get install nfs-common
```


If you just want to use NFSv4 which only needs tcp port `2049` you can run the following. Your rclone.conf file in the directory you mount into the docker container _needs to contain_ a remote with the name `remote`. Only this remote will be mounted and exposed via NFS.

```
[remote] # the name here is important
type = crypt
remote = gdrive:storage/rclone-path
filename_encryption = standard
directory_name_encryption = true
... further settings
```

```
docker run -v /path/to/rclone/confdir:/rclone/config -p 0.0.0.0:2049:2049 --privileged registry.gitlab.com/encircle360-oss/rclone-nfs-server:latest
```

Afterwards just use the NFS client or tool you want to connect to the host you binded. In case of the example it's the host which runs docker (`10.10.10.10`).

```
mkdir -p /mnt/test
sudo mount -t nfs 10.10.10.10:/ /mnt/test
```

## Customization
You can customize many settings in the underlying nfs-server. For example it's also possible to restrict the IP addresses that are allowed to connect via NFS exports or to disable or enable specific NFS versions. In the default the container will spawn both simultaniously, NFSv4 and NFSv3.

You can find all customization options [here](https://github.com/ehough/docker-nfs-server).

## Contribute
Feel free to contribute to this open source project. Just fork, change and create a pull or merge request to this repository.

### Ideas & Improvements
* Make rclone mount configurable
* Multiple rcloune mounts and nfs exports

## Credits
This is open source software by [encircle360](https://encircle360.com). Use on your own risk and for personal use. If you need support or consultancy just contact us.
