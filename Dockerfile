FROM jenkins/jenkins:jdk11

USER root

RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=arm64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN add-apt-repository \
       "deb [arch=arm64] https://download.docker.com/linux/ubuntu focal stable"

RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get install -y python3
RUN apt-get install -y python3-pip zip
RUN pip3 install kubernetes
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

USER jenkins

RUN mkdir -p ~/.docker/cli-plugins
RUN curl https://github.com/docker/scan-cli-plugin/releases/latest/download/docker-scan_linux_amd64 -L -s -S -o ~/.docker/cli-plugins/docker-scan
RUN chmod +x ~/.docker/cli-plugins/docker-scan

RUN jenkins-plugin-cli --plugins "blueocean:1.24.7"
RUN jenkins-plugin-cli --plugins "docker-workflow:1.26"
RUN jenkins-plugin-cli --plugins "configuration-as-code:1.51"
RUN jenkins-plugin-cli --plugins "credentials:2.5"
RUN jenkins-plugin-cli --plugins "matrix-auth:2.6.8"
RUN jenkins-plugin-cli --plugins "job-dsl:1.77"
RUN jenkins-plugin-cli --plugins "antisamy-markup-formatter:2.1"
RUN jenkins-plugin-cli --plugins "delivery-pipeline-plugin"
RUN jenkins-plugin-cli --plugins "build-pipeline-plugin"
RUN jenkins-plugin-cli --plugins "generic-webhook-trigger:1.75"
RUN jenkins-plugin-cli --plugins "pipeline-input-step:2.12"
