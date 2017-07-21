#!/usr/bin/env bash

##########################
# Kenzan LLC -> Jenkins on Existing GKE
# 
# Can your GCP Service Account do this?
# Did you create the GKE environment first?
#
# nparks@kenzan.com
##########################
source ./env.sh

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

# Okay, time to Steal from Google
git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes
#we need leverage  stuff that is in here
cd continuous-deployment-on-kubernetes


PASSWORD=`openssl rand -base64 15`
echo "==============================================================="
echo "Your Jenkins password is $PASSWORD"
echo "It is also located in $JENKINS_SAVED_PW when process completes"
echo "=============================================================="
sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options


kubectl create secret generic jenkins --from-file=jenkins/k8s/options --namespace=$JENKINS_NS

echo "**********======= Time to be Gangsta ========***************"
kubectl apply -f jenkins/k8s/

echo "========Pausing========="
sleep 60
## we need to do a watch here for 1/1
#watch --interval 20 --no-title "! kubectl get pods $JENKINS_NS --namespace $JENKINS_NS | grep -m 1 \"1/1\""
##until kubectl get pods jenkins --namespace $JENKINS_NS | grep -m 1 "1/1"; do sleep 10 ; done
kubectl get pods --namespace $JENKINS_NS


echo "============TLS Time=============="

### comment out below if you have supplied your own
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $TLS_KEY -out $TLS_CERT -subj "/CN=jenkins/O=jenkins"

kubectl create secret generic tls --from-file=$TLS_CERT --from-file=$TLS_KEY --namespace $JENKINS_NS

#create gap in logs
sleep 5

kubectl apply -f jenkins/k8s/lb

#return
cd ../

echo "=== Waiting for Jenkins Backend Services to report healthy ===="

#watch --interval 20 --no-title "! kubectl describe ingress $JENKINS_NS --namespace $JENKINS_NS | grep -m 1 \"HEALTHY\""
#until kubectl describe ingress jenkins --namespace $JENKINS_NS | grep  -E "HEALHTY" -m 1; do sleep 10 ; done

kubectl describe ingress jenkins --namespace $JENKINS_NS

JENKINS_ADDRESS=`kubectl get ingress jenkins  --namespace $JENKINS_NS | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`

echo JENKINS_ADDRESS > $JENKINS_IP
echo  $PASSWORD > $JENKINS_SAVED_PW

echo "=========================================="
echo " - Jenkins with $PASSWORD at $JENKINS_ADDRESS -"
echo "=========================================="
echo "******************************************"



