# GCP - GKE

This Folder contains the scripts and the terraform needed to create a Continuous Delivery with Continuous Integration environment featuring  Spinnaker and Jenkins both running in GKE. This is about delivering container based apps, if you want to muck around with GCE go [elsewhere](https://github.com/GoogleCloudPlatform/spinnaker-deploymentmanager).  

If you have no idea how to even use GCP I would recommend a [coursera course](https://www.coursera.org/learn/gcp-infrastructure-foundation)

## Let's Get Started

You need to validate your GCP project and make sure terraform can do what it needs to do. Before we validate, make sure you have git installed, gcloud sdk installed, and terraform installed. All of these items need to be in your path.

### Validate your GCP project

To make sure we don't stumble into problems later, you need to perform the following:
1. Create a [Service accoun](https://cloud.google.com/compute/docs/access/create-enable-service-accounts-for-instances) with  'role/owner' for Terraform. Maybe call it `terraform-admin`
1. Create a micro instance in `us-central1-a` with the service account `terraform-admin`
1. from your laptop perform a `gcloud ssh` into said instance
   1. This is to check connectivity between your laptop to GCP in a manner similar to what terraform will ultimately do.
1. Run the [script](./scripts/api_test.sh) on that instance that will do some api calls this process will execute
 
If everything happened without issue then we are good. You no longer need this test instance. You can delete it. We will use the service account with terraform.

### Set-up Terraform

If you were able to perform the final ssh option with gcloud you inadvertently performed most of the prep to enable terraform to work on your Google Project.

#### Configure Terraform GCP Credentials
Terraform needs credentials to perform administrator level operations. To do this you need to download a json credentials file. 

**Procedure**
1. Log into the Google  Console and select the project.
1. The API Manager view should be selected, click on "Credentials" on the left, then "Create credentials", and finally "Service account key".
1. Select "[service account you created for testing purposes]" in the "Service account" dropdown, and select "JSON" as the key type.
1. Clicking "Create" will download your credentials.
1. Move/rename the json file to `gcp-account.json` and place in the folder with the other terraform scripts

#### Configure Terraform SSH

Since, you were successful with `glcoud ssh` there is already a ssh configuration information located in `/home/[username]/.ssh/google_compute_engine`. Terraform will expect them to be there. 

### You are ready to begin
The last value to change is called `gcp_project_id` located in [here](./terraform/terraform.tfvars). This is the project we have been using. You can optionally remove the entire variable and have terraform as you for it at the command line. 

FINALLY....

At this point, you need to change directory into the terraform folder and  type:

`terraform plan`

it will prompt you for the ssh username and will then show you the actions that it is going to attempt. If you agree with the plan...

`terraform apply` and enter the ssh user name again. 

Now, wait 30 minutes. 

## Validate your new Toys

In all that Terraform Madness, there was this line...maybe 15 minutes into the process:

`
google_compute_instance.halyardtunnel (remote-exec): ==========================================
google_compute_instance.halyardtunnel (remote-exec):  - Jenkins with UlbqnUcu81QH2p53bAen at 35.186.217.52 -
google_compute_instance.halyardtunnel (remote-exec): ==========================================
`


So that represents the Jenkins master running in your GKE cluster. The password is auto-generated for each deployment. If you poked around in the GCP console in networking you will see this IP associated with some text that references *Jenkins* in some way. 

So **check #1.** Make sure you can log into Jenkins

If that works that means GKE is working and Jenkins is deployed.

Next

Using your work station you will create an SSH tunnel to your 'halyard-tunnel' GCP instance you created

`
gcloud compute --project "[PROJECT_NAME]" ssh --zone "[THE ZONE YOU DEPLOYED TOO]" "[halyard-tunnel or whatever]"  --ssh-flag="-L 9000:localhost:9000" --ssh-flag="-L 8084:localhost:8084"
`


Once there you will then perform `halyard deploy connect`

If this works, navigating to `http://localhost:9000/` should give you the spinnaker interface. 

So that would be **check #2**

Done!

