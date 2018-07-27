# How to Contribute to Capstan

## Creating Issues

- Find something broken? No existing Github issue? Create a issue in Github
- When creating a github issue we have a simple naming scheme
  - `[partition/area name] : short title`
    - Current partitions/areas are:
      - Security = anything about authn/z crypto etc
      - GCP = anything about gcp integrations, especially via terraform
      - AWS = anything about AWS integrations, especially via terraform
      - AZURE = anything about AZURE integrations, especially via terraform
      - pipelines = changes updates regarding the sample pipelines
      - spinnaker = updates about spinnaker/halyard use that is not IaaS specific
      - capstan = global capstan changes
      - k8 = anything about the kubernetes set-up that is NOT IaaS specific
      - helm = anything about the helm charts used
    - example name:
      - `AWS: Create eks version`
- Did you fix something?
  - If there  is an issue make a PR that references the issue...make sure the issue describes the brokeness well.
  - If there is not an issue, thanks and just described what you fixed in your PR


## Code contributions

### Signal and Noise

*Dirty Development and Stable Master*

The latest and greatest code is always in Development. That does not mean that development always works. Master works as described in the related platform readme and release notes. Thusly, master will always (finger quotes) work. 

### Fork and PR

- Fork from development to get the latest and greatest code to perform fixes and additions
- Perform PR(s) that merge back into development
- if possible reference an existing issue that is addressed


## Releases and Tags

How are tags and releases used?

- *Releases* in Github are always based on tags on master
- Development should have the same features as master at every *release*



