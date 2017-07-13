#!/usr/bin/env bash

##########################
# Kenzan LLC Jenkins on Existing GKE
# 
# Can your GCP Service Account do this?
#
# nparks@kenzan.com
##########################
source ./env.sh

### GLOBAL ENV ####
PROJECT_NAME=$(gcloud info --format='value(config.project)')
JENKINS_NS="jenkins"
JENKINS_IMAGE="jenkins-home-image"
JENKINS_DSK="jenkins-home"
JENKINS_IMG_TGZ="https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz"


echo "******************************************"
echo "=========================================="
echo " - Let's Get this Jenkins Thing Together -"
echo "=========================================="

# we should have already obtained credentials
#gcloud container clusters get-credentials $CLUSTER_NAME
kubectl create ns $JENKINS_NS

gcloud config set compute/zone $ZONE
gcloud compute images create $JENKINS_IMAGE --source-uri $JENKINS_IMG_TGZ
gcloud compute disks create $JENKINS_DSK --image $JENKINS_IMAGE

# Okay, time to Steal from Google
git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes
#we need leverage  stuff that is in here
cd continuous-deployment-on-kubernetes


PASSWORD=`openssl rand -base64 15`
echo "==================================="
echo "Your Jenkins password is $PASSWORD"
echo "==================================="
sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options


kubectl create secret generic jenkins --from-file=jenkins/k8s/options --namespace=$JENKINS_NS

echo "Time to be Gangsta"
kubectl apply -f jenkins/k8s/




echo "TLS Time"

### comment out below if you have supplied your own
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $TLS_KEY -out $TLS_CERT -subj "/CN=jenkins/O=jenkins"

kubectl create secret generic tls --from-file=$TLS_CERT --from-file=$TLS_KEY --namespace $JENKINS_NS

kubectl apply -f jenkins/k8s/lb


echo "Pausing  before reporting cluster info"
sleep 10
kubectl cluster-info


#return
cd ../

echo "=========================================="
echo " - Jenkins Thing Together -"
echo "=========================================="
echo "******************************************"



