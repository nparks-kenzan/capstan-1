# Adding Jenkins to Spinnaker

Capstan is centered around the Cloud and Containers. Thusly, the IaaS configurations for Spinnaker are such that IaaS build tools can work with Spinnaker. However, if you still want to use Jenkins at the CI solution this document describes how to get jenkins in the cluster and configure Spinnaker to use Jenkins

## Install Jenkins

From the tools instance you can use helm to install jenkins
- helm install stable/jenkins --name ci --namespace jenkins --replace --wait

Since the `-wait` flag is present the command returns when everything is running and not just deployed. The output should get you the LoadBalancer for jenkins plus commands to obtain the admin login. 

Attempt to Login. 


## Post Install Jenkins Set-up

After Jenkins is installed and you can login you will need to update the Jenkins Kubernetes plugin. (please be advised change changes to the plugin and jenkins may impact the following steps)

1. In the Jenkins UI, Click `Credentials` on the left
1. Click the “(global)” link
1. Click “Add Credentials” on the left
1. From the “Kind” dropdown, select “Kubernetes Service Account”
1. Click “OK”
   1. You should get a name generated that looks like a GUID
1. Navigate to `Manage Jenkins` and then `configure system`
1. Scroll to cloud / Kubernetes settings
1. Locate the `Credentials` dropdown and select the GUID name
1. Save
1. DONE

## Associate Spinnaker with Jenkins

To have Spinnaker able to run Jenkins Jobs perform the following two actions

1. Get a Jenkins user API Key
2. Update Spinnaler with Jenkins API Key

### Get Jenkins API Key



When Capstan completes the provisioning process, The Jenkins and Spinnaker integration may not be functional. Spinnaker is connected with Jenkins with the Jenkins username/password combination. However, we need the username and API key for Jenkins. To get the API key for the admin user visit Visit http://your.jenkins.server/me/configure and select show API key. With the API key access the `halyard-tunnel` instance and execute 'hal config ci jenkins master edit jnks --password' and enter the API key when prompted for the password. if you perform `hal config ci jenkins master get jnks` it should echo the api key back to you. Perform a  `hal deploy apply` to update spinnaker. 

### Update Spinnaker

From the Tools instance run the following shell commands. You need the username and API key from the Jenkins user Spinnaker will use to login to Jenkins

- JENKINS_HELM_RELEASENAME=ci
- JENKINS_NAMESPACE=jenkins
- JENKINS_PORT=8080
- JENKINS_ADMIN_USER=[user name you got api key from]
- JENKINS_PW=[api key from a jenkins user]
- JENKINS_IP="http://$JENKINS_HELM_RELEASENAME-jenkins.$JENKINS_NAMESPACE:$JENKINS_PORT"

- H_CMD="hal config ci jenkins master add jenkins --address $JENKINS_IP --username $JENKINS_ADMIN_USER --password"
- echo $JENKINS_PW | $H_CMD
- hal config ci jenkins enable

Those commands configured spinnaker with a new jenkins master nameed `jenkins`

To apply the changes to spinnaker

- hal deploy apply

This essentially respins Spinnaker