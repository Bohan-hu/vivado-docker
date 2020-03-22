# Inherit from the default container, which have all the needed script to launch tasks
# CentOS mirror
FROM    registry.cn-hangzhou.aliyuncs.com/hubohan/inginious_c_default

# Set the environment name for tasks to let the grader detect it
LABEL   org.inginious.grading.name="verilog-vivado-tcl"

MAINTAINER hubohan <hubohancser@gmail.com>

# Build with: 
# docker build --build-arg VIVADO_VERSION=2018.3 --build-arg VIVADO_SRC_DICT=Xilinx_Vivado_SDK_2018.3_1207_2324 -t vivado:2018.3 .

# install the dependency
# require x11
ARG VIVADO_VERSION
ARG VIVADO_SRC_DICT
RUN sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \	
         -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \	
         -i.bak \	
         /etc/yum.repos.d/CentOS-Base.repo && yum makecache && yum -y install xorg-x11-xauth wqy-zenhei-fonts* 

RUN mkdir /install_vivado
COPY install_config.txt /
# COPY INSTALLATION FILES
COPY ${VIVADO_SRC_DICT} /install_vivado/

# run the install
RUN /install_vivado/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config /install_config.txt 
# do the cleanup
RUN rm -rf /${VIVADO_SRC_DICT} /install_config.txt /install_vivado
# add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> ~/.bashrc

