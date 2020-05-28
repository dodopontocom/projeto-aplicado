#!/bin/bash
# GCLOUD VARIAVEIS GLOBAIS
export GCLOUD_PROJECT_ID="pa-igti"
export GCLOUD_JSON_KEY_PATH="${CIRCLE_WORKING_DIRECTORY}/cloud/credentials/credential.json"
export GCLOUD_PROJECT_BUCKET_NAME="terraform-backend-bucket"
export GCLOUD_PROJECT_BUCKET_PREFIX="terraform"
export GCLOUD_PROJECT_REGION="us-central1"
export GCLOUD_SA_NAME="devops-sa"
export GCLOUD_SA_EMAIL="${GCLOUD_SA_NAME}@${GCLOUD_PROJECT_ID}.iam.gserviceaccount.com"
# VARIAVEIS do Terraform
export TF_VAR_tf_backend_bucket_name="${GCLOUD_PROJECT_BUCKET_NAME}"
export TF_VAR_project_id="${GCLOUD_PROJECT_ID}"
export TF_VAR_region="${GCLOUD_PROJECT_REGION}"
export TF_VAR_key="${GCLOUD_JSON_KEY_PATH}"

export GOOGLE_APPLICATION_CREDENTIALS=${TF_VAR_key}

export TF_VAR_vpc_name="${GCLOUD_PROJECT_ID}-vpc"
export TF_VAR_subnet_name="${GCLOUD_PROJECT_ID}-subnet"
export TF_VAR_firewall_name="${GCLOUD_PROJECT_ID}-firewall"
export TF_VAR_subnet_cidr="10.10.0.0/24"
export TF_VAR_machine_type="n1-standard-4"
export TF_VAR_zone="${GCLOUD_PROJECT_REGION}-a"
export TF_VAR_compute_instance_environment="dev"
export TF_VAR_ubuntu_image="ubuntu-os-cloud/ubuntu-1804-lts"
