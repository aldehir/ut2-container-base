FROM rockylinux:8

LABEL org.opencontainers.image.created="2023-09-01T12:00:00Z" \
      org.opencontainers.image.authors="Alde Rojas" \
      org.opencontainers.image.url="https://github.com/aldehir/ut2k4-server-container" \
      org.opencontainers.image.title="UT2004 Dedicated Server Container" \
      org.opencontainers.image.description="UT2004 Dedicated Server Container"

WORKDIR /opt/ut2k4

COPY ut2004-dedicated-server-3369.3.tar.gz ./

RUN dnf install -y glibc.i686 libgcc.i686 libstdc++.i686 && \
    tar -xf ut2004-dedicated-server-3369.3.tar.gz --strip-components=1 && \
    rm -f ut2004-dedicated-server-3369.3.tar.gz

COPY UT2004.ini System/UT2004.ini

WORKDIR /opt/ut2k4/System

VOLUME ["/opt/ut2k4/custom"]

EXPOSE "80/tcp" \
       "7777/udp" \
       "7778/udp" \
       "7787/udp"

ENTRYPOINT ["./ucc-bin", "server"]
CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
