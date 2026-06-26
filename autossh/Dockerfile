# syntax=docker/dockerfile:1@sha256:87999aa3d42bdc6bea60565083ee17e86d1f3339802f543c0d03998580f9cb89
# check=error=true;skip=InvalidDefaultArgInFrom
ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

LABEL \
    io.hass.type="addon" \
    maintainer="https://github.com/micschr0"

ENV LANG=C.UTF-8

# curl required by validate.sh (Supervisor API health check) and
# keygen.sh (force_keygen reset via Supervisor API).
# hadolint ignore=DL3018
RUN apk add --no-cache \
    autossh \
    curl \
    openssh-client \
    tzdata

COPY --chmod=755 rootfs/etc/services.d/autossh/run /etc/services.d/autossh/run
COPY --chmod=755 rootfs/etc/services.d/autossh/finish /etc/services.d/autossh/finish
COPY --chmod=644 rootfs/usr/lib/autossh/validate.sh /usr/lib/autossh/validate.sh
COPY --chmod=644 rootfs/usr/lib/autossh/keygen.sh /usr/lib/autossh/keygen.sh
COPY --chmod=644 rootfs/usr/lib/autossh/tunnel.sh /usr/lib/autossh/tunnel.sh
