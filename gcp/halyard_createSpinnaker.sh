#!/usr/bin/env bash

##########################
# Kenzan LLC Create Spinnaker
# 
## Can your GCP Service Account do this?
## Did you create a Jenkins?
#
# nparks@kenzan.com
##########################
###
source ./env.sh


####

echo "******************************************"
echo "=========================================="
echo " - Let's Get this Halyard Thing Together -"
echo "=========================================="

PROJECT=$(gcloud info --format='value(config.project)')


echo "==== -> Let's Get Halyard on this box"

curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh

sudo bash InstallHalyard.sh


hav -v 

echo "==== -> Let's Get a service account created"


gcloud iam service-accounts create  $SERVICE_ACCOUNT_NAME --display-name $SERVICE_ACCOUNT_NAME

SA_EMAIL=$(gcloud iam service-accounts list --filter="displayName:$SERVICE_ACCOUNT_NAME" --format='value(email)')

gcloud projects add-iam-policy-binding $PROJECT --role roles/storage.admin --member serviceAccount:$SA_EMAIL


mkdir -p $(dirname $SERVICE_ACCOUNT_DEST)


gcloud iam service-accounts keys create $SERVICE_ACCOUNT_DEST --iam-account $SA_EMAIL


USERNAME=_json_key
PASSWORD_FILE=$SERVICE_ACCOUNT_DEST


echo "==== -> Let's Get Halyard Configuration Going"

hal config deploy edit --type distributed --account-name $HALYARD_K8_ACCOUNT_NAME


hal config storage gcs edit --project $PROJECT --bucket-location $BUCKET_LOCATION --json-path $SERVICE_ACCOUNT_DEST

hal config storage edit --type gcs


echo "==== -> Let's Get a Docker Registry using gcr.io added"

hal config provider docker-registry account add $REGISTRY_NAME  --address $ADDRESS --repositories $REPOSITORIES --username $USERNAME --password-file $PASSWORD_FILE

hal config provider docker-registry enable


echo "==== -> Let's get K8 on GKE associated using gcr.io added"


hal config provider kubernetes account add $HALYARD_K8_ACCOUNT_NAME --docker-registries $REGISTRY_NAME --omit-namespaces $OMIT_NAMESPACES --kubeconfig-file $KUBECONFIG

hal config provider kubernetes enable

# Let's turn some SSL stuff off at the moment

hal config security api ssl disable

hal config security ui ssl disable

echo "==== -> Remember Jenkins"

JENKINS_PW=`cat $JENKINS_SAVED_PW`

#hal config ci jenkins master add MASTER --address $JENKINS_IP --username $JENKINS_ADMIN_USER --password $JENKINS_PW
#hal config ci jenkins enable

echo "==== -> Let's Diff our Deployment real quick"

hal deploy diff


echo "======= Time to be Gangsta, this will take a while  ========"
sudo hal deploy apply


echo "=========================================="
echo " - Hopefully there is a Spinnaker -"
echo "=========================================="
echo "******************************************"

