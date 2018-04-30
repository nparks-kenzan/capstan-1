# CAPSTAN

![Capstan Image](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Star_of_India_capstan_1.JPG/320px-Star_of_India_capstan_1.JPG)

What is a [Capstan?](https://en.wikipedia.org/wiki/Capstan_(nautical))?
Packaging of open source for creating Containerized CICD Environments.

if you are here you are interested in:
- Using Kubernetes
- Using Spinnaker
- Using a Cloud Iaas
- Not wanting to figure out how to set all that up yourself on some IaaS
- Just want to deploy containerized apps without all the fuss of doing all that set-up
- Or not worried about apps but want to see a packaging of various concepts together...

Oh, we have a solution for you!


## Prerequisites

1. Do you have a computer (Mac Preferred)
1. Do you have a Cloud Account?
1. Do you have [Terraform](https://www.terraform.io/) Installed?
1. Do you have [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) installed?
1. Tools for your target Iaas?
  1. [GCLOUD SDK](https://cloud.google.com/sdk/downloads)
  1. AWS CLI
  1. AZURE SDK

## Google Cloud Platform

 Future versions will also use *declarative pipelines*


### Procedure
1. Make sure you have followed the validation process described [here](./gcp/README.md)
1. git clone this repo (fork from your own if you like)
1. cd to the `gcp\terraform`
   1. optionally edit values in `env.sh`
1. Execute `terraform apply`
1. Go to the bathroom / lunch / another meeting
1. Hope for the best

When this is done you will create an SSH tunnel to Spinnaker. More details of this process is documted [here](./gcp/README.md)


## Amazon Web Services

1. I will throw our good friend @jpancoast-kenzan under the bus at https://github.com/kenzanlabs/spinnaker-terraform
1. Otherwise waiting on EKS like everyone else

## Azure

Coming...

## See Also

1. [Continuous Delivery with Spinnaker and Kubernetes](http://continuousdelivery.kenzan.com/)





