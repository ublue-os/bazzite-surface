#!/bin/bash

set -ouex pipefail

### Surface Linux Repository
dnf5 config-manager addrepo --from-repofile=https://pkg.surfacelinux.com/fedora/linux-surface.repo
dnf5 config-manager setopt \
    "linux-surface.baseurl=https://pkg.surfacelinux.com/fedora/f${SURFACE_RELEASEVER:?not set in the Containerfile}/" \
    "linux-surface.skip_if_unavailable=0"

### Install Surface Linux Kernel & akmods
## TO-DO

### Install Surface Linux Utilities
dnf5 install -y iptsd
