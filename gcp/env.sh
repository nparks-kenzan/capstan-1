


################## GCP / GKE / Jenkins

#### Where are We
ZONE=us-central1-a
OTHER_ZONES=""
#OTHER_ZONES="--additional-zones 'us-central1-b','us-central1-c','us-central1-f'"

#### Expected JenkinsSpinnakerClusterName Cluster Name
CLUSTER_NAME=spinnakerjenkins
HALYARD_K8_ACCOUNT_NAME="$CLUSTER_NAME-gcr"
#There will be a N nodes per zone, if in 4 zones this will result in 4 nodes
NODE_PER_ZONE=3

#cloud storage location
BUCKET_LOCATION=us



##### TLS Paths if you have them enter them here and comment out line in create_jenkins.sh otherwise the files will be created at this locations
TLS_CERT="certificate.crt"
TLS_KEY="privatekey.key"

JENKINSNS="jenkins"
#only used for spinnaker configuration
JENKINS_ADMIN_USER="admin"
JENKINS_SAVED_PW=JenkinsPassword.txt

####### Halyard Spinnaker
ADDRESS=gcr.io
SERVICE_ACCOUNT_NAME=spinnaker-gcr-account
SERVICE_ACCOUNT_DEST=~/.gcp/gcr-account.json
REGISTRY_NAME=ImageRepository

OMIT_NAMESPACES=$JENKINSNS

# we are assuming that glcoud credentials where added properly
KUBECONFIG="~/.kube/config"

#OAUTH2_CLIENT_SECRET=X
#OAUTH2_CLIENT_ID=y

