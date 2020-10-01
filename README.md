# Capstone Project for Udacity DevOps Nanodegree

This project fulfills the requirements of the Udacity DevOps Capstone Project. A web app is containerized and deployed to a kubernetes cluster. This webapp runs a simple apache site.

## :page_with_curl:  _Information on Some of the files_

**1)** `initial-setup.sh` - This file is the first file to look at when setting up this project. It installs the required packakages to make this project work such as Docker, Jenkins, Kubectl, eksctl, hadolint etc. Refer to the Medium article to see how and when it is used.

**2)** `kubernetes/` - This folder contains the kubernetes resource configuration files that will deploy the application image on AWS EKS using `kubectl` once configured properly.

**3)** `Jenkinsfile` - This file contains the definition of the stages in the pipeline. The stages in this project's pipeline are `Lint files`, `Building image`, `Upload Image to Docker hub`, `Remove Unused docker image`, `Update Kube Config` and `Deploy Updated Image to Cluster`.

**4)** `Makefile` - This file contains shell commands that can be executed using the `Make` linux tool.

**5)** `Dockerfile` - This file contains all the commands needed to assemble the app image.

**6)** `run_docker.sh` - This file contains the shell commands needed to build the image on docker locally and also run a container.

**7)** `run_kubernetes.sh` - This file contains the shell commands needed to deploy the app in a kubernetes cluster running locally.

**8)** `upload_docker.sh` - This file contains the shell commands needed to upload the docker image to docker hub.

## :page_with_curl:  _Deploying on Amazon EKS using a CI/CD pipeline_

**1)** A Jenkins server needs to be provisioned to setup your CI/CD pipeline. You can follow this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-18-04) to setup Jenkins on an Ubuntu Server. 

**2)** Once your server is provisioned, you'll need to install [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04), [ansible](https://www.techrepublic.com/article/how-to-install-ansible-on-ubuntu-server-18-04/), [hadolint](https://github.com/hadolint/hadolint), [pylint](https://www.pylint.org/) and install the latest [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

**3)** The reason for installing the latest AWS CLI is to have the EKS module available for you. Once you install the AWS CLI you might not be able to run AWS commands. You can source your bash profile to get it working:

__`❍ source ~/.bash_profile `__

**4)** With AWS CLI installed you can setup it up as the Jenkins User. Follow this [tutorial](https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-jenkins.html) to see how. This is to allow you run aws commands in your pipeline without getting errors. Also set up aws credentials on Jenkins dashboard.

**5)** You'll need to add the jenkins user to the sudoer group to enable it run ansible-playbooks. Follow this [tutorial](https://embeddedartistry.com/blog/2017/11/16/jenkins-running-steps-as-sudo/) to see how to. Note: This is not best practices standard.

**6)** You might need to [disable password request](https://stackoverflow.com/questions/17940612/authentication-error-in-jenkins-on-using-sudo) for the jenkins user for your pipeline to run smoothly. Note: This is not best practices standard.

**7)** Create [swap space](https://medium.com/@vahiwe/setting-up-openvino-in-the-cloud-b99599f157eb) on your server. I got an out of memory error after running ansible multiple times. This is only necessary if the `ansible-setup` branch is used.

**8)** One of the stages in the pipeline requires Docker login information. You can set this up in Jenkins credentials. Save it as the same name as the registryCredentials in the Jenkinsfile. Also edit the registry in the Jenkinsfile to match your repo on Docker hub.

**9)** Once all this is done you can start working on Jenkins. Install BlueOcean for a nice interface. Setup up your CI/CD pipeline and everything should run smoothly. Note your IAM user should have permissions to use EKS.

**10)** You might get blocked by RBAC policies while trying to access the cluster. Basically, RBAC policies set to restrict the resources you use and limits a few of your action. Visit this [link](https://www.edureka.co/community/34714/code-error-403-when-trying-to-access-kubernetes-cluster) to see how to resolve this. 

**11)** A command line tool 'sed' is used in updating the kubernetes configuration file in other to force the pods to update with the new image. The reason for this is that Kubernetes (wrongly) considers Docker tags as immutable (i.e., once a tag is set, it is never changed). The rolling update is also activated by the change in image name.   

## :page_with_curl:  _Local Docker and Kubernetes Setup_

To run this app using docker, a script has been attached that builds an image from the Dockerfile and spins up a container running the web app:

__`❍ ./run_docker.sh `__

There is also a script that uploads the Docker image to a designated repo. This should be edited before execution:

__`❍ ./upload_docker.sh `__

A script that deploys the Docker Image to a local Kubernetes Cluster is also available:

__`❍ ./run_kubernetes.sh `__

Please view the aforementioned scripts before running to understand the logic behind them.

__*Happy developing!*__
