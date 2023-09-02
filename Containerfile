FROM rockylinux:8

ARG DEDICATED_SERVER_URL=https://cdn.alde.dev/ut2k4/dedicated-server/linux/ut2004-dedicated-server-3369.3.tar.gz

LABEL org.opencontainers.image.created="2023-09-01T12:00:00Z" \
      org.opencontainers.image.authors="Alde Rojas" \
      org.opencontainers.image.url="https://github.com/aldehir/ut2k4-server-container" \
      org.opencontainers.image.title="UT2004 Dedicated Server Container" \
      org.opencontainers.image.description="UT2004 Dedicated Server Container"

WORKDIR /opt/ut2k4

RUN curl -LO "$DEDICATED_SERVER_URL" && \
    dnf install -y glibc.i686 libgcc.i686 libstdc++.i686 && \
    tar -xf ut2004-dedicated-server-3369.3.tar.gz --strip-components=1 && \
    rm -f ut2004-dedicated-server-3369.3.tar.gz

COPY UT2004.ini System/UT2004.ini
COPY --chmod=755 entrypoint entrypoint

VOLUME ["/opt/ut2k4/custom"]

EXPOSE "80/tcp" \
       "7777/udp" \
       "7778/udp" \
       "7787/udp"

ENTRYPOINT ["/opt/ut2k4/entrypoint"]
CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
