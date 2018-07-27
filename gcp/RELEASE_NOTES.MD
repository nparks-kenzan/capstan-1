# Google Cloud Platform RELEASE Notes


## 2018.q3.beta.gcp

- see previous release notes

## 2018.q2.alpha.gcp.dnstlsoauth

- Using `Hal deploy clean` with *advanced features* will result in loss of Kubernetes services that enable access to spinnaker without the ssh tunnel. Halyard does not know how via a subsequent `hal deploy apply` to redeploy the TLS endpoint configuration. To redeploy those services
  - ssh into the `halyard tunnel` instance and perform the following commands
  - `kubectl apply -f spin-deck-nodeport.yml`
  - `kubectl apply -f spin-gate-nodeport.yml`
  - `kubectl apply -f spinnaker-ingress.yml`
  -  You may also need to update DNS entries based on the reported ip of the re-created ingress controller
- see previous release notes


## 2018.q2.alpha.gcp.canary

- see previous release notes

## 2018.q2.alpha.gcp

- This version is about containers deploying to a container runtime. The GCP credentials for Spinnaker may (rather may not) support other GCP project manipulation that Spinnaker may actually support.
- When Capstan completes the provisioning process, The Jenkins and Spinnaker integration may not be functional. Spinnaker is connected with Jenkins with the Jenkins username/password combination. However, we need the username and API key for Jenkins. To get the API key for the admin user visit Visit http://your.jenkins.server/me/configure and select show API key. With the API key access the `halyard-tunnel` instance and execute 'hal config ci jenkins master edit jnks --password' and enter the API key when prompted for the password. if you perform `hal config ci jenkins master get jnks` it should echo the api key back to you. Perform a  `hal deploy apply` to update spinnaker. 