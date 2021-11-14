#!/bin/bash

UART_GROUP_ID=${UART_GROUP_ID:-20}
if ! grep -q "x:${UART_GROUP_ID}:" /etc/group; then
  groupadd -g "$UART_GROUP_ID" uart
fi
UART_GROUP=$(grep -Po "^\\w+(?=:x:${UART_GROUP_ID}:)" /etc/group)

if [[ -n "$USER_ID" ]]; then
  useradd -m -s /bin/bash -u "$USER_ID" -o -d /home/user user
  usermod -aG sudo user
  usermod -aG "$UART_GROUP" user
  chown user $(tty)
  echo 'source /opt/Xilinx/Vivado/2019.1/settings64.sh' > /home/antsdr/.bash_profile
  echo 'export CROSS_COMPILE=arm-linux-gnueabihf-' >> /home/antsdr/.bash_profile
  echo 'export PATH=$PATH:/opt/Xilinx/SDK/2019.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin' >> /home/antsdr/.bash_profile
  echo 'export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2019.1/settings64.sh' >> /home/antsdr/.bash_profile
  echo 'export PERL_MM_OPT=' >> /home/antsdr/.bash_profile
  echo 'export FORCE_UNSAFE_CONFIGURE=1' >> /home/antsdr/.bash_profile
  chown user:user -R /home/user/
  exec /usr/sbin/gosu user "$@"
else
  echo "Initing env variables"
  export FORCE_UNSAFE_CONFIGURE=1
  export CROSS_COMPILE=arm-linux-gnueabihf- 
  export PATH=$PATH:/opt/Xilinx/SDK/2019.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin 
  export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2019.1/settings64.sh
  export PERL_MM_OPT=
  exec "$@"
fi
