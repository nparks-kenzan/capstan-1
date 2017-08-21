#!/usr/bin/env bash

##########################
# Kenzan LLC Script Executed by TerraForm on GCP Instance
# 
# Do you have a powerfull enough service account to do this stuff?
# THis is to run from an instance in GCP
#
# nparks@kenzan.com
##########################
###

echo "******************************************"
echo "=========================================="
echo " - Starting CD Environment Creation Process -"
echo "=========================================="

sudo apt-get update

PROJECT_NAME=$(gcloud info --format='value(config.project)')

echo ">>>> Get Kubectl"
### We need to get kubectl instead of having gloud install it for us
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


echo ">>>> Get Halyard"
#### get halyard
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/stable/InstallHalyard.sh
sudo bash InstallHalyard.sh -y

hal -v 

echo ">>>> Get Helm"

curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v2.5.1-linux-amd64.tar.gz
tar -xvf helm-v2.5.1-linux-amd64.tar.gz 
chmod +x linux-amd64/helm
mv linux-amd64/helm /usr/local/bin/helm



echo ">>>> Get git"
### get git
sudo apt-get install git -y

#### We need expect also
#sudo apt-get install expect -y

echo ">>>> Get Lame Docker"
#### this is not a version you would want to use but it will get the job done
sudo apt-get install -y docker.io

echo $PWD
echo "=========================================="
echo " - Configuration Set-up Complete -"
echo "=========================================="
echo "******************************************"