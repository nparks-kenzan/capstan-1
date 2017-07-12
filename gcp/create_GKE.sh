######


###
source env.sh


# Create the Actual GKE cluster

gcloud container --project $PROJECT_NAME clusters create $CLUSTER_NAME --zone $ZONE --username="admin" --cluster-version "1.6.4" --machine-type "n1-standard-1" --image-type "COS" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_write","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/cloud-platform","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append","https://www.googleapis.com/auth/source.read_write","https://www.googleapis.com/auth/projecthosting,storage-rw" --num-nodes $NODE_PER_ZONE --network "default" --enable-cloud-logging --no-enable-cloud-monitoring --additional-zones $OTHER_ZONES --enable-legacy-authorization


#make kubectl happy for later usage
gcloud container clusters get-credentials $CLUSTER_NAME