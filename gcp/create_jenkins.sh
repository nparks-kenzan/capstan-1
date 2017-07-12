

###
source env.sh

###
PROJECT_NAME=$(gcloud info --format='value(config.project)')


JENKINS_NS="jenkins"
JENKINS_IMAGE="jenkins-home-image"
JENKINS_DSK="jenkins-home"
JENKINS_IMG_TGZ="https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz"

######### Let's Begin
gcloud config set compute/zone $ZONE

gcloud compute images create $JENKINS_IMAGE --source-uri $JENKINS_IMG_TGZ
gcloud compute disks create $JENKINS_DSK --image $JENKINS_IMAGE


# we should have already obtained credentials
#gcloud container clusters get-credentials $CLUSTER_NAME
kubectl create ns $JENKINS_NS


# Okay, time to Steal from Google

git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes

#we need leverage  stuff that is in here
cd continuous-deployment-on-kubernetes

PASSWORD=`openssl rand -base64 15`
echo "Your Jenkins password is $PASSWORD"
sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options


kubectl create secret generic jenkins --from-file=jenkins/k8s/options --namespace=$JENKINS_NS

echo "Time to be Gangsta"
kubectl apply -f jenkins/k8s/


echo "Pausing"
sleep 20
kubectl cluster-info


