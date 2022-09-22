#!/bin/bash -
#title          :entrypoint.sh
#description    :This script build image with multiple option and push the image to Google Artifact Registry.
#author         :João Alves<batistadasilvaalvesjoao@gmail.com>
#date           :20220921
#version        :0.0.1
#usage          :./entrypoint.sh
#notes          :Required env values are: INPUT_IMAGE_NAME, INPUT_CREDENTIALS_IN_TEXT
#                Optional env values are: INPUT_IMAGE_TAG,INPUT_DOCKERFILE,INPUT_TARGET,INPUT_CONTEXT,INPUT_BUILD_ARGS
#bash_version   :1.0(1)-release
###################################################

set -e
echo "${INPUT_CREDENTIALS_IN_TEXT}" | base64 -d > "${HOME}/credentials.json"

CREDENTIALS=$(cat "${HOME}/credentials.json");
PROJECT_ID=$(jq -r '.project_id' <<< "$CREDENTIALS")
INPUT_GCLOUD_ACCOUNT=$(jq -r '.client_email' <<< "$CREDENTIALS")

gcloud auth activate-service-account --key-file="${HOME}/credentials.json"
gcloud config set account "${INPUT_GCLOUD_ACCOUNT}";
gcloud config set project "${PROJECT_ID}" --quiet;

gcloud artifacts repositories list

echo "Authenticating in gcloud ...";



