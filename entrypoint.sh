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

echo "Authenticating in gcloud ...";

if(python3 parse.py "${INPUT_CREDENTIALS_IN_TEXT}");then
  echo "Logged into google cloud ...";

  CREDENTIALS=$(cat credentials.json);
  PROJECT_ID=$(jq -r '.project_id' <<< "$CREDENTIALS")
  INPUT_GCLOUD_ACCOUNT=$(jq -r '.client_email' <<< "$CREDENTIALS")

  echo "Authenticating in gcloud with...";
  echo "Account Email: ${INPUT_GCLOUD_ACCOUNT}";
  echo "Project ID: ${PROJECT_ID}";

  gcloud config set project "${PROJECT_ID}";
  gcloud config set account "${INPUT_GCLOUD_ACCOUNT}";
  gcloud auth activate-service-account "${INPUT_GCLOUD_ACCOUNT}" --key-file=credentials.json

  if gcloud artifacts repositories list; then
    echo "GCP login success...";

  else
    echo "GCP login failed. Exiting ...";
    exit 1
  fi
else
  echo "Error parsing credentials";
  exit 1;
fi



