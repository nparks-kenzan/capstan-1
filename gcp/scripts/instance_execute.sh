#!/usr/bin/env bash

##########################
# Kenzan LLC Script Executed by TerraForm on GCP Instance
# 
# Do you have a powerfull enough service account to do this stuff?
#
# nparks@kenzan.com
##########################
###


echo "******************************************"
echo "=========================================="
echo " - Starting CD Environment Creation Process -"
echo "=========================================="

### We need to get kubectl instead of having gloud install it for us
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl




echo "=========================================="
echo " - Process Complete -"
echo "=========================================="
echo "******************************************"