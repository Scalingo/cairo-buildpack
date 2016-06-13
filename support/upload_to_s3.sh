#!/bin/bash

[ -z "$DEBUG" ] && set -x

SCRIPT_DIR=$(dirname ${0:-})
CONFIG_DIR="$(dirname $SCRIPT_DIR)/config"
DIST_DIR="$(dirname $SCRIPT_DIR)/dist"

. $CONFIG_DIR/versions.sh
. $CONFIG_DIR/s3.sh

if [ -z "$AWS_ACCESS_KEY" ] ;then
  echo "AWS_ACCESS_KEY should be defined"
  exit 1
fi

if [ -z "$AWS_SECRET_KEY" ] ; then
  echo "AWS_SECRET_KEY should be defined"
  exit 1
fi

S3CMD="s3cmd --host s3.amazonaws.com --host-bucket %(bucket)s.s3.amazonaws.com --access_key $AWS_ACCESS_KEY --secret_key $AWS_SECRET_KEY"

if [ ! -z "$DEBUG" ] ; then
  S3CMD="$S3CMD --debug"
fi

$S3CMD sync $DIST_DIR/* s3://$S3_BUCKET/ ; rc=$?

if [ $rc -ne 0 ] ; then
  echo "An error occured while syncing bucket"
  exit 2
fi

echo "--------> Upload done"
