1. Download Xlinux_Vivado_SDK_2019.1_0524_1430.tar.gz from [here](https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_2019.1_0524_1430.tar.gz) and store it to the setup directory
2. ``sudo docker image build -t ant-build .``
3. ``sudo docker run -e DISPLAY=`hostname`:0 -it --rm -v $PWD:/home/antsdr/work -w /home/antsdr ant-build``
4. ``git clone --recursive https://github.com/MicroPhase/antsdr-fw.git ``
5. ``bash
export CROSS_COMPILE=arm-linux-gnueabihf- 
export PATH=$PATH:/opt/Xilinx/SDK/2019.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin 
export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2019.1/settings64.sh
export PERL_MM_OPT=``
6. ``cd antsdr-fw``
5. ``make``


