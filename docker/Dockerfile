FROM ubuntu:impish

ENV DEBIAN_FRONTEND noninteractive

RUN \
  sed -i -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
  apt update && \
  apt upgrade -y && \
  apt -y --no-install-recommends install \
    ca-certificates curl gosu sudo xorg dbus dbus-x11 ubuntu-gnome-default-settings gtk2-engines \
    ttf-ubuntu-font-family fonts-ubuntu-font-family-console fonts-droid-fallback lxappearance nano && \
  apt-get autoclean && \
  apt-get autoremove && \
  gosu nobody true && \
  rm -rf /var/lib/apt/lists/* && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# vivado webpack
RUN \
  dpkg --add-architecture i386 && \
  apt update && \
  apt -y --no-install-recommends install \
    build-essential git gcc-multilib libc6-dev:i386 ocl-icd-opencl-dev libjpeg62-dev && \
  apt-get autoclean && \
  apt-get autoremove && \
  apt-get -y --no-install-recommends install fakeroot libncurses5-dev libssl-dev ccache dfu-util u-boot-tools device-tree-compiler mtools bc python cpio zip unzip rsync file wget libtinfo5 device-tree-compiler bison flex u-boot-tools && \
  mkdir /opt/Xilinx && \
  chown $USER:$USER /opt/Xilinx && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

COPY setup/config.txt /setup/
COPY setup/Xilinx_Vivado_SDK_2019.1_0524_1430.tar.gz /setup/

RUN \
  cat /setup/Xilinx_Vivado_SDK_2019.1_0524_1430.tar.gz | tar zx --strip-components=1 -C /setup && \
  /setup/xsetup \
    --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA \
    --batch Install \
    --config /setup/config.txt && \
  rm -rf /setup

USER root
COPY setenv.sh /usr/local/bin/setenv.sh
RUN chmod +x /usr/local/bin/setenv.sh
RUN groupadd -g 1000 antsdr
RUN useradd -d /home/antsdr -s /bin/bash -m antsdr -u 1000 -g 1000

USER antsdr
WORKDIR /home/antsdr

ENV DISPLAY :0
ENV GEOMETRY 1920x1200
ENV HOME /home/antsdr 

ENTRYPOINT ["/usr/local/bin/setenv.sh"]
CMD ["/bin/bash", "-l"]
