#!/bin/sh
# Usage ./start build|run|start|stop|clean
# For Mac M1, testing ARM container : Install https://docs.docker.com/docker-for-mac/apple-silicon/
# set -x
DocFile="Dockerfile"
OSType="CentOS 8 aarch64"
Packages="Open-SSH-Server"
Login="centos:xxxxx"
ImageTag="centos8_sshd"

Build() {   echo "Building\n"; docker build  --target $ImageTag  --tag $ImageTag . ; }
Run()   {   echo "Runing\n";    }
Start() {   echo "Starting\n" ; Start4Cs;  }
Stop()  {   echo "Stoping\n" ;  if [[ -n $(docker ps -a -q) ]] ; then  docker stop $(docker ps -a | grep -i $ImageTag | awk '{print $1}') ; fi ; }
Clean() {   echo "Clean\n";     docker rm $(docker ps -a -f status=exited -q) ; }
Start4Cs(){ for i in {1..4}; do docker run -dit --rm --name CentOS_SSHD${i} -p 221${i}:22 $ImageTag ; done ;  }
OpenCS(){   open 'https://devhints.io/bash#conditionals' ; }
ReadFile(){ while read LINE ; do echo $LINE ; done < ${DocFile} ; }
ContainerInfo(){
  ReadFile
  echo "\n=======================
  Launched 4 Containers: \n$(docker ps) \n
  OS Type   : ${OSType}
  Packages  : ${Packages}
  Login Info: ${Login}
  To SSH use: ssh -p 2211-4 centos@0.0.0.0 \n" ; 
}
ReadWholeFile(){ Lines=$(<Dockerfile) ; echo "\n${Lines}\n" ; }
LogLocation(){
  echo "\nURL Info: https://www.freecodecamp.org/news/where-are-docker-images-stored-docker-container-paths-explained/
  Ubuntu: /var/lib/docker/
  Fedora: /var/lib/docker/
  Debian: /var/lib/docker/
  Windows: C:\ProgramData\DockerDesktop
  MacOS: ~/Library/Containers/com.docker.docker/Data/vms/0/
  "
}
#Main ======================
case "$1" in
  build )   Build ;;
  run )     Run ;;
  start)    Build ; Start4Cs ; ContainerInfo ;;
  stop )    Stop ;;
  clean)    Clean ;;
  info)     clear ; ContainerInfo ;;
  show)     clear ; ReadWholeFile ;;
  location) clear ; LogLocation ;;
  cs|CS)    OpenCS ;;
  *)        echo "Usage: $0 [build|start|stop|clean|info|location]" ;;
esac
