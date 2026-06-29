FROM ubuntu:26.04

RUN apt update && \
    apt install -y --no-install-recommends \
      dnsmasq \
    && \
    apt clean && \
    rm -fr /var/cache/apt

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/dnsmasq","-d"]
