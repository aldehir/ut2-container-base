FROM rockylinux:8
WORKDIR /opt/ut2k4

COPY ut2004-dedicated-server-3369.3.tar.gz ./

RUN dnf install -y glibc.i686 libgcc.i686 libstdc++.i686 && \
    tar -xf ut2004-dedicated-server-3369.3.tar.gz --strip-components=1 && \
    rm -f ut2004-dedicated-server-3369.3.tar.gz

COPY UT2004.ini System/UT2004.ini

WORKDIR /opt/ut2k4/System

VOLUME ["/opt/ut2k4/custom"]

EXPOSE "80/tcp"
EXPOSE "7777/udp"
EXPOSE "7778/udp"
EXPOSE "7787/udp"

ENTRYPOINT ["./ucc-bin", "server"]
CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
