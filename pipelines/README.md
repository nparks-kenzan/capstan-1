# Pipeline Templates

These templates are meant to help you explore some of the capabilities of Spinnaker Pipelines.

You can read more about Pipeline Templates [**here**](https://github.com/spinnaker/dcd-spec/blob/master/PIPELINE_TEMPLATES.md).


## Getting Started

By now you should have an SSH tunnel running with access to your deployment of Spinnaker.

In a new terminal connect to your `halyard-tunnel` instance:

```bash
$ gcloud compute --project "[PROJECT_NAME]" ssh --zone "[ZONE]" "[INSTANCE_NAME]"
```

We are going to publish our template using [**roer**](https://github.com/spinnaker/roer). It should already be installed and configured on the instance.

```bash
$ roer pipeline-template publish ./path/to/template.yml
```

There are instructions for each template on how to create a template based pipeline in each template's respective directory.

It is recommended you start with `generic/` before moving on to more advanced, provider specific templates located in the other directories (like `gcp/`).


## Further reading

* [Spinnaker Pipeline Template Spec](https://github.com/spinnaker/dcd-spec/blob/master/PIPELINE_TEMPLATES.md)
* [roer](https://github.com/spinnaker/roer) - Spinnaker Pipeline CLI
