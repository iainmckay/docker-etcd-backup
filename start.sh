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

if ["$MODE" == "restore"]; then
    aws s3 cp s3://$S3_BUCKET/$S3_OBJECT /tmp/dump.json

    if [ $? != 0]; then
        >&2 echo "There was a problem fetching the backup from S3"
        exit $?
    fi
fi

etcd-dump -h $ETCD_IP -p $ETCD_PORT -f /tmp/dump.json $MODE

if [ $? != 0]; then
    exit $?
fi

if ["$MODE" == "backup"]; then
    aws s3 cp /tmp/dump.json s3://$S3_BUCKET/$S3_OBJECT

    if [ $? != 0]; then
        exit $?
    fi
fi

exit 0
