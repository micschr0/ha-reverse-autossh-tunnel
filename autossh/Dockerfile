ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ENV LANG=C.UTF-8

# hadolint ignore=DL3018
RUN apk add --no-cache \
    autossh \
    curl \
    openssh-client \
    tzdata

COPY rootfs/ /

RUN chmod 755 \
    /etc/services.d/autossh/run \
    /etc/services.d/autossh/finish \
    /usr/lib/autossh/validate.sh \
    /usr/lib/autossh/keygen.sh \
    /usr/lib/autossh/tunnel.sh
