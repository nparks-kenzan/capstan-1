#!/usr/bin/env bash

##########################
# Kenzan LLC Script to Validate Project settings
# 
# Do you have a powerfull enough service account to do this stuff?
# THis is to run from the google cloud shell
#
# nparks@kenzan.com
##########################
###
#source ./env.sh
#
TOOLS_SERVICE_ACCOUNT_NAME="the display name of the service account you created for terraform"

PROJECT_NAME=$(gcloud info --format='value(config.project)')


SA_EMAIL=$(gcloud iam service-accounts list --filter="displayName:$TOOLS_SERVICE_ACCOUNT_NAME" --format='value(email)')

THROW_AWAY_VAR=$(gcloud projects add-iam-policy-binding $PROJECT_NAME --role roles/storage.admin --member serviceAccount:$SA_EMAIL)



