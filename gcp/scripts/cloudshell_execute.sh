#!/usr/bin/env bash

##########################
# Kenzan LLC Script Executed by TerraForm on GCP Instance
# 
# Do you have a powerfull enough service account to do this stuff?
# THis is to run from the google cloud shell
#
# nparks@kenzan.com
##########################
###
source ./env.sh
#


PROJECT_NAME=$(gcloud info --format='value(config.project)')
gcloud config set compute/zone $ZONE

SA_EMAIL=$(gcloud iam service-accounts list --filter="displayName:$TOOLS_SERVICE_ACCOUNT_NAME" --format='value(email)')

gcloud compute --project $PROJECT_NAME instances create "halyard-tools" --zone $ZONE --machine-type "n1-standard-1" --subnet "default" --maintenance-policy "MIGRATE" --service-account $SA_EMAIL --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --image "ubuntu-1404-trusty-v20170703" --image-project "ubuntu-os-cloud" --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name "halyard-tools"



