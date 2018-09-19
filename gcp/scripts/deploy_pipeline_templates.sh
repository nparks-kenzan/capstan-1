#!/usr/bin/env bash

# Future versions will curl Spinnaker healthcheck endpoint

#echo "Waiting on Spinnaker to be ready for pipeline templates..."
#sleep 60
#hal deploy connect &
#sleep 60
roer -v pipeline-template publish pipelines/example-template.yml
#kill $(jobs -p)
