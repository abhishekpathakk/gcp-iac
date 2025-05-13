#!/bin/bash
gcloud secrets versions access latest --secret=tf-sa-key > /tmp/terraform-sa-key.json
