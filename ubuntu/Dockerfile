#Usage : docker build -t ssh-ubuntu . 
#    docker run -dit --name ssh-ubuntu -p 2222:22 ssh-ubuntu  #Do not add at the end /bin/bash 
#    ssh -p 2222 ubuntu@laptopip or ssh -p 2222 ubuntu@0.0.0.0 
# Tested work work on M1 ARM, cannot use ubuntu:latest bcz this ARM laptop

FROM ubuntu

RUN apt update && apt install openssh-server sudo -y && apt autoclean

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 u20 
RUN echo 'ubuntu:password' | chpasswd
RUN service ssh start

EXPOSE 22
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D"]
