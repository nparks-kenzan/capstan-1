# GCP - GKE

This Folder contains the scripts and the terraform needed to create a Continious Delivery with Continious Integration environment featuring both Spinnaker and Jenkins both running in GKE

## What Am I getting into?



If you have an afternoon to burn I would recommend auditing a coursea course


## Before you begin

You need to validate your GCP project. Validation of your GCP project makes sure that your project is in a state to be used by Terraform and by the automation the 'tools' instance will create

### Validate your Set-up




## You are ready to begin



## Validate your new Toys

In all that Terraform Madness, there was this line...maybe 15 minutes into the process:

`
google_compute_instance.halyardtunnel (remote-exec): ==========================================
google_compute_instance.halyardtunnel (remote-exec):  - Jenkins with UlbqnUcu81QH2p53bAen at 35.186.217.52 -
google_compute_instance.halyardtunnel (remote-exec): ==========================================
`
So that represents the Jenkins master running in your GKE cluster. The password is auto-generated for each deployment. If you poked around in the GCP console in networking you will see this IP associated with some text that references *jenkins* in some way. 

So **check #1.** Make sure you can log into Jenkins

If that works that means GKE is working and Jenkins is deployed.

Next

Using your work station you will create an SSH tunnel to your 'halyard-tunnel' GCP instance you created

`
gcloud compute --project "[PROJECT_NAME]" ssh --zone "[THE ZONE YOU DEPLOYED TOO]" "[halyard-tunnel or whatever]"  --ssh-flag="-L 9000:localhost:9000" --ssh-flag="-L 8084:localhost:8084"
`
Once there you will then perform `halyard deploy connect`

If this works, navigating to `http://localhost:9000/` should give you the spinnacker interface. 

So that would be **check #2**

Done!

