FROM gcr.io/cloud-builders/gcloud-slim as runtime
RUN apt-get update && apt-get install jq -y
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime