FROM rockylinux:8

COPY dedicatedserver3369.3-bonuspack.7z /root/

# Install p7zip from EPEL
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm; \
  dnf install -y p7zip;

# Extract ut2k4 server and move to /opt/ut2k4
RUN cd /opt && \
  7za x -bd -y -- /root/dedicatedserver3369.3-bonuspack.7z && \
  mv dedicatedserver3369.3-bonuspack ut2k4 && \
  rm -f /root/*.7z;

# Install UT2k4 dependencies
RUN dnf install -y \
  glibc.i686 \
  libgcc.i686 \
  libstdc++.i686 \
  ;

COPY custom /root/custom
COPY entrypoint.sh /root/

RUN cd /opt/ut2k4 && \
  mkdir -m 775 custom && \
  chmod +x System/ucc-bin && \
  install -m 644 /root/custom/server.ini custom/server.ini && \
  install -m 755 /root/entrypoint.sh entrypoint.sh;

VOLUME ["/opt/ut2k4/custom"]

EXPOSE "7777/udp"
EXPOSE "8080/tcp"

ENTRYPOINT ["/opt/ut2k4/entrypoint.sh"]
