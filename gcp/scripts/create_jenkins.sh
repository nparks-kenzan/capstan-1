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

### GLOBAL ENV ####
PROJECT_NAME=$(gcloud info --format='value(config.project)')
JENKINS_NS=$JENKINSNS
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

echo "======= Creating Jenkins Dsk ========"
gcloud compute images create $JENKINS_IMAGE --source-uri $JENKINS_IMG_TGZ
gcloud compute disks create $JENKINS_DSK --image $JENKINS_IMAGE

HOME_DIR=$PWD
# Okay, time to Steal from Google
git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes
#we need leverage  stuff that is in here
cd $PWD/continuous-deployment-on-kubernetes


PASSWORD=`openssl rand -base64 15`
echo "==============================================================="
echo "Your Jenkins password is $PASSWORD"
echo "It is also located in $JENKINS_SAVED_PW when process completes"
echo "=============================================================="
sed -i.bak s#CHANGE_ME#$PASSWORD# $PWD/jenkins/k8s/options


kubectl create secret generic jenkins --from-file=$PWD/jenkins/k8s/options --namespace=$JENKINS_NS
sleep 10
echo "**********======= Time to be Gangsta ========***************"
kubectl apply -f $PWD/jenkins/k8s/

echo "========Waiting for Happy Pods========="
sleep 60
until kubectl get pods --namespace $JENKINS_NS | grep -m 1 "1/1"; do sleep 10 ; done
kubectl get pods --namespace $JENKINS_NS


echo "============TLS Time=============="

### comment out below if you have supplied your own
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $PWD/$TLS_KEY -out $PWD/$TLS_CERT -subj "/CN=jenkins/O=jenkins"

kubectl create secret generic tls --from-file=$PWD/$TLS_CERT --from-file=$PWD/$TLS_KEY --namespace $JENKINS_NS

#create gap in logs
sleep 10

kubectl apply -f $PWD/jenkins/k8s/lb

#return
cd $HOME_DIR

echo "=== Waiting for Jenkins Backend Services to report healthy ===="
until kubectl describe ingress jenkins --namespace $JENKINS_NS | grep "HEALTHY"; do sleep 10; done
kubectl describe ingress jenkins --namespace $JENKINS_NS

JENKINS_ADDRESS=`kubectl get ingress jenkins  --namespace $JENKINS_NS | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`

echo $JENKINS_ADDRESS > $PWD/$JENKINS_SAVED_IP
echo  $PASSWORD > $PWD/$JENKINS_SAVED_PW

echo "=========================================="
echo " - Jenkins with $PASSWORD at $JENKINS_ADDRESS -"
echo "=========================================="
echo "******************************************"



