FROM alpine:3.8

RUN apk add --no-cache --virtual .build curl \
    && \
    apk add --no-cache ansible git \
    && \
    curl -L https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip -o /packer.zip \
    && \
    unzip /packer.zip \
    && \
    rm -f /packer.zip \
    && \
    chmod +x /packer \
    && \
    curl -L https://github.com/krallin/tini/releases/download/v0.18.0/tini-amd64 -o /tini \
    && \
    chmod +x /tini \
    && \
    pip3 install netaddr \
    && \
    rm -rf ~/.cache/pip/ \
    && \
    apk del .build

ENTRYPOINT ["/tini", "--", "/packer"]
