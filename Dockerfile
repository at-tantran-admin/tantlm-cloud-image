FROM alpine:latest

LABEL maintainer asiantechvn

ENV TERRAFORM_VERSION=0.12.8
ENV AWS_CLI_VERSION=1.16.237
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories
RUN apk -U add \
    docker \
    ca-certificates \
    git \
    openssh \
    bash \
    dash \
    python3 \
    curl \
    groff \
    wget && \
    curl -o /usr/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x /usr/bin/jq && \
    pip3 install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip -d /bin && \
    rm -f terraform.zip
# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
