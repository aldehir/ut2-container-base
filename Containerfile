FROM rockylinux:8
WORKDIR /opt/ut2k4

COPY ut2004-dedicated-server-3369.3.tar.gz ./
COPY custom ./custom

RUN dnf install -y glibc.i686 libgcc.i686 libstdc++.i686 && \
    tar -xf ut2004-dedicated-server-3369.3.tar.gz --strip-components=1 && \
    rm -f ut2004-dedicated-server-3369.3.tar.gz

VOLUME ["/opt/ut2k4/custom"]

EXPOSE "7777/udp"
EXPOSE "8080/tcp"

WORKDIR /opt/ut2k4/System
ENTRYPOINT ["./ucc-bin", "server"]
CMD ["DM-Antalus?Game=xGame.xDeathMatch"]
