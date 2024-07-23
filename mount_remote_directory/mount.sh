#!/bin/bash
if [ $# -ne 1 ]; then
  (>&2 echo "ERROR: Please provide a fuse mount config file")
  exit 1
fi
if [ ! -e $1 ]; then
  (>&2 echo "ERROR: File does not exist: $1")
  exit 1
fi
set -e
source $1

PORT=22
if [ "x$REMOTEPORT" != "x" ]; then
  PORT=$REMOTEPORT
fi

set -u
FULLMOUNT=$MOUNTBASE/$MOUNTNAME

set +e
mkdir -p $FULLMOUNT
umount -f $FULLMOUNT >& /dev/null
set -e
sshfs -p $PORT -oauto_cache,cache=no,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,defer_permissions,follow_symlinks -o volname=$MOUNTNAME $MUSER@$REMOTE:$REMOTELOC $FULLMOUNT
echo "Mounted at: $FULLMOUNT
