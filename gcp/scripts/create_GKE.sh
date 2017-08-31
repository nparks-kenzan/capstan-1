#!/usr/bin/env bash

##########################
# Kenzan LLC Create GKE for SpinnakerJenkins
# 
## Can your GCP Service Account do this?
#
# nparks@kenzan.com
##########################
###
source $PWD/env.sh


echo "******************************************"
echo "=========================================="
echo " - Let's Get this GKE Thing Together -"
echo "=========================================="

PROJECT_NAME=$(gcloud info --format='value(config.project)')
gcloud config set compute/zone $ZONE

# enable commands

echo ">>>>> Enable gcloud API needs"

gcloud service-management enable iam.googleapis.com
gcloud service-management enable cloudresourcemanager.googleapis.com
gcloud service-management enable container.googleapis.com


# Create the Actual GKE cluster
echo ">>>>> Create Cluster"
gcloud container --project $PROJECT_NAME clusters create $CLUSTER_NAME --zone $ZONE --username="admin" --cluster-version "1.7.3" --machine-type "n1-standard-2" --image-type "COS" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/cloud-platform","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/source.read_write","https://www.googleapis.com/auth/projecthosting,storage-rw" --num-nodes $NODE_PER_ZONE --network "default" --enable-cloud-logging --enable-cloud-monitoring $OTHER_ZONES --enable-legacy-authorization


#make kubectl happy for later usage
gcloud config set container/use_client_certificate true
gcloud container clusters get-credentials $CLUSTER_NAME

kubectl cluster-info 
echo ">>>>> Helm Init"
helm init

## this is where we need to do a watch command to see what the status of the cluster is
sleep 10
echo "=========================================="
echo " - GKE Thing Together -"
echo "=========================================="
echo "******************************************"