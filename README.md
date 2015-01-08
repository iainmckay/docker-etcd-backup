# etcd-backup

Container that backs up etcd configuration to S3. The container overwrites the same S3 object every time it is run, it is recommended you turn
versioning on to retain access to previous copies.

There is an existing image available on the public registry at `[iainmckay/etcd-backup](https://registry.hub.docker.com/u/iainmckay/etcd-backup/).

## Backing up etcd

To backup etcd you simply run:

    $ docker run -e AWS_ACCESS_KEY_ID="key" -e AWS_SECRET_ACCESS_KEY="secret" -e AWS_DEFAULT_REGION="eu-west-1" iainmckay/etcd-backup backup

## Restoring etcd

To restore an existing backup you simply run:

    $ docker run -e AWS_ACCESS_KEY_ID="key" -e AWS_SECRET_ACCESS_KEY="secret" -e AWS_DEFAULT_REGION="eu-west-1" iainmckay/etcd-backup restore

## Configuration 

The container can be customized with these environment variables:

Name | Default Value | Description
--- | --- | ---
AWS_ACCESS_KEY_ID | `blank` | Your AWS access key with access to the desired bucket
AWS_SECRET_ACCESS_KEY | `blank` | Your AWS secret access key with access to the desired bucket
AWS_DEFAULT_REGION | `blank` | The AWS region your bucket is in
ETCD_IP | 172.17.42.1 | Address your etcd peer is accessible at
ETCD_PORT | 4001 | The port your etcd peer is accessible on
S3_BUCKET | `blank` | The bucket to write the backup to
S3_OBJECT | etcd.json | The object to write
