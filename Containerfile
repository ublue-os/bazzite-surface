# Base Image
ARG BASE_IMAGE_NAME=bazzite
ARG BASE_IMAGE_TAG=testing

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Build Image
FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

# linux-surface lags behind Fedora itself
ARG SURFACE_RELEASEVER=43

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
