#!/bin/bash
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family=reddit-full --image-project=serious-unison-288814 --machine-type=f1-micro --tags puma-server --restart-on-failure

