#!/bin/bash
# GCLOUD VARIAVEIS GLOBAIS
export GCLOUD_PROJECT_ID="pa-igti"
export GCLOUD_JSON_KEY_PATH="${CIRCLE_WORKING_DIRECTORY}/cloud/credentials/credential.json"
export GOOGLE_APPLICATION_CREDENTIALS="${GCLOUD_JSON_KEY_PATH}"
export GCLOUD_PROJECT_BUCKET_NAME="terraform-backend-bucket"
export GCLOUD_PROJECT_BUCKET_PREFIX="terraform"
export GCLOUD_PROJECT_REGION="us-central1"
export GCLOUD_SA_NAME="devops-sa"
export GCLOUD_SA_EMAIL="${GCLOUD_SA_NAME}@${GCLOUD_PROJECT_ID}.iam.gserviceaccount.com"
# VARIAVEIS do Terraform-gcp
export TF_VAR_tf_backend_bucket_name="${GCLOUD_PROJECT_BUCKET_NAME}"
export TF_VAR_project_id="${GCLOUD_PROJECT_ID}"
export TF_VAR_region="${GCLOUD_PROJECT_REGION}"
export TF_VAR_key="${GCLOUD_JSON_KEY_PATH}"
export TF_VAR_vpc_name="${GCLOUD_PROJECT_ID}-vpc"
export TF_VAR_subnet_name="${GCLOUD_PROJECT_ID}-subnet"
export TF_VAR_firewall_name="${GCLOUD_PROJECT_ID}-firewall"
export TF_VAR_subnet_cidr="10.10.0.0/24"
export TF_VAR_machine_type="n1-standard-4"
export TF_VAR_zone="${GCLOUD_PROJECT_REGION}-a"
export TF_VAR_devops_sa_email="${GCLOUD_SA_EMAIL}"
export TF_VAR_compute_instance_environment="dev"
export TF_VAR_ubuntu_image="ubuntu-os-cloud/ubuntu-1804-lts"
export TF_VAR_centos_image="centos-cloud/centos-7"
export TF_VAR_centos_startup_script="${CIRCLE_WORKING_DIRECTORY}/cloud/scripts/openldap-server.sh"
#AWS VARIAVEIS GLOBAIS
export AWS_REGION="us-east-2"
export aws_ubuntu_ami_id="ami-013de1b045799b282"
export aws_instance_type="t2.micro"
export aws_aval_zone="${AWS_REGION}a"
export aws_cidr_block="172.16.0.0/16"
export aws_subnet_cidr_block="172.16.0.0/16"
export aws_bucket_name="projeto-aplicado"
export aws_bucket_key="terraform"
# VARIAVEIS do Terraform-aws
export TF_VAR_aws_ubuntu_ami_id="${aws_ubuntu_ami_id}"
export TF_VAR_aws_instance_type="${aws_instance_type}"
export TF_VAR_aws_aval_zone="${aws_aval_zone}"
export TF_VAR_aws_cidr_block="${aws_cidr_block}"
export TF_VAR_aws_subnet_cidr_block="${aws_subnet_cidr_block}"
export TF_VAR_aws_region="${AWS_REGION}"
export TF_VAR_aws_bucket_name="${aws_bucket_name}"
export TF_VAR_aws_bucket_key="${aws_bucket_key}"
