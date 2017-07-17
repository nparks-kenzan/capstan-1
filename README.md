# CAPSTAN
Tools for creating Spinnaker demo environments

![Capstan Image](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Star_of_India_capstan_1.JPG/320px-Star_of_India_capstan_1.JPG)




## Amazon Web Services

see 


## Google Cloud Platform

This Demo environment creates a CD environment where Spinnaker and Jenkins are running within a GKE cluster.

The process is illustrated as follows:
![GCP Process](gcp_process.png)


Essentially, from your workstation you are using TerraForm to create a service account and to launch and instance that will run a script landed by terraform to perform the creation of the GKE platform, jenkins, and Spinnaker. Future versions will also use *declarative pipelines*

### Prerequisites

1. Do you have a computer (Mac Preferred)
1. Do you have Terraform Installed?
1. Do you have Git installed?
1. Do you have a Kenzan Issued GCP project for this?

That's it


### Procedure

1. git clone this repo (fork your own first)
1. cd to the GCP folder
1. Execute ` something with terraform`
1. Go to the bathroom / lunch / another meeting
1. Hope for the best

--

1. To check that is successfully deployed:
1. Access the Google Cloud Shell







