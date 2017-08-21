#!/usr/bin/env bash

##########################
# Kenzan LLC -> Jenkins on Existing GKE
# 
# Can your GCP Service Account do this?
# Did you create the GKE environment first?
#
# nparks@kenzan.com
##########################
source $PWD/env.sh



echo "******************************************"
echo "=========================================="
echo " - Let's Get this Jenkins Thing Together -"
echo "=========================================="



helm install stable/jenkins --name $JENKINS_HELM_RELEASENAME --namespace $JENKINSNS --values $PWD/jenkins_helm.yml --replace --wait




echo "=========================================="
echo " - Jenkins with $PASSWORD at $JENKINS_ADDRESS -"
echo "=========================================="
echo "******************************************"



