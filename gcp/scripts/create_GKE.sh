#!/usr/bin/env bash

##########################
# Kenzan LLC Create GKE for SpinnakerJenkins
#
## Can your GCP Service Account do this?
#
# nparks@kenzan.com
##########################
###

PROJECT_NAME=$1
CLUSTER_NAME=$2
CLUSTER_ZONE=$3

echo "******************************************"
echo "=========================================="
echo " - Let's Get this GKE Thing Together -"
echo "=========================================="
echo "  CLUSTER_NAME: $CLUSTER_NAME"
echo "  CLUSTER_ZONE: $CLUSTER_ZONE"

# enable commands
echo ">>>>> Enable gcloud API needs"

# These will be moved to terraform once a release with PR happens:
# https://github.com/terraform-providers/terraform-provider-google/pull/965
gcloud service-management enable iam.googleapis.com
gcloud service-management enable cloudresourcemanager.googleapis.com
gcloud service-management enable container.googleapis.com

#make kubectl happy for later usage
gcloud config set container/use_client_certificate true
gcloud container clusters get-credentials --zone $CLUSTER_ZONE $CLUSTER_NAME

kubectl cluster-info
echo ">>>>> Helm Init"
helm init

## this is where we need to do a watch command to see what the status of the cluster is
sleep 10
echo "=========================================="
echo " - GKE Thing Together -"
echo "=========================================="
echo "******************************************"
