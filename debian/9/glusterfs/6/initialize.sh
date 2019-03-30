#!/bin/bash
function init() {
  index=$1
  echo "mkdir -p /data/glusterserver/data;" > init.sh
  echo "mkdir -p /data/glusterserver/metadata;" >> init.sh
  echo "mkdir -p /data/glusterserver/etc;" >> init.sh
  echo "cp /etc/hosts /data/glusterserver/etc/hosts;" >> init.sh
  echo "echo gluster.core-1.mydomain > /etc/hostname;" >> init.sh
  if [ $index = 1 ]; then
    echo "echo \"127.0.0.1 gluster.core-$index.mydomain\" >> /data/glusterserver/etc/hosts;" >> init.sh
    echo "echo \"$(docker-machine ip myvm2)  gluster.core-2.mydomain\" >> /data/glusterserver/etc/hosts;" >> init.sh
  else
    echo "echo \"127.0.0.1 gluster.core-$index.mydomain\" >> /data/glusterserver/etc/hosts;" >> init.sh
    echo "echo \"$(docker-machine ip myvm1)  gluster.core-2.mydomain\" >> /data/glusterserver/etc/hosts;" >> init.sh
  fi
  init=$(cat init.sh)
  if [ -n "$init" ]; then
    echo "INFO: password is tcuser"
    echo "INFO: execute ssh-copy-id docker@$(docker-machine ip myvm${index})..."
    cmd="scp init.sh docker@$(docker-machine ip myvm${index}):~/"
    echo "INFO: execute: $cmd" && eval $cmd
    cmd="docker-machine ssh myvm${index} \"chmod 755 ~/init.sh\""
    echo "INFO: execute: $cmd" && eval $cmd
    echo "INFO: execute sudo -s and then ./init.sh"
    docker-machine ssh myvm${index}
  else
    echo "ERROR; init is empty"
  fi
}
init 1
init 2
