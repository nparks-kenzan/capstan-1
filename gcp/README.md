# GCP - GKE

This Folder contains the scripts and the terraform needed to create a Continuous Delivery with Continuous Integration environment featuring both Spinnaker and Jenkins both running in GKE

## What Am I getting into?



If you have an afternoon to burn I would recommend auditing a course course


## Let's Get Started

You need to validate your GCP project and make sure terraform can do what it needs to do. Before we validate, make sure you have git installed, gcloud sdk installed, and terraform installed. All of these items need to be in your path.

### Validate your GCP project




You no longer need this test instance. You can delete it. 

### Set-up Terraform

If you were able to perform the final ssh option with gcloud you inadvertently performed most of the prep to enable terraform to work on your Google Project.

#### Terraform GCP Credentials
Terraform needs credentials to perform administrator level operations. To do this you need to download a json credentials file. 

**Procedure**
1. Log into the Google  Console and select the project.
1. The API Manager view should be selected, click on "Credentials" on the left, then "Create credentials", and finally "Service account key".
1. Select "[service account you created for testing purposes]" in the "Service account" dropdown, and select "JSON" as the key type.
1. Clicking "Create" will download your credentials.
1. Move/rename the json file to `gcp-account.json` and place in the folder with the other terraform scripts

#### Terraform SSH

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

