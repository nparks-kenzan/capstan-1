#!/usr/bin/env bash

######################
# Provide Subscription and Artifacts for Spinnaker
######################
source $PWD/env.sh


echo "=========================================="
echo " - Configure Google Pub Sub And GCS Artifacts for Spinnaker -"
echo "=========================================="

PROJECT_NAME=$1
SUBSCRIPTION=$2
PUBSUB_NAME=$3

echo "Project      : $PROJECT_NAME "
echo "SUBSCRIPTION : $SUBSCRIPTION "
echo "TOPIC        : $PUBSUB_NAME "
echo "=========================================="


MESSAGE_FORMAT=GCR
SERVICE_ACCOUNT_JSON=$SERVICE_ACCOUNT_DEST

hal config pubsub google enable

hal config pubsub google subscription add $PUBSUB_NAME \
    --subscription-name $SUBSCRIPTION \
    --json-path $SERVICE_ACCOUNT_JSON \
    --project $PROJECT_NAME \
    --message-format $MESSAGE_FORMAT

hal config features edit --artifacts true

hal config artifact gcs account add "$PROJECT_NAME-artifacts" --json-path $SERVICE_ACCOUNT_JSON

hal config artifact gcs enable


echo " - Google Pub Sub GCS Artifacts config Complete -"
echo "=========================================="


