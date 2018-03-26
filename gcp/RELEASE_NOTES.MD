# RELEASE Notes



## alpha.q2.2018

- When Capstan completes the provisioning process, The Jenkins and Spinnaker integration may not be functional. Spinnaker is connected with Jenkins with the Jenkins username/password combination. However, we need the username and API key for Jenkins. To get the API key for the admin user visit Visit http://your.jenkins.server/me/configure and select show API key. With the API key access the `halyard-tunnel` instance and execute 'hal config ci jenkins master edit jnks --password' and enter the API key when prompted for the password. if you perform `hal config ci jenkins master get jnks` it should echo the api key back to you. Perform a courtesy `hal deploy apply`. 