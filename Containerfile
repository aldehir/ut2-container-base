FROM rockylinux:8

ARG DEDICATED_SERVER_URL=https://cdn.alde.dev/ut2k4/dedicated-server/linux/ut2004-dedicated-server-3369.3-2.tar.gz

WORKDIR /opt/ut2004

RUN curl -L -o server.tar.gz "$DEDICATED_SERVER_URL" && \
    dnf install -y glibc.i686 libgcc.i686 libstdc++.i686 && \
    tar -xf server.tar.gz --strip-components=1 && \
    rm -f server.tar.gz

COPY UT2004.ini System/UT2004.ini
COPY --chmod=755 entrypoint entrypoint

VOLUME ["/opt/ut2004/custom"]

EXPOSE "80/tcp" \
       "7777/udp" \
       "7778/udp" \
       "7787/udp"

LABEL org.opencontainers.image.created="2023-09-01T12:00:00Z" \
      org.opencontainers.image.authors="Alde Rojas" \
      org.opencontainers.image.title="UT2004 Dedicated Server" \
      org.opencontainers.image.description="UT2004 Dedicated Server" \
      org.opencontainers.image.source="https://github.com/aldehir/ut2-container-base"

ENTRYPOINT ["/opt/ut2004/entrypoint"]
CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
