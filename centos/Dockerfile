#Usage : docker build --tag centos8_sshd .
#        docker run -dit --name CentOS_SSHD -p 2211:22 centos8_sshd     #Do not add at the end /bin/bash 
#        ssh -p 2211 centos@laptopip or ssh -p 2211 centos@0.0.0.0 
# Tested work on Mac M1, cannot use ubunu:latest bcz this ARM laptop

FROM centos

RUN yum update -y && yum -y install openssh openssh-server openssh-clients sudo initscripts  && \
    yum -y clean all

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN useradd -rm -d /home/c8 -s /bin/bash -g root -G adm c8
RUN echo 'centos:password' | chpasswd
USER c8
WORKDIR /home/c8

USER root
RUN echo "centos      ALL=/sbin/service, /sbin/chkconfig, /usr/bin/systemctl, /bin/yum, /bin/dnf" >> /etc/sudoers
RUN echo 'centos:password' | chpasswd
RUN mv /run/nologin /run/nologin.bak            # Need Remove this file for no root login
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
