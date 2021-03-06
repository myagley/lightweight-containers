# Experiments with Lightweight Containers

This repo tries to piece together runc, img, and cni to create a lightweight container runtime.

This assumes that [runc](https://github.com/opencontainers/runc/releases),
[img](https://github.com/genuinetools/img/releases),
[cnitool](https://github.com/containernetworking/cni/releases),
and the [cni plugins](https://github.com/containernetworking/plugins/releases)
are installed in `/usr/local/bin`.

## Try it out
```
# Get the rootfs for nginx
cd nginx
img pull nginx:1.15.1
img unpack nginx:1.15.1

# Create the container
runc create nginx
runc start nginx

# Test that it works
curl `hostname`:8080 -v

```
