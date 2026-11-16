FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    RESOLUTION=1600x900x24

RUN apt-get update && apt-get install -y --no-install-recommends \
      openjdk-8-jre \
      xvfb x11vnc fluxbox \
      novnc websockify \
      libxtst6 libxrender1 libxi6 libxrandr2 libgtk2.0-0 \
      fontconfig fonts-dejavu-core \
      ca-certificates procps \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html


RUN JS=/etc/java-8-openjdk/security/java.security && \
    printf '\njdk.tls.disabledAlgorithms=SSLv3, RC4, DES, MD5withRSA, DH keySize < 512\n' >> $JS && \
    printf 'jdk.certpath.disabledAlgorithms=MD2, RSA keySize < 512\n' >> $JS && \
    printf 'jdk.jar.disabledAlgorithms=MD2, RSA keySize < 512\n' >> $JS

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /opt/ipmiview
EXPOSE 6080
CMD ["/usr/local/bin/start.sh"]