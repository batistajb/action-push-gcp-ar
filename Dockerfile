FROM debian:10-slim

RUN apt-get update && apt-get install apt-transport-https ca-certificates gnupg curl python3 -y

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN  apt-get update && apt-get install google-cloud-cli jq -y

WORKDIR /docker

COPY . .

RUN chmod +x entrypoint.sh
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/docker/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]