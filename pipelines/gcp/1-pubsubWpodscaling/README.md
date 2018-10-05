# Google Pub Sub with AutoScaling

This pipeline demonstrates

1. Google Cloud Builder
1. Google Pub Sub Trigger from Google Container Registry that Triggers a Spinnaker Pipeline Deployment
1. Kubernetes Pod AutoScaling 

## Setup Procedure

### Configure Cloud Build

### Deploy Pipeline

### Configure Trigger


## Run Pipeline

To execute this pipeline you need to perform one of the following
1. Add a new commit to the repo
1. Manually Start a Build with Cloud Builder

Regardless of the method choosen, once a new container image appears in the local GCR repository a Google PubSub event that Spinnaker subscribes to will be generated. As described in pipeline configuration earlier this will result in the pipeline being triggered and a code deployment.


## Test Horizantal Pod Scaling

Now that we have something deployed, let's trigger pod autoscaling. This pipeline configures a deployment to allow for auto-scaling for the deployed app. 

IF you already have load generation capability point it to the load balancer and watch kubernetes respond. If you do not have that capability you can [hey](https://github.com/rakyll/hey).

