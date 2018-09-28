FROM oraclelinux:7.5

RUN yum-config-manager --enable ol7_developer_EPEL \
    && \
    yum install -y unzip make gcc libffi-devel openssl-devel sshpass \
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
    curl -L https://bootstrap.pypa.io/get-pip.py -o /get-pip.py \
    && \
    python /get-pip.py \
    && \
    rm -f /get-pip.py \
    && \
    pip install ansible==2.5.5 netaddr \
    && \
    rm -rf ~/.cache/pip/ \
    && \
    rm -rf /usr/lib/python2.7/site-packages/pip-* /usr/bin/pip* /usr/lib/python2.7/site-packages/pip/ \
    && \
    rm -rf /usr/lib/python2.7/site-packages/wheel/ \
    && \
    rm -rf /usr/lib/python2.7/site-packages/setuptools/ \
    && \
    yum remove -y unzip make gcc openssl-devel \
    && \
    yum clean all \
    && \
    rm -rf /var/cache/yum/*

ENTRYPOINT ["/tini", "--", "/packer"]
