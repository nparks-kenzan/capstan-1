#!/usr/bin/env bash

######################
# Provide Subscription for Spinnaker
######################
source $PWD/env.sh


echo "=========================================="
echo " - Configure Google Pub Sub for Spinnaker -"
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


hal config pubsub google subscription add $PUBSUB_NAME \
    --subscription-name $SUBSCRIPTION \
    --json-path $SERVICE_ACCOUNT_JSON \
    --project $PROJECT_NAME \
    --message-format $MESSAGE_FORMAT


echo " - Google Pub Sub config Complete -"
echo "=========================================="


