# Capstone Project for Udacity DevOps Nanodegree

This project fulfills the requirements of the Udacity DevOps Capstone Project. A web app is containerized and deployed to a kubernetes cluster. This webapp runs a sentiment analysis on tweets of a Twitter handle and gives feedback on sentiments over a period of time.

## :page_with_curl:  _Deploying on Amazon EKS using a CI/CD pipeline_

**1)** A Jenkins server needs to be provisioned to setup your CI/CD pipeline. You can follow this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-18-04) to setup Jenkins on an Ubuntu Server. 

**2)** Once your server is provisioned, you'll need to install [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04), [ansible](https://www.techrepublic.com/article/how-to-install-ansible-on-ubuntu-server-18-04/), [hadolint](https://github.com/hadolint/hadolint), [pylint](https://www.pylint.org/) and install the latest [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

**3)** The reason for installing the latest AWS CLI is to have the EKS module available for you. Once you install the AWS CLI you might not be able to run AWS commands. You can source your bash profile to get it working:

__`❍ source ~/.bash_profile `__

**4)** With AWS CLI installed you can setup it up as the Jenkins User. Follow this [tutorial](https://docs.aws.amazon.com/systems-manager/latest/userguide/automation-jenkins.html) to see how. This is to allow you run aws commands in your pipeline without getting errors. Also set up aws credentials on Jenkins dashboard.

**5)** You'll need to add the jenkins user to the sudoer group to enable it run ansible-playbooks. Follow this [tutorial](https://embeddedartistry.com/blog/2017/11/16/jenkins-running-steps-as-sudo/) to see how to. Note: This is not best practices standard.

**6)** You might need to [disable password request](https://stackoverflow.com/questions/17940612/authentication-error-in-jenkins-on-using-sudo) for the jenkins user for your pipeline to run smoothly. Note: This is not best practices standard.

**7)** Create [swap space](https://medium.com/@vahiwe/setting-up-openvino-in-the-cloud-b99599f157eb) on your server. I got an out of memory error after running ansible multiple times.

**8)** One of the stages in the pipeline requires Docker login information. You can set this up in Jenkins credentials. Save it as the same name as the registryCredentials in the Jenkinsfile. Also edit the registry in the Jenkinsfile to match your repo on Docker hub.

**9)** Once all this is done you can start working on Jenkins. Install BlueOcean for a nice interface. Setup up your CI/CD pipeline and everything should run smoothly. Note your IAM user should have permissions to use EKS.

**10)** The ansible playbook installs [eksctl](https://eksctl.io/), [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) and [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your jenkins server. These tools are needed for the creation, deployment and management of your cluster. The ansible script also goes ahead to create the cluster.

**11)** You might get blocked by RBAC policies while trying to access the cluster. Basically, RBAC policies set to restrict the resources you use and limits a few of your action. Visit this [link](https://www.edureka.co/community/34714/code-error-403-when-trying-to-access-kubernetes-cluster) to see how to resolve this. 

**12)** A command line tool 'sed' is used in updating the kubernetes configuration file in other to force the pods to update with the new image. The reason for this is that Kubernetes (wrongly) considers Docker tags as immutable (i.e., once a tag is set, it is never changed). The rolling update is also activated by the change in image name.   

## :page_with_curl:  _Local Docker and Kubernetes Setup_

To run this app using docker, a script has been attached that builds an image from the Dockerfile and spins up a container running the web app:

__`❍ ./run_docker.sh `__

There is also a script that uploads the Docker image to a designated repo. This should be edited before execution:

__`❍ ./upload_docker.sh `__

A script that deploys the Docker Image to a local Kubernetes Cluster is also available:

__`❍ ./run_kubernetes.sh `__

Please view the aforementioned scripts before running to understand the logic behind them.


## :page_with_curl:  _Setup Instructions for local testing_

**1)** Fire up your favourite console & clone this repo somewhere:

__`❍ git clone https://github.com/vahiwe/TwitterAnalysis.git`__

**2)** Enter this directory:

__`❍ cd TwitterAnalysis/model_setup`__

**3)** Install [python](https://www.python.org/) if not already installed and run this command to install python packages/dependencies:

__`❍ pip install -e . `__

**4)** Go back to previous directory:

__`❍ cd .. `__

**5)** Generate secret key for Django project [here](https://miniwebtool.com/django-secret-key-generator/) and input in `TwitterAnalysis/config.py` :

``` 
    KEY = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
```

**6)** Get your [Twitter Developer](https://developer.twitter.com/) credentials and input in `sentiment/config.py` :
```
    consumer_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 
    consumer_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    access_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 
    access_token_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 
```

**7)** Install spacy language model:

__`❍ python -m spacy download en `__

**8)** Run to create migrations for changes:

__`❍ python manage.py makemigrations`__

**9)** Run to apply those changes to the database:

__`❍ python manage.py migrate`__

**10)** Start the server to view the webapp:

__`❍ python manage.py runserver `__

**11)** Open your browser and type in this URL to view the webapp:

__`❍ http://127.0.0.1:8000/`__

__*Happy developing!*__
