
############################################# Tools instance

TOOLS_SERVICE_ACCOUNT_NAME=super-halyard

############################################# GCP / GKE 

ZONE=us-central1-a
#FIXME do not use other zones yet
OTHER_ZONES=""
#### Expected JenkinsSpinnakerClusterName Cluster Name
CLUSTER_NAME=cdci-container-runtime
HALYARD_K8_ACCOUNT_NAME="$CLUSTER_NAME-gkegcr"
#There will be a N nodes per zone, if in 4 zones this will result in 4 nodes
NODE_PER_ZONE=3
#cloud storage location
BUCKET_LOCATION=us

############################################### Jenkins

##### TLS Paths if you have them enter them here and comment out line in create_jenkins.sh otherwise the files will be created at this locations
TLS_CERT="certificate.crt"
TLS_KEY="privatekey.key"
JENKINSNS="jenkins"
#only used for spinnaker configuration
JENKINS_ADMIN_USER="admin"
JENKINS_SAVED_PW=JenkinsPassword.txt
JENKINS_SAVED_IP=JenkinsIP.txt

############################################ Halyard Spinnaker
ADDRESS=gcr.io
SERVICE_ACCOUNT_NAME=spinnaker-gcr-account
SERVICE_ACCOUNT_DEST=~/.gcp/gcr-account.json
REGISTRY_NAME=imagerepository
SPINNAKER_VERSION="1.1.0"

DOCKER_HUB_NAME="dockerhubimagerepository"
DOCKER_REPO="netflixoss/eureka/ netflixoss/zuul"
DOCKER_ADDR="index.docker.io"

OMIT_NAMESPACES=$JENKINSNS
# we are assuming that glcoud credentials where added properly
KUBECONFIG=".kube/config"

