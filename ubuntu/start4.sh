#!/bin/sh
# Usage: ./start build|start|run|stop|clean
# Author: Andrew L

ContName="ubuntu20_sshd"
ContIP="0.0.0.0"
HostPort=2201
OSType="Ubuntu20.4:aarch64"
Packages="Open-SSH-Server"
DescTest="Tested on Mac M1"
Login=$(grep -i chpass Dockerfile | awk '{print $3}')
DocFile="Dockerfile"
SSHinfo="ssh -p 2201-4 ubuntu@0.0.0.0"

Build() {   echo "Building\n";  docker build --tag ${ContName} . ;  }
Start() {   echo "Starting\n";  for i in {1..4}; do docker start ${ContName}${i} ; done ; }
Run()   {   echo "Runing\n";    Build ; sleep 3 ; Start4Cs; }
Stop()  {   echo "Stoping\n" ;  if [[ -n $(docker ps -a -q) ]] ; then  docker stop $(docker ps -a -q) ; fi ; }
Clean() {   echo "Clean\n";     docker rm $(docker ps -a -f status=exited -q) ; }
Start4Cs(){ for i in {1..4}; do docker run -dit --rm --name ${ContName}${i} -p 220${i}:22 ${ContName} ; done ;  }
OpenCS(){   open 'https://devhints.io/bash#conditionals' ; }
ReadFile(){ while read LINE ; do echo $LINE ; done < ${DocFile} ; }
ContainerInfo(){
  ReadFile
  echo "\n=======================
  Launched 4 Containers: \n$(docker ps) \n
  OS Type   : ${OSType}
  Packages  : ${Packages}
  Desc Test : ${DescTest}
  Login Info: ${Login}
  To SSH use: ${SSHinfo} \n" ; 
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
URLs(){ echo "\nImage Build: https://www.edureka.co/community/71282/how-to-enable-ssh-inside-docker-container \n" ; }

#Main ======================
case "$1" in
  build )   Build ;;
  run )     Run ;;
  start)    Start4Cs ; ContainerInfo ;;
  stop )    Stop ;;
  clean)    Clean ;;
  info)     clear ; ContainerInfo ;;
  show)     clear ; ReadWholeFile ;;
  location) clear ; LogLocation ;;
  cs|CS)    OpenCS ;;
  *)        echo "Usage: $0 [build|start|stop|clean|info|location]" ;;
esac
