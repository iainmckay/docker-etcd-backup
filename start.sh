#!/bin/bash

MODE=

if [ "$1" == "backup" ]; then
	MODE='dump'
elif [ "$1" == "restore" ]; then
	MODE='restore'
else
	>&2 echo "You must provide either backup or restore to run this container"
	exit 64
fi

etcd-dump -h $ETCD_IP -p $ETCD_PORT -f /tmp/dump.json $MODE

if [ $? = 0 ]; then
	aws s3 cp /tmp/dump.json s3://$S3_BUCKET/$S3_OBJECT
fi