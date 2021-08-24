# Jenkins Application

## Introduction
Builds and runs a containerized Jenkins application with configuration files.

## Getting Started
1. Create a project folder named `reliability-toolkit`
2. Clone `jenkins-repository`, `elastic-applications`, and `elastic-configurations` to the project folder
3. Create two namespaces, one for test (test-elastic-system), another for primary (elastic-system)
4. Copy the relevant Kubernetes config files to jenkins-application/conf/<env>-kube.config
5. Edit conf/secrets.properties file with your credentials and other settings
6. Run 'ansible-playbook setup-jenkins.yaml'
7. Jenkins will be automatically configured with the project pipelines and triggers
8. Access Jenkins in browser with address localhost:8080
9. Login using jenkins_user and jenkins_password specified in conf/secrets.properties

## Deploying Containerized Elastic Applications
1. Follow the steps in the `jenkins-application` repository to run containerized Jenkins
2. Login to the Jenkins interface
3. Trigger elastic-application pipeline
4. Wait for the pipeline to finish
5. Trigger elastic-configuration pipeline
6. Wait for the pipeline to finish
7. The pods will not run if the configurations are not yet deployed

### Includes the following
* Jenkins Dockerfile
* Jenkins tools
* Ansible script to setup Jenkins

