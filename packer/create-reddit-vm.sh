#!/bin/bash
gcloud compute instances create reddit-app --boot-disk-size=10GB --image reddit-base-1589544589 --image-project=shikanov-project --machine-type=g1-small --tags puma-server --restart-on-failure --zone=europe-west4-a
