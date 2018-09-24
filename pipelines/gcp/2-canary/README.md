# Canary in the Coal Mine

This demonstrates how to use Spinnaker's new Automated Canary Analysis Service. 
You can read about it [here](https://medium.com/netflix-techblog/automated-canary-analysis-at-netflix-with-kayenta-3260bc7acc69) and [here](https://cloud.google.com/blog/products/gcp/introducing-kayenta-an-open-automated-canary-analysis-tool-from-google-and-netflix).

It is recommended that you read this entire document before proceding

## Setup Procedure

This depends on the *HelloAgain* app from previous pipeline steps. Make sure you have completed the previous pipeline exercices. 

This pipeline assumes previous trigger work and deployments where executed. 

### Disable previous "prod" pipeline

The canary pipeline will replace the existing prod pipeline. First, run the production pipeline and make sure that app deploys successfully. You can disable/delete this pipeline. 


### Deploy Canary Pipeline
This will replace the "prod" pipeline we just deployed earlier.  

### Create Analysis Configuration for Canary



## Run pipeline

This pipeline can take an hour to execute...because...the canary step is set to run for an hour. It is configured in `realtime` mode which requires enough real time to elapse for data capture. 

### Run it
 You can either manually run it or trigger the UAT pipeline. Explore the reports and metrics thate are displayed during/after pipeline execution

### Run it with some load

Since Canary is for *PRODUCTION* you need to create some load. You can use the gist to generate load for your application. If you have an http load generating utility point it at the production load balancer while the pipeline is running. If not use this gist to generate load.  

### Change the App

If you are using the same app add the following line:

`
BigDecimal[] val = new BigDecimal[100000];
Arrays.fill(val, BigDecimal.ZERO);
`

This will change the behavior of the application. commit the change and let the appropiate pipeline triggers to start the process. Run the previous mention load program when the canary enabled `PROD` pipeline runs. 

