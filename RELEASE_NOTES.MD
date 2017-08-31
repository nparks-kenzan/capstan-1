# RELEASE Notes



## Alpha 2017 Q4

- Creates GKE with Jenkins and Spinnaker Deployed into said cluster
- Uses Google's guidance for creating Jenkins in GKE
- BUG [Jenkins Password not being set](https://github.com/kenzanmedia/capstan/issues/18)
  - Most of the build time is spent creating a jenkins you can't log into

## Beta 2017 Q4

- #27 not resolved. You will need to use the halyard-tunnel instances to running the following command: 'hal config ci jenkins master edit jnks --password'. It will prompt for a password but that is a lie. You need the obtain the api key for the `admin` user. Visit `http://your.jenkins.server/me/configure` and select show API key. When you have successfully updated the password (oops api key) if you perform `hal config ci jenkins master get jnks` it should echo the api key back at you. 